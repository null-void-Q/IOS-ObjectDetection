# CoreML Object Detection

iOS app that runs YOLOv7 object detection model on device camera feed.

## Requirements
- iOS 14+
- Xcode 12+
- Physical device (camera access required)

## Setup
```bash
git clone https://github.com/yourusername/coreml-object-detection.git
open CoreMLObjDetect.xcodeproj
```

Configure signing team and bundle identifier, then run on device.

## Features
- Real-time object detection
- YOLOv7 model via Core ML
- Camera-based inference
- Bounding boxes and labels

![Screenshot](https://user-images.githubusercontent.com/53970206/202893416-d4b3eb0d-88e9-4303-ac4c-927d3ef5ec1c.png)

## Notes
- Must run on physical device
- Processing happens locally on device
- Model is pre-trained and optimized for iOS
