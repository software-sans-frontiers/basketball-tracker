# Basketball Tracker - Next Steps Action Plan

*Created: 2025-09-14*  
*Status: Walking Skeleton Complete, CI/CD Configured*

## 🎯 Immediate Next Steps (Week of Sep 16-20)

### Phase 2: Real Object Detection Implementation

#### Step 1: Model Integration (2-3 days)
- [ ] **Download TensorFlow Lite Model**
  - Option A: YOLOv8 nano (.tflite version)
  - Option B: MobileNet SSD v2
  - Target: "sports ball" class from COCO dataset
  - Size target: <20MB for mobile

- [ ] **Create Model Wrapper Class**
  ```kotlin
  class BallDetector(
      private val interpreter: Interpreter,
      private val labels: List<String>
  )
  ```

- [ ] **Add Model to Assets**
  - Place in `app/src/main/assets/`
  - Update build.gradle for asset compression

#### Step 2: Image Processing Pipeline (1-2 days)
- [ ] **ImageProxy to Bitmap Conversion**
  - YUV to RGB conversion
  - Resize to model input size (320x320 or 224x224)
  - Normalize pixel values

- [ ] **Replace Fake Detection**
  - Remove 3-second timer
  - Connect real model inference
  - Process at 15-30 FPS

- [ ] **Add Detection Filtering**
  - Confidence threshold (>0.5)
  - Size filtering (basketball-appropriate)
  - Non-max suppression for multiple detections

#### Step 3: Testing & Optimization (2-3 days)
- [ ] **Performance Optimization**
  - GPU delegation if available
  - NNAPI support
  - Frame skipping for lower-end devices

- [ ] **Field Testing**
  - Test with actual basketball
  - Different lighting conditions
  - Various distances/angles

## 📋 Development Checklist

### Code Tasks
```
1. Create package structure:
   app/src/main/java/com/ssf/bt/
   ├── detection/
   │   ├── BallDetector.kt
   │   ├── ImageProcessor.kt
   │   └── DetectionResult.kt
   ├── ui/
   │   └── camera/
   └── utils/

2. Add dependencies:
   - TensorFlow Lite GPU delegate (optional)
   - Kotlin Coroutines for async processing

3. Implement detection:
   - Model loading
   - Inference execution
   - Result parsing
   - UI updates
```

### Testing Plan
- [ ] Unit tests for detection logic
- [ ] Integration tests for camera pipeline
- [ ] Performance benchmarks
- [ ] Real-world accuracy measurements

## 🚀 Future Phases Overview

### Phase 3: Shot Logic (Week 2)
- Trajectory tracking across frames
- Shot state machine implementation
- Entry point detection (ball from above)
- Velocity calculations

### Phase 4: Make/Miss Classification (Week 3)
- Rim calibration UI
- Geometric zone definition
- Trajectory analysis through rim area
- Net movement detection

### Phase 5: Polish & Release Prep (Week 4)
- Session management
- Statistics persistence
- Settings screen
- Play Store assets preparation

## 💼 Business/Commercial Tasks

### Google Play Store Preparation
- [ ] Create Google Play Developer account ($25 one-time)
- [ ] Prepare app listing:
  - App icon (512x512)
  - Feature graphic (1024x500)
  - Screenshots (min 2, max 8)
  - App description
  - Privacy policy URL
- [ ] Set up app signing
- [ ] Determine pricing strategy

### Legal/Compliance
- [ ] Privacy Policy document
- [ ] Terms of Service
- [ ] Data collection disclosure
- [ ] Age rating questionnaire

## 🔧 Technical Debt & Improvements

### Immediate
- [ ] Add error handling for camera failures
- [ ] Implement proper logging system
- [ ] Add analytics (Firebase/custom)

### Future
- [ ] Landscape orientation support
- [ ] Tablet optimization
- [ ] Dark mode support
- [ ] Accessibility features

## 📊 Success Metrics to Track

### Technical Metrics
- Detection accuracy: Target 80%+
- Make/miss classification: Target 90%+
- FPS performance: 15+ on mid-range devices
- Battery usage: <10% per 30-min session

### Business Metrics
- App crashes: <1%
- User retention: 30-day target
- Play Store rating: 4.0+ target
- Download conversion rate

## 🔗 Resources Needed

### Models
- [YOLOv8 TFLite](https://github.com/ultralytics/ultralytics)
- [TensorFlow Hub Models](https://tfhub.dev/s?deployment-format=lite&module-type=image-object-detection)
- [MediaPipe Models](https://developers.google.com/mediapipe/solutions/vision/object_detector#models)

### Documentation
- [TensorFlow Lite Android Guide](https://www.tensorflow.org/lite/android/quickstart)
- [CameraX ImageAnalysis](https://developer.android.com/training/camerax/analyze)
- [Play Console Guide](https://support.google.com/googleplay/android-developer)

## 📅 Suggested Timeline

```
Week 1 (Sep 16-20): Real Detection
  Mon-Tue: Model integration
  Wed-Thu: Image processing pipeline
  Fri: Testing and optimization

Week 2 (Sep 23-27): Shot Logic
  Mon-Tue: Trajectory tracking
  Wed-Thu: State machine
  Fri: Integration testing

Week 3 (Sep 30-Oct 4): Make/Miss
  Mon-Tue: Rim calibration
  Wed-Thu: Classification logic
  Fri: Accuracy testing

Week 4 (Oct 7-11): Polish & Release
  Mon-Tue: UI polish
  Wed: Play Store prep
  Thu-Fri: Beta testing
```

## 🎯 Definition of Done for Phase 2

- [ ] Real basketball detection working
- [ ] 80%+ detection accuracy in good lighting
- [ ] Performance: 15+ FPS on Pixel 4a
- [ ] No fake detection code remaining
- [ ] Unit tests for detection logic
- [ ] CI/CD still passing
- [ ] Updated documentation

## 💡 Quick Start Commands

```bash
# Resume development
cd ~/workspace/basketball-tracker
devenv shell

# Run app
./gradlew installDebug
adb shell am start -n com.ssf.bt/.MainActivity

# View logs
adb logcat | grep BasketballTracker

# Run tests
./gradlew test

# Check for issues
./gradlew lint
```

---

*Remember: Focus on getting real detection working first. Everything else builds on that foundation.*