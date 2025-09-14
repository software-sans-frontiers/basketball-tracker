# Basketball Shot Tracker - Technical Specification v2

*Last Updated: 2025-09-14*

## Project Overview
An Android application that automatically tracks basketball shooting performance using computer vision. The app detects shots, classifies makes vs. misses, and provides real-time statistics - all without manual input.

## Current Status: Walking Skeleton Complete ✅
- **Pipeline Proven**: Camera → Detection → Counter → UI
- **Ready For**: Real ML model integration
- **Development Time**: ~50 minutes from boilerplate to working skeleton

## Physical Setup & Constraints

### Camera Configuration
- **Device**: Android phone (min SDK 24/Android 7.0+)
- **Mount**: Fixed tripod at ground level (~3-4 feet high)
- **Angle**: Pointing upward at basketball hoop
- **Field of View**: Must capture rim and ~3-5 feet above rim
- **Distance**: 5-10 feet from base of hoop
- **Orientation**: Portrait mode for maximum vertical coverage

### Environmental Considerations
- **Lighting**: Daylight or well-lit outdoor courts preferred
- **Background**: Sky or consistent background behind hoop
- **Weather**: Stable conditions (wind affects ball trajectory)
- **Single User**: Optimized for individual shooting practice

## Technical Architecture

### Core Technology Stack
| Component | Technology | Version | Status |
|-----------|------------|---------|---------|
| Language | Kotlin | 2.0.21 | ✅ Configured |
| UI Framework | Jetpack Compose | 2024.09.00 BOM | ✅ Integrated |
| Camera | CameraX | 1.3.1 | ✅ Working |
| ML Framework | TensorFlow Lite | 2.16.1 | ✅ Added |
| Build System | Gradle | 8.11.2 | ✅ Configured |
| Min SDK | Android 7.0 | API 24 | ✅ Set |
| Target SDK | Android 15 | API 36 | ✅ Set |
| Dev Environment | devenv.sh | 1.8.1 | ✅ Fixed |

### Project Structure
```
basketball-tracker/
├── .context/               # Specifications and work logs
│   ├── specification.md    # This file
│   └── work-log-*.md       # Daily progress logs
├── app/
│   └── src/main/
│       ├── java/com/ssf/bt/
│       │   └── MainActivity.kt  # Main app logic
│       └── AndroidManifest.xml  # Permissions configured
├── gradle/
│   └── libs.versions.toml  # Centralized dependency versions
└── devenv.nix              # Development environment
```

## Feature Implementation

### Phase 1: Walking Skeleton ✅ COMPLETE

#### Implemented Components
1. **Camera Integration**
   - CameraX preview running
   - Proper lifecycle management
   - Permission handling with fallback UI

2. **Fake Detection System**
   - 3-second interval timer
   - Simulated 50% make rate
   - Logging for debugging

3. **Statistics Display**
   - Real-time counter overlay
   - Shot count, makes, percentage
   - Clean Material3 design
   - Semi-transparent card on camera feed

#### Code Architecture
```kotlin
BasketballTrackerApp (Composable)
├── Permission Handler
├── Camera Preview
│   ├── CameraX Lifecycle
│   ├── Preview Use Case
│   └── ImageAnalysis Use Case (ready)
└── UI Overlay
    ├── Shot Counter
    ├── Make Counter
    └── Percentage Calculator
```

### Phase 2: Real Object Detection 🚧 NEXT

#### Approach: Pre-trained Model
- **Model**: YOLOv8 nano or MobileNet SSD v2
- **Target Class**: "sports ball" from COCO dataset
- **Input Size**: 320x320 or 224x224 (performance vs. accuracy)
- **FPS Target**: 15-30 FPS on mid-range devices

#### Implementation Tasks
- [ ] Download and integrate TFLite model
- [ ] Create ModelInterpreter class
- [ ] Convert ImageProxy to model input format
- [ ] Process model output (bounding boxes + confidence)
- [ ] Filter for basketball-sized objects only

