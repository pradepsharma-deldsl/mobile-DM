# Secure Docs Mobile v2.1 — Complete Android Source

A fully local Flutter/Android document vault. No backend server is required.

## Implemented modules

- First-run PIN/password setup and encrypted vault creation
- PBKDF2-HMAC-SHA256 local PIN/password verifier
- SQLCipher encrypted SQLite database
- Database key stored via `flutter_secure_storage` (Android Keystore-backed storage)
- Optional biometric unlock
- Android power-saver mode enabled by default (reduced image dimensions/quality and debounced database search)
- Searchable document-type picker when adding or editing a document
- Material 3 interactive UI with searchable bottom sheets, cards, chips and responsive controls
- Automatic relock after the app has been in the background
- Manual Lock Now action
- Document Type add/edit/delete with safe delete restriction and instant search
- Add documents with owner, type, unique reference and **1–5 required pictures**
- Gallery multi-select and camera capture, hard-limited to 5 pictures per document
- Pictures stored as BLOBs inside SQLite
- SHA-256 integrity digest stored per picture
- Document list with debounced search and type filter
- Document details and full-screen zoomable image viewer
- Edit owner/type
- Add more pictures to an existing document
- Remove pictures while always keeping at least 1 picture
- Reorder pictures
- Delete document with confirmation (images cascade-delete)
- Change PIN/password without re-encrypting the database
- Biometric enable/disable with biometric verification
- Vault statistics
- Password-encrypted portable backup using AES-256-GCM + PBKDF2
- Restore backup with validation and temporary rollback copy

## Android power & efficiency

- No background service, polling loop, wake lock or periodic sync is used.
- Power Saver is ON by default and can be toggled in Settings.
- With Power Saver ON, newly selected/captured pictures are resized to at most 1600×1600 at quality 68 before encrypted storage.
- Document search waits briefly after typing instead of querying SQLite on every keystroke.
- Document-type search is performed locally in memory.

## Android security configuration

- `android:allowBackup="false"`
- cleartext traffic disabled
- camera and biometric permissions included
- `FlutterFragmentActivity` used for `local_auth`
- SQLCipher ProGuard keep rules included
- minimum Android SDK 23

## Build

This source package contains all application and Android configuration files. The only binary file not bundled by this environment is Gradle's generated `gradle-wrapper.jar`. Two bootstrap scripts are included to generate that standard file from your installed Flutter SDK without changing the app source.

### Windows

Double-click or run:

```bat
setup_windows.bat
flutter run
```

### Linux/macOS

```bash
./setup_linux_macos.sh
flutter run
```

For release:

```bash
flutter build apk --release
```

Before Play Store/production distribution, replace the debug signing configuration in `android/app/build.gradle` with your release keystore configuration.

## Backup behavior

Backups use the `.sdbak` extension. The backup contains the SQLCipher database and its database key, but the whole payload is encrypted with AES-256-GCM using a separate backup password derived with PBKDF2. The app cannot recover a forgotten backup password.

## Important

The project intentionally does not use a cloud backend. The Android share sheet is used only when the user explicitly exports an encrypted backup; the user decides where that backup is saved/shared.
