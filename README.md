# 🏀 Basketball Shot Tracker

[![CI/CD](https://github.com/software-sans-frontiers/basketball-tracker/actions/workflows/cicd.yml/badge.svg)](https://github.com/software-sans-frontiers/basketball-tracker/actions/workflows/cicd.yml)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Android](https://img.shields.io/badge/Android-7.0%2B-green.svg)](https://developer.android.com)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.0.21-purple.svg)](https://kotlinlang.org)

An Android application that automatically tracks basketball shooting performance using computer vision. No manual input required - just mount your phone and shoot!

## 📱 Features

### Current (Walking Skeleton)
- ✅ Live camera preview
- ✅ Real-time shot counter
- ✅ Make/miss tracking
- ✅ Shooting percentage display
- ✅ Material 3 UI

### Coming Soon
- 🚧 Real ball detection using TensorFlow Lite
- 🚧 Trajectory tracking
- 🚧 Automatic make/miss classification
- 🚧 Session history
- 🚧 Shot heat maps

## 🚀 Quick Start

### Prerequisites
- Android Studio Arctic Fox or later
- JDK 21
- Android device (API 24+) or emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/basketball-tracker.git
cd basketball-tracker
```

2. Open in Android Studio or build from command line:
```bash
./gradlew assembleDebug
./gradlew installDebug
```

3. Grant camera permissions when prompted

## 🎯 Usage

### Physical Setup
1. Mount your Android phone on a tripod
2. Position 5-10 feet from the basket
3. Point camera upward to capture hoop and area above
4. Ensure good lighting conditions

### App Usage
1. Launch the app
2. Grant camera permission
3. Position phone according to setup guide
4. Start shooting - the app tracks automatically!

## 🛠️ Development

### Tech Stack
- **Language**: Kotlin 2.0.21
- **UI**: Jetpack Compose
- **Camera**: CameraX 1.3.1
- **ML**: TensorFlow Lite 2.16.1
- **Build**: Gradle 8.11.2

### Project Structure
```
basketball-tracker/
├── app/                    # Android application
│   └── src/
│       └── main/
│           ├── java/       # Kotlin source code
│           └── res/        # Resources
├── .context/              # Project documentation
│   ├── specification.md   # Technical spec
│   └── work-log-*.md     # Development logs
└── .github/
    └── workflows/         # CI/CD pipeline
```

### Building

```bash
# Debug build
./gradlew assembleDebug

# Release build
./gradlew assembleRelease

# Run tests
./gradlew test

# Run lint
./gradlew lint
```

### Development Environment

Using [devenv.sh](https://devenv.sh/):
```bash
devenv shell
```

## 🧪 Testing

```bash
# Unit tests
./gradlew test

# Instrumentation tests
./gradlew connectedAndroidTest

# All tests
./gradlew check
```

## 📊 CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment:

- **On Push**: Lint, test, and build
- **On PR**: Full test suite
- **On Main**: Automatic release creation

### Pipeline Jobs
1. **Lint**: Code quality checks
2. **Unit Tests**: Business logic testing
3. **Build Debug**: Development APK
4. **Build Release**: Production APK
5. **Instrumentation Tests**: UI testing on emulators
6. **Create Release**: Automated GitHub releases

## 📝 License

This project is proprietary software owned by Software Sans Frontiers. All rights reserved.

The source code is not open source and is protected by copyright law. Unauthorized copying, modification, or distribution is strictly prohibited.

For licensing inquiries, contact: ceo@softwaresansfrontiers.com

See the [LICENSE](LICENSE) file for full details.

## 🙏 Acknowledgments

- CameraX for excellent camera APIs
- TensorFlow team for mobile ML tools
- Android Jetpack Compose team

## 📧 Contact

Software Sans Frontiers  
Email: ceo@softwaresansfrontiers.com  
GitHub: [software-sans-frontiers](https://github.com/software-sans-frontiers)

Project Repository: [https://github.com/software-sans-frontiers/basketball-tracker](https://github.com/software-sans-frontiers/basketball-tracker) (Private)

---

**Current Status**: Walking Skeleton Complete ✅  
**Next Phase**: Real Object Detection 🚧