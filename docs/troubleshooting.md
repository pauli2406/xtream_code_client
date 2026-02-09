# Troubleshooting

## Unexpected Payload Shapes

Symptom:

- Endpoint expected a list/object but server returned a different shape (`null`, string, map/list mismatch).

Behavior:

- In lenient mode, parser returns fallback empty structures where possible and emits warnings.
- In strict mode, parser throws.

Action:

- Inspect `ApiResult.warnings` and `jsonPath` values.
- Keep strict mode for controlled environments/tests.

## Date/Time Parsing Issues

Symptom:

- Server sends mixed date formats (`epoch`, ISO, `yyyy-MM-dd HH:mm:ss`) in the same endpoint.

Behavior:

- v2 accepts mixed formats and normalizes to UTC.
- Invalid values become `null` in lenient mode with warnings.

Action:

- Use nullable handling in your app.
- Enable strict mode if invalid dates must fail requests.

## Alias Conflicts

Symptom:

- Multiple alias fields exist with conflicting values (for example `release_date` and `releasedate`).

Behavior:

- Parser applies fixed priority and emits conflict warnings.

Action:

- Use warning logs to identify problematic providers.
- If necessary, pre-normalize payload upstream before passing to app code.

## Boolean/Number Coercion

Symptom:

- Fields arrive as strings (`"1"`, `"4.5"`) instead of native types.

Behavior:

- v2 coercion supports mixed formats for booleans and numbers.

Action:

- Prefer v2 models over manually casting dynamic fields.

## Performance and UI Jank

Symptom:

- Frame drops while loading very large lists or XMLTV EPG.

Action:

1. Keep `BackgroundParsingMode.auto`.
2. Lower isolate thresholds (`jsonIsolateMinBytes`, `xmlIsolateMinBytes`).
3. Use `epgLite()` where full XMLTV detail is not required.
4. Benchmark with package scripts from [performance-tuning.md](performance-tuning.md).

## Request Failures

Symptom:

- HTTP status is non-200.

Behavior:

- Client throws `RequestException`.

Action:

- Inspect `requestUri`, credentials, and endpoint path configuration.
- Verify custom `EndpointConfig` path values and proxy rewriting rules.
