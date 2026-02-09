# Legacy APIs

Legacy APIs remain exported for migration compatibility in v2 and are deprecated.

## Legacy Entry Points

- `XtreamCode` (singleton initializer)
- `XtreamCodeClient` (legacy method signatures)
- Legacy `XTremeCode*` model classes

## Support Expectations

- Legacy wrappers delegate internally to v2 parsing/client logic.
- Behavior is maintained for compatibility, but new features are added on v2 APIs.
- Legacy surfaces may be removed in a future major version.

## Preferred Usage

Use `XtreamClient` for all new code.

If you must keep legacy APIs temporarily:

1. Keep wrapper usage isolated in a narrow adapter layer.
2. Migrate callers incrementally to v2 methods.
3. Validate behavior with tests during each migration step.

## Deprecation Notes

`XtreamCode` and `XtreamCodeClient` are marked with `@Deprecated` annotations and include migration guidance in dartdoc comments.
