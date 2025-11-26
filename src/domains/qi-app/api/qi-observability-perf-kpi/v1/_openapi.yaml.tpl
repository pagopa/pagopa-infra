openapi: 3.0.1
info:
  title: qi-observability-perf-kpi
  description: API for monitoring performance KPIs.
  version: 0.8.12
servers:
  - url: https://api.dev.platform.pagopa.it/qi/perf-kpi-bdi/v1
    description: Development environment
  
  - url: https://api.uat.platform.pagopa.it/qi/perf-kpi-bdi/v1
    description: UAT (User Acceptance Testing) environment
  
  - url: https://api.platform.pagopa.it/qi/perf-kpi-bdi/v1
    description: Production environment
tags:
  - name: observability-bdi
    description: APIs for BDI and observability
paths:
  /info:
    get:
      tags:
        - observability-bdi
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
        '401':
          description: Unauthorized. Authentication required or invalid credentials.
        '500':
          description: Internal server error.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
  /perf-data:
    post:
      tags:
        - observability-bdi
      summary: Collect Performance Data (POST)
      description: "Collect performance KPI data for a specific interval and KPI ID.  \nIf no dates are provided, defaults to the previous month.  \nIf no KPI ID is provided, collects all KPIs.\n"
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
          description: KPI ID to collect. Default is ALL.
          schema:
            type: string
            enum:
              - PERF-01
              - PERF-02
              - PERF-02E
              - PERF-03
              - PERF-04
              - PERF-05
              - PERF-06
              - ALL
        - name: saveData
          in: query
          required: false
          description: Tells if the calculated data will be saved on DB
          schema:
            type: string
            enum:
              - true
              - false
      responses:
        '200':
          description: Successful KPI data collection response.
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    example: OK
                  message:
                    type: string
                    example: "Processed interval: 2025-03-01 00:00:00 to 2025-03-01 23:59:59"
                  details:
                    type: string
                    example: "KPI: [PERF-01] value: [123]"
              examples:
                All KPIs:
                  summary: All KPI data collected successfully.
                  value:
                    status: OK
                    message: "Processed interval: 2025-03-01 00:00:00 to 2025-03-01 23:59:59"
                    details: "KPI: [ALL] values: [100 | 1000 | 5 | 300 | 400 | 600 | 700]"
                Single KPI:
                  summary: Single KPI collected successfully.
                  value:
                    status: OK
                    message: "Processed interval: 2025-03-01 00:00:00 to 2025-03-01 23:59:59"
                    details: "KPI: [PERF-01] value: [100]"
        '401':
          description: Unauthorized. Authentication required or invalid credentials.
        '500':
          description: Internal server error. The system encountered an unexpected issue during data collection. This response provides details about the error for debugging purposes.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
              examples:
                Internal Server Error:
                  summary: Unexpected internal server error
                  value:
                    status: "500 INTERNAL_SERVER_ERROR"
                    message: "CollectPerformanceData - HTTP triggered. Error: NullPointerException"
                    details: "CollectPerfData - Error: NullPointerException at line 42"
  /quarter/{quarter}:
    post:
      tags:
        - observability-bdi
      summary: KPI Aggregation by Quarter and publish to Event Hub
      description: |
        Collect aggregated KPI data for a specific quarter or the last quarter.
        This operation triggers the calculation of KPI averages and sends them to the Event Hub.
      parameters:
        - name: quarter
          in: path
          required: true
          description: Quarter identifier.
          schema:
            type: string
            enum:
              - Q1
              - Q2
              - Q3
              - Q4
              - LAST
        - name: year
          in: query
          required: false
          description: Year for the specified quarter. Defaults to the current year.
          schema:
            type: string
      responses:
        '200':
          description: |
            KPI data aggregated and published successfully.

            **Response fields**:

            - `status`: Result status of the operation. `"OK"` in case of success.
            - `message`: Human-readable summary of the executed operation.
            - `data`: Array of aggregated KPI strings, one for each month of the selected quarter.

            Each string contains KPI values in the following order (comma-separated):

            `PERF-01, PERF-02, PERF-02E, PERF-03, PERF-04, PERF-05, PERF-06`

            Example:
            ```
            [
              "100.00,667316,73159,172,185,540,214",
              "100.00,682656,80568,175,137,577,1584",
              "100.00,2366812,166507,171,119,392,131"
            ]
            ```
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    example: OK
                  message:
                    type: string
                    example: PerKpiAggregator - Processed quarter 2025/Q1
                  data:
                    type: array
                    description: |
                      Array containing aggregated KPI results for each month of the selected quarter.
                      Each item is a comma-separated string of KPI values in this order:

                      `PERF-01, PERF-02, PERF-02E, PERF-03, PERF-04, PERF-05, PERF-06`
                    items:
                      type: string
                      example: "100.00,667316,73159,172,185,540,214"
              examples:
                Aggregated KPIs for Q1:
                  summary: Aggregated KPIs for Q1 2025
                  value:
                    status: OK
                    message: PerKpiAggregator - Processed quarter 2025/Q1
                    data:
                      - "100.00,667316,73159,172,185,540,214"
                      - "100.00,682656,80568,175,137,577,1584"
                      - "100.00,2366812,166507,171,119,392,131"
        '400':
          description: Bad request due to invalid quarter or year.
        '500':
          description: Internal server error. The system encountered an unexpected issue during data collection or sending to Event Hub.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
components:
  schemas:
    ErrorResponse:
      type: object
      properties:
        status:
          type: string
          description: The HTTP status code with description.
          example: 500 INTERNAL_SERVER_ERROR
        message:
          type: string
          description: A high-level summary of the error.
          example: "CollectPerformanceData - HTTP triggered. Error: NullPointerException"
        details:
          type: string
          description: More detailed technical information about the error.
          example: "CollectPerfData - Error: NullPointerException at line 42"
