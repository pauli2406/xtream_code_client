# Demo Module

`demo.dart` contains a complete request flow that is invoked by the Flutter
example app (`example/lib/main.dart`).

## What It Demonstrates

- legacy singleton initialization
- categories, streams, VOD, and series requests
- EPG calls and URL helper generation
- cleanup via `XtreamCode.instance.dispose()`

## Run Path

This file is not a standalone CLI entrypoint.
Run the demo through the example app:

```bash
cd example
flutter run
```

## Migration Note

This demo intentionally uses deprecated legacy APIs for migration comparison.
For v2-first integration examples, see `../../docs/getting-started.md`.
