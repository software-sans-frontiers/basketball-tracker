# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Basketball Shot Tracker - Android app for automatic basketball shot counting using computer vision. Currently in pre-implementation phase with complete technical specification.

## Technology Stack

- **Platform**: Android (SDK 35)
- **Language**: Kotlin
- **UI**: Jetpack Compose (latest)
- **Camera**: CameraX 1.3.1
- **ML**: LiteRT (formerly TensorFlow Lite) 2.16.1
- **Build**: Gradle 8
- **Dev Environment**: devenv.sh (Nix-based)

## Current Project State

**Pre-Development Phase**: Project contains specification only, no Android project structure or source code yet.

### Next Steps Required
1. Generate Android project structure via Android Studio (Empty Activity → Compose Activity)
2. Configure devenv.nix with Android tools (android-studio, android-tools, gradle_8, kotlin)
3. Implement walking skeleton as specified

## Development Commands

### Once Android Project is Set Up
```bash
# Build
./gradlew build

# Run unit tests
./gradlew test

# Run instrumentation tests
./gradlew connectedAndroidTest

# Lint checks
./gradlew lint

# Clean build
./gradlew clean

# Install on device
./gradlew installDebug

# Run specific test
./gradlew test --tests "com.example.basketballtracker.ShotDetectorTest"
```

### Development Environment
```bash
# Enter development shell
devenv shell

# Update dependencies
devenv update
```

## Architecture Overview

### Core Components

1. **Camera Module** (`CameraX`)
   - Continuous frame capture from fixed ground-level position
   - Image analysis pipeline for object detection

2. **Object Detection** (`LiteRT`)
   - Pre-trained COCO model (YOLOv8 mobile or MobileNet SSD)
   - Detects "sports ball" class - no custom training needed

3. **Shot Logic**
   - Detects ball entering frame from above (shot attempt)
   - Tracks trajectory frame-by-frame
   - Simplified by camera angle (no dribbling confusion)

4. **Make/Miss Classification**
   - Geometric approach using rim position
   - Define "make zone" around rim
   - Classify based on ball trajectory through zone

5. **UI** (`Jetpack Compose`)
   - Real-time shot counters
   - Session statistics
   - Camera preview with overlays

### Implementation Phases

**Phase 1 - Walking Skeleton** (Priority)
- Camera preview working
- Fake object detection every 3 seconds
- Counter increments and UI updates

**Phase 2-5**: Real detection → Shot logic → Make/miss → Polish

## Testing Strategy

Follow TDD with Red-Green-Refactor cycle:

### Test Structure
```
app/src/test/          # Unit tests
app/src/androidTest/   # Instrumentation tests
```

### Key Test Areas
- Object detection accuracy (mock LiteRT responses)
- Shot detection logic (unit tests with trajectory data)
- Make/miss classification (geometric calculations)
- UI state management (Compose testing)
- Camera integration (mock CameraX)

## Development Guidelines

### Walking Skeleton First
Start with simplest end-to-end pipeline before adding complexity. The specification includes example code for initial fake detection.

### Fixed Camera Assumption
All logic assumes phone mounted on tripod at ground level pointing up. This simplifies trajectory analysis and eliminates many edge cases.

### Pre-trained Models Only
Use existing COCO models for basketball detection. No custom ML training required.

### Geometric Classification
Make/miss detection uses simple geometry, not ML classification. Define zones around rim position.

## Key Dependencies

```kotlin
// build.gradle.kts dependencies block
implementation("androidx.camera:camera-camera2:1.3.1")
implementation("androidx.camera:camera-lifecycle:1.3.1")
implementation("androidx.camera:camera-view:1.3.1")
implementation("org.tensorflow:tensorflow-lite:2.16.1")
implementation("androidx.compose.ui:ui:1.5.8")
implementation("androidx.activity:activity-compose:1.8.2")
```

## Important Technical Decisions

- **LiteRT over MediaPipe**: Using Google's latest ML framework
- **No custom training**: Leverage pre-trained COCO models
- **Simple geometry**: Avoid complex ML for make/miss detection
- **Fixed setup**: Camera position eliminates many complexities
- **Ground-up angle**: Prevents dribbling detection issues