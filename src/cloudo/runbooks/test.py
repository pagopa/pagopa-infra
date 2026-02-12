#!/usr/bin/env python3
"""
Test script that demonstrates basic Python functionality.
Contains simple mathematical operations and string output.
"""

import argparse
import json
import sys
import time


def fibonacci(n: int) -> int:
    if n < 0:
        raise ValueError("n must be >= 0")
    if n < 2:
        return n
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(
        description="Simple Fibonacci load: compute Fibonacci(n) repeatedly."
    )
    parser.add_argument("-n", type=int, default=5000, help="Fibonacci index n (>= 0)")
    parser.add_argument(
        "--repeats", type=int, default=5, help="How many times to compute (default: 5)"
    )
    args = parser.parse_args(argv)

    if args.repeats <= 0:
        print(
            "RESULT:", json.dumps({"status": "error", "message": "repeats must be > 0"})
        )
        return 1

    times = []
    value = None
    t0 = time.perf_counter()
    for _ in range(args.repeats):
        r0 = time.perf_counter()
        value = fibonacci(args.n)
        times.append((time.perf_counter() - r0) * 1000.0)
    total_ms = (time.perf_counter() - t0) * 1000.0
    avg_ms = sum(times) / len(times)

    result = {
        "status": "ok",
        "n": args.n,
        "repeats": args.repeats,
        "value": value,
        "elapsed_ms_total": round(total_ms, 3),
        "elapsed_ms_avg": round(avg_ms, 3),
    }
    print("RESULT:", json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
