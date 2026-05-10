# Chronos

Chronos is a watchOS application written in Objective-C for Apple Watch. It lets you define reusable timer presets made of ordered steps (work or pause segments with custom durations and labels), run them from your wrist with a short countdown, and hear audio cues as the session progresses.

The Xcode workspace ships two targets: a minimal iOS container app named **Chronos** that embeds the Watch binary, and the **Chronos Watch App** WatchKit extension where the user-facing logic lives.

## Features

- **Presets**: Name and collect ordered steps into a preset; the main screen lists presets or shows an empty state when none exist.
- **Steps**: Each step has a type (`work` or `pause`), a duration in seconds, and a display name. Presets expose helpers to append steps and compute total duration.
- **Timer session**: Selecting a preset opens the timer interface: a three-second countdown, then sequential execution of each step with a running MM:SS display on the watch.
- **Audio feedback**: Bundled `.caf` assets play during countdown ticks, when a work or pause step starts, and when the preset completes (`Chronos Watch App/Audios/`).
- **Storyboard-driven UI**: Screens and row types are wired through `Interface.storyboard`; controllers live under `Chronos Watch App/View/`.

## Requirements

- macOS with **Xcode** installed (version aligned with the watchOS SDK referenced in `Chronos.xcodeproj`, currently WatchKit against a recent watchOS SDK).
- An Apple Watch simulator or a paired physical Apple Watch for on-device testing.

## Getting started

1. Clone this repository.
2. Open `Chronos.xcodeproj` in Xcode.
3. Select the **Chronos Watch App** scheme and your desired Watch simulator or device run destination.
4. Build and run. Xcode builds the Watch extension; the container **Chronos** target embeds it for installation.

If the Run destination list does not show a Watch pair, add a Watch simulator from Xcode’s Devices and Simulators window or pair a physical Watch with your iPhone.

## Repository layout

| Path | Purpose |
|------|---------|
| `Chronos.xcodeproj/` | Xcode project, schemes, and build settings for the container and Watch targets. |
| `Chronos Watch App/` | WatchKit extension sources, `Interface.storyboard`, localized strings (`Base.lproj`, `mul.lproj`), assets, and audio resources. |
| `Chronos Watch App/Model/` | Domain types `TimerPreset` and `TimerStep`. |
| `Chronos Watch App/View/` | `WKInterfaceController` subclasses for the main list, rows, add flows, and the active timer. |
| `Chronos Watch App-Bridging-Header.h` | Bridging header placeholder at the project root for mixed-language builds if you extend with Swift later. |

## Architecture notes

- **Language**: Objective-C with WatchKit (`WKInterfaceController`, `WKInterfaceTable`, etc.).
- **State**: Presets are held in memory on `MainInterfaceController` (`NSMutableArray<TimerPreset *>`). There is no Core Data or file persistence in the current codebase; restarting the app clears user-created presets unless you add storage.
- **Navigation**: Presents `AddPresetScreen` with a completion block in context; pushing `TimerInterfaceController` passes the selected `TimerPreset`.
- **Timer implementation**: `TimerInterfaceController` uses `NSTimer` for both countdown and per-step countdown, advances `currentStepIndex`, and plays sounds via `AVAudioPlayer` when loading bundle resources.

## Localization

String catalogs and storyboard localizations live under `Chronos Watch App/Base.lproj/` and `Chronos Watch App/mul.lproj/`. Some user-visible strings in controllers or storyboards may still be Portuguese (for example completion copy on the timer screen); adjust there if you need full English UI.

## Contributing and license

There is no explicit open-source license in this repository yet. Add a `LICENSE` file before redistributing or accepting external contributions.

When proposing changes, prefer small commits that follow [Conventional Commits](https://www.conventionalcommits.org/) (for example `feat:`, `fix:`, `chore:`, `docs:`) so history stays easy to scan.
