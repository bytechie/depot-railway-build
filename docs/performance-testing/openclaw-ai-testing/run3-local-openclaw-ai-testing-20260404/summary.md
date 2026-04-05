# OpenClaw Local Performance Test Results

Test Date: 2026-04-04 23:24:05

## Test Environment

- **Host**: WSL2 on Windows
- **Docker Version**: Docker version 28.4.0, build d8eb465
- **OpenClaw Commit**: f0c970fb43
- **Test Type**: Local Docker Build (GitHub Actions baseline comparison)

## Test Cases


## Results Summary

| Test Case | Description | Time | Expected Cache |
|-----------|-------------|------|----------------|
| Baseline | See description | m s | See above |
| Documentation | See description | m s | See above |
| Source File | See description | m s | See above |
| UI Component | See description | m s | See above |
| New Dependency | See description | m s | See above |
| Major Changes | See description | m s | See above |

## Log Files

Detailed logs for each test case:
- `baseline.log`
- `test-2-docs.log`
- `test-3-source.log`
- `test-4-ui.log`
- `test-5-dependency.log`
- `test-6-major.log`

## Notes

- These tests represent **local Docker build** times
- GitHub Actions times may vary due to:
  - Runner performance differences
  - Network conditions
  - Cache state
  - Concurrent workflows

- Depot CI is expected to be **4-8x faster** than these local baseline times.

## Comparison with Depot CI

Once Depot CI tests are run, compare:

| Test | Local Docker | Depot CI | Speedup |
|------|--------------|----------|---------|
| Baseline | ? min | ? sec | ?x |
| Docs | ? min | ? sec | ?x |
| Source | ? min | ? sec | ?x |
| UI | ? min | ? sec | ?x |
| Dependency | ? min | ? sec | ?x |
| Major | ? min | ? sec | ?x |

