openapi: 3.0.1
info:
  title: qi-observability-perf-kpi
  description: API for monitoring performance KPIs.
  version: 1.0.0
servers:
  - url: https://${hostname}
tags:
  - name: bdi
  - name: observability
paths:
  /perfData:
    get:
      summary: Collect Performance Data
      description: Collect KPI performance data based on given parameters.
      parameters:
        - name: startDate
          in: query
          required: false
          description: Start date in 'yyyy-MM-dd HH:mm:ss' format.
          schema:
            type: string
            format: date-time
        - name: endDate
          in: query
          required: false
          description: End date in 'yyyy-MM-dd HH:mm:ss' format.
          schema:
            type: string
            format: date-time
        - name: kpiId
          in: query
          required: false
          description: KPI ID to collect. Default is ALL_KPI.
          schema:
            type: string
      responses:
        '200':
          description: Successful response with KPI data.
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                  message:
                    type: string
                  details:
                    type: string
        '500':
          description: Internal server error.
    post:
      summary: Collect Performance Data (POST)
      description: Same as GET but allows POST requests.
      parameters:
        - name: startDate
          in: query
          required: false
          description: Start date in 'yyyy-MM-dd HH:mm:ss' format.
          schema:
            type: string
            format: date-time
        - name: endDate
          in: query
          required: false
          description: End date in 'yyyy-MM-dd HH:mm:ss' format.
          schema:
            type: string
            format: date-time
        - name: kpiId
          in: query
          required: false
          description: KPI ID to collect. Default is ALL_KPI.
          schema:
            type: string
      responses:
        '200':
          description: Successful response with KPI data.
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                  message:
                    type: string
                  details:
                    type: string
        '500':
          description: Internal server error.

  /info:
    get:
      summary: Application Info
      description: Retrieve information about the application.
      responses:
        '200':
          description: Application information.
          content:
            application/json:
              schema:
                type: object
                properties:
                  version:
                    type: string
                  environment:
                    type: string
                  name:
                    type: string
        '500':
          description: Internal server error.

  /quarter/{quarter}:
    get:
      summary: KPI Aggregation by Quarter
      description: Retrieve aggregated KPI data for a specific quarter or the last quarter.
      parameters:
        - name: quarter
          in: path
          required: true
          description: Quarter identifier (e.g., Q1, Q2, Q3, Q4, or LAST).
          schema:
            type: string
        - name: year
          in: query
          required: false
          description: Year for the specified quarter. Defaults to the current year.
          schema:
            type: string
      responses:
        '200':
          description: Aggregated KPI data for the specified quarter.
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                  message:
                    type: string
                  data:
                    type: array
                    items:
                      type: string
        '400':
          description: Bad request due to invalid quarter or year.
        '500':
          description: Internal server error.