#### Detection Pipeline
```kotlin
ImageProxy → 
  YUV to RGB conversion →
  Resize to model input →
  Run inference →
  Parse detections →
  Filter by confidence (>0.5) →
  Trigger shot event
```

### Phase 3: Shot Detection Logic

#### Trajectory Analysis
- **Entry Detection**: Ball appears in top 1/3 of frame
- **Velocity Check**: Moving downward (positive Y velocity)
- **Size Validation**: Consistent with basketball at distance
- **Continuous Tracking**: Maintain ID across frames

#### State Machine
```
IDLE → BALL_DETECTED → SHOT_IN_PROGRESS → SHOT_COMPLETE
  ↑                                            ↓
  ←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←
```

#### Data Structure
```kotlin
data class BallTrajectory(
    val positions: List<Point>,
    val timestamps: List<Long>,
    val boundingBoxes: List<Rect>,
    val velocities: List<Vector2>
)
```

### Phase 4: Make/Miss Classification

#### Rim Detection (One-time Calibration)
1. **Manual Setup Mode**
   - User taps rim location on screen
   - Or: Detect circular object in expected area
   - Store rim position and size

2. **Make Zone Definition**
   ```
   Rim Center: (x, y)
   Make Radius: rim_width * 1.2
   Entry Angle: > 30 degrees from horizontal
   ```

3. **Classification Logic**
   - Track ball through make zone
   - Check if trajectory passes through rim area
   - Validate downward motion at rim level
   - Account for net movement after made shot

### Phase 5: Enhanced Features

#### Session Management
- [ ] Start/stop recording sessions
- [ ] Save session statistics
- [ ] Historical data viewing
- [ ] Shooting zones (corner 3, free throw, etc.)

#### Advanced Statistics
- [ ] Shot arc analysis
- [ ] Release time detection
- [ ] Hot/cold streaks
- [ ] Time between shots
- [ ] Makes by zone

#### User Experience
- [ ] Audio feedback (swish/miss sounds)
- [ ] Visual feedback (screen flash on make)
- [ ] Customizable detection sensitivity
- [ ] Export statistics to CSV
- [ ] Share session summaries

## Technical Challenges & Solutions

### Challenge 1: Variable Lighting
**Problem**: Outdoor lighting changes throughout day
**Solution**: 
- Use adaptive thresholding
- Histogram equalization preprocessing
- Multiple model training on various lighting

### Challenge 2: Ball Speed
**Problem**: Fast-moving ball between frames
**Solution**:
- Higher camera FPS (60 if available)
- Motion blur resistant models
- Trajectory interpolation between frames

### Challenge 3: Partial Occlusion
**Problem**: Ball partially out of frame
**Solution**:
- Track even partial ball detections
- Use trajectory prediction
- Wider field of view setup

### Challenge 4: False Positives
**Problem**: Other round objects detected
**Solution**:
- Size filtering based on distance
- Trajectory validation (must come from above)
- Color filtering (orange/brown basketball)

## Performance Requirements

### Minimum Device Specs
- Android 7.0+ (API 24)
- 2GB RAM
- Camera with 1080p support
- ARM64 processor preferred

### Performance Targets
- Detection Latency: <100ms per frame
- UI Update Rate: 60 FPS
- Battery Usage: <10% per 30-min session
- Storage: <50MB app size

## Development Workflow

### Local Development
```bash
# Enter development environment
devenv shell

# Build and install
./gradlew assembleDebug
./gradlew installDebug

# Run tests
./gradlew test
./gradlew connectedAndroidTest

# View logs
adb logcat | grep BasketballTracker
```

### CI/CD Pipeline ✅ CONFIGURED

#### GitHub Actions Workflow
**Location**: `.github/workflows/cicd.yml`

#### Pipeline Triggers
- **Push to main/develop**: Full pipeline execution
- **Pull Requests**: Test and build validation
- **Main branch only**: Release creation

#### Pipeline Jobs

##### Phase 1: Parallel Validation
1. **Lint Check**
   - Android lint analysis
   - Code quality validation
   - Upload HTML reports

2. **Unit Tests**
   - JUnit test execution
   - Test report generation
   - Coverage tracking (future)

