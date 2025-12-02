# ColourTogether

A Flutter sketch of a "ColourTogether" room-based colouring experience. Users join a room with an invite code, see predefined zones laid out on a shared grid, and tap to fill each area with a palette colour. Future versions can swap the static zones for edge-detected maps coming from a middle server.

## Features

- Lobby with invite-code entry and sample room cards (Sunset Courtyard & Coastal Mosaic).
- Grid-based canvas that displays clearly bounded, tappable zones.
- Shared palette chips, tap to fill, long-press to clear, and a quick reset.
- Zone legend with per-area controls, completion progress, and grid overlay toggle.
- Material 3 styling with helpful context hints describing how rooms behave.

## Running

Ensure the Flutter SDK is available on your path, then:

```bash
cd colourtogether
flutter run
```

Use the demo code `SUNSET-123` to jump into the sample layout right away.
