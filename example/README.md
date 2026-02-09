# Example App

This package includes a Flutter example app that calls `demo()` from
`lib/demo/demo.dart` during app startup.

## Run

From the `example/` directory:

```bash
flutter pub get
flutter run
```

## Configure Credentials

Edit `lib/demo/demo.dart` and replace placeholder values for:

- `url`
- `port` (optional)
- `username`
- `password`

## API Style

The current demo uses legacy initialization (`XtreamCode.initialize`) for
migration visibility. For new projects, prefer direct v2 usage with
`XtreamClient`.

See package docs:

- `../docs/getting-started.md`
- `../docs/migration-v1-to-v2.md`