3. **Build Debug APK**
   - Development build
   - 7-day artifact retention
   - Available for testing

4. **Build Release APK**
   - Production optimized build
   - Main branch only
   - 30-day artifact retention

5. **Instrumentation Tests**
   - Emulator-based UI testing
   - Multiple API levels (29, 34)
   - Automated AVD management

##### Phase 2: Release Management
**Create Release** (main branch only)
- Automatic version generation (v0.1.X)
- Changelog from commits
- APK attachment to release
- Pre-release tagging until v1.0

#### Build Configuration
- **Java Version**: 21 (Temurin)
- **Android SDK**: API 36
- **Build Tools**: 36.0.0
- **Gradle Caching**: Enabled
- **Parallel Execution**: Yes

#### Artifacts
- Lint reports (HTML)
- Test results (XML/HTML)
- Debug APK (7 days)
- Release APK (30 days)

### Version Control

#### Branch Strategy
- **main**: Production releases
- **develop**: Integration branch
- **feature/***: Feature development
- **fix/***: Bug fixes

#### Commit Standards
Following conventional commits:
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation
- `test:` Test additions
- `ci:` CI/CD changes
- `refactor:` Code refactoring

### Testing Strategy
1. **Unit Tests**: Detection logic, statistics calculation
2. **Integration Tests**: Camera + ML pipeline
3. **UI Tests**: Compose testing for overlays
4. **Field Tests**: Actual basketball court testing

### Debugging Tools
- Android Studio Layout Inspector
- CameraX test app for angle validation
- TensorFlow Lite model explorer
- Logcat with custom tags

## Next Immediate Steps

### Week 1: Real Detection
1. **Day 1-2**: Integrate TFLite model
   - Download YOLOv8 nano model
   - Create model interpreter wrapper
   - Test with static images

2. **Day 3-4**: Connect to camera pipeline
   - Process ImageProxy frames
   - Optimize for performance
   - Add confidence filtering

3. **Day 5-7**: Field testing
   - Test at basketball court
   - Tune detection parameters
   - Measure real-world accuracy

### Week 2: Shot Logic
1. Implement trajectory tracking
2. Add shot state machine
3. Validate with real shots
4. Fine-tune detection parameters

### Week 3: Make/Miss
1. Implement rim calibration UI
2. Add geometric classification
3. Test accuracy at various angles
4. Add visual feedback

## Success Metrics

### MVP Criteria
- ✅ Camera preview working
- ✅ Basic UI with counters
- ⏳ Detect 80% of shots
- ⏳ Classify makes with 90% accuracy
- ⏳ Run for 30 minutes without crash
- ⏳ Work in daylight conditions

### V1.0 Release Criteria
- All MVP features
- Session management
- Historical statistics
- Work in various lighting
- <5% battery drain per session
- Play store ready

## Resources & References

### Documentation
- [CameraX Guide](https://developer.android.com/training/camerax)
- [TensorFlow Lite Android](https://www.tensorflow.org/lite/android)
- [Compose Documentation](https://developer.android.com/jetpack/compose)

### Models
- [YOLOv8 TFLite Models](https://github.com/ultralytics/ultralytics)
- [TF Hub Mobile Models](https://tfhub.dev/s?deployment-format=lite)
- [COCO Dataset Classes](https://cocodataset.org/#explore)

### Similar Projects
- HomeCourt (iOS) - AI basketball training
- OnForm - Video analysis for sports
- Various OpenCV basketball trackers on GitHub

## Version History

| Version | Date | Changes |
|---------|------|---------|
| v2.1 | 2025-09-14 | Added CI/CD pipeline documentation, version control strategy |
| v2.0 | 2025-09-14 | Major update: Added detailed phases, technical challenges, performance requirements |
| v1.0 | 2025-09-13 | Initial specification |

## Contact & Repository

- **Repository**: `~/workspace/basketball-tracker/`
- **Package Name**: `com.ssf.bt`
- **Development Lead**: Michael Edoror

---

*Note: This is a living document. Update the `.context/specification.md` file as implementation progresses and requirements evolve.*