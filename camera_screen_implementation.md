# Camera Screen Implementation Plan

## Overview

This document outlines the implementation details for the camera screen in the Yum Gott app. The camera screen will allow users to record videos and publish them to the feed.

## Dependencies

Add the following dependencies to the `pubspec.yaml` file:

```yaml
dependencies:
  # Camera
  camera: ^0.10.5+9
  path_provider: ^2.1.2
  permission_handler: ^11.3.0
```

## Feature Structure

```
lib/features/camera/
├── domain/
│   └── models/
│       └── recorded_video.dart
├── presentation/
│   ├── camera_screen.dart
│   ├── controllers/
│   │   └── camera_controller.dart
│   └── widgets/
│       ├── usage_policy_dialog.dart
│       ├── camera_controls.dart
│       └── video_preview.dart
```

## Implementation Details

### 1. RecordedVideo Model

```dart
class RecordedVideo {
  final String id;
  final String filePath;
  final String thumbnailPath;
  final DateTime createdAt;
  final Duration duration;
  
  RecordedVideo({
    required this.id,
    required this.filePath,
    required this.thumbnailPath,
    required this.createdAt,
    required this.duration,
  });
}
```

### 2. Camera Controller

```dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yum_gott_app/features/camera/domain/models/recorded_video.dart';
import 'package:yum_gott_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:yum_gott_app/routes.dart';

class CameraController extends GetxController {
  // Available cameras
  final RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  
  // Active camera controller
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  
  // Camera state
  final RxBool isInitialized = false.obs;
  final RxBool isRecording = false.obs;
  final RxBool isFrontCamera = false.obs;
  final RxBool isFlashOn = false.obs;
  
  // Usage policy
  final RxBool showUsagePolicy = true.obs;
  
  // Recorded video
  final Rx<RecordedVideo?> recordedVideo = Rx<RecordedVideo?>(null);
  
  @override
  void onInit() {
    super.onInit();
    _initCameras();
  }
  
  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }
  
  // Initialize available cameras
  Future<void> _initCameras() async {
    try {
      // Request camera and microphone permissions
      final cameraStatus = await Permission.camera.request();
      final microphoneStatus = await Permission.microphone.request();
      
      if (cameraStatus.isGranted && microphoneStatus.isGranted) {
        // Get available cameras
        final availableCameras = await availableCameras();
        cameras.value = availableCameras;
        
        // Initialize with back camera by default
        if (cameras.isNotEmpty) {
          final backCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
            orElse: () => cameras.first,
          );
          
          await _initCameraController(backCamera);
        }
      } else {
        // Handle permission denied
        Get.snackbar(
          'Permission Denied',
          'Camera and microphone permissions are required to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Initialize camera controller with specific camera
  Future<void> _initCameraController(CameraDescription camera) async {
    // Dispose previous controller if exists
    if (cameraController.value != null) {
      await cameraController.value!.dispose();
    }
    
    // Create new controller
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
    );
    
    // Initialize controller
    try {
      await controller.initialize();
      cameraController.value = controller;
      isInitialized.value = true;
      
      // Set flash mode
      if (isFlashOn.value) {
        await controller.setFlashMode(FlashMode.torch);
      } else {
        await controller.setFlashMode(FlashMode.off);
      }
      
      // Update camera direction
      isFrontCamera.value = camera.lensDirection == CameraLensDirection.front;
    } catch (e) {
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Switch between front and back cameras
  Future<void> switchCamera() async {
    if (cameras.length < 2) return;
    
    try {
      final newDirection = isFrontCamera.value
          ? CameraLensDirection.back
          : CameraLensDirection.front;
      
      final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == newDirection,
        orElse: () => cameras.first,
      );
      
      await _initCameraController(newCamera);
    } catch (e) {
      Get.snackbar(
        'Camera Error',
        'Failed to switch camera: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Toggle flash
  Future<void> toggleFlash() async {
    if (cameraController.value == null || !isInitialized.value) return;
    
    try {
      isFlashOn.value = !isFlashOn.value;
      
      if (isFlashOn.value) {
        await cameraController.value!.setFlashMode(FlashMode.torch);
      } else {
        await cameraController.value!.setFlashMode(FlashMode.off);
      }
    } catch (e) {
      Get.snackbar(
        'Flash Error',
        'Failed to toggle flash: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Start recording video
  Future<void> startRecording() async {
    if (cameraController.value == null || !isInitialized.value || isRecording.value) return;
    
    try {
      // Create directory for videos if it doesn't exist
      final directory = await getApplicationDocumentsDirectory();
      final videoDirectory = Directory('${directory.path}/videos');
      if (!await videoDirectory.exists()) {
        await videoDirectory.create(recursive: true);
      }
      
      // Start recording
      final videoPath = '${videoDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
      await cameraController.value!.startVideoRecording();
      isRecording.value = true;
      
      Get.snackbar(
        'Recording',
        'Video recording started',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      Get.snackbar(
        'Recording Error',
        'Failed to start recording: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Stop recording video
  Future<void> stopRecording() async {
    if (cameraController.value == null || !isInitialized.value || !isRecording.value) return;
    
    try {
      // Stop recording
      final videoFile = await cameraController.value!.stopVideoRecording();
      isRecording.value = false;
      
      // Create thumbnail
      final thumbnailPath = '${videoFile.path.replaceAll('.mp4', '')}_thumbnail.jpg';
      
      // Create RecordedVideo object
      recordedVideo.value = RecordedVideo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        filePath: videoFile.path,
        thumbnailPath: thumbnailPath,
        createdAt: DateTime.now(),
        duration: const Duration(seconds: 10), // Placeholder, should be calculated
      );
      
      Get.snackbar(
        'Recording Completed',
        'Video recording completed',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      Get.snackbar(
        'Recording Error',
        'Failed to stop recording: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Discard recorded video
  void discardRecording() {
    if (recordedVideo.value != null) {
      // Delete video file
      final videoFile = File(recordedVideo.value!.filePath);
      if (videoFile.existsSync()) {
        videoFile.deleteSync();
      }
      
      // Delete thumbnail file
      final thumbnailFile = File(recordedVideo.value!.thumbnailPath);
      if (thumbnailFile.existsSync()) {
        thumbnailFile.deleteSync();
      }
      
      // Clear recorded video
      recordedVideo.value = null;
    }
  }
  
  // Publish video to feed
  Future<void> publishVideo() async {
    if (recordedVideo.value == null) return;
    
    try {
      // Get feed controller
      final feedController = Get.find<FeedController>();
      
      // Add video to feed
      // This is a placeholder implementation
      // In a real app, you would upload the video to a server
      // and then add it to the feed
      
      // Navigate back to feed
      Get.offNamed(AppRoutes.feed);
      
      Get.snackbar(
        'Video Published',
        'Your video has been published to the feed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Publishing Error',
        'Failed to publish video: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  
  // Accept usage policy
  void acceptUsagePolicy() {
    showUsagePolicy.value = false;
  }
}
```

### 3. Camera Screen

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/camera/presentation/controllers/camera_controller.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/usage_policy_dialog.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/camera_controls.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/video_preview.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(CameraController());
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        // Show usage policy dialog
        if (controller.showUsagePolicy.value) {
          return UsagePolicyDialog(
            onAccept: controller.acceptUsagePolicy,
          );
        }
        
        // Show video preview if video is recorded
        if (controller.recordedVideo.value != null) {
          return VideoPreview(
            videoPath: controller.recordedVideo.value!.filePath,
            onPublish: controller.publishVideo,
            onDiscard: controller.discardRecording,
          );
        }
        
        // Show camera preview
        return Stack(
          children: [
            // Camera preview
            if (controller.isInitialized.value && controller.cameraController.value != null)
              Positioned.fill(
                child: CameraPreview(controller.cameraController.value!),
              ),
              
            // Camera controls
            CameraControls(
              isRecording: controller.isRecording.value,
              isFlashOn: controller.isFlashOn.value,
              isFrontCamera: controller.isFrontCamera.value,
              onSwitchCamera: controller.switchCamera,
              onToggleFlash: controller.toggleFlash,
              onStartRecording: controller.startRecording,
              onStopRecording: controller.stopRecording,
              onClose: () => Get.back(),
            ),
            
            // Top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Video',
                        style: AppTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
```

### 4. Usage Policy Dialog

```dart
import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class UsagePolicyDialog extends StatelessWidget {
  final VoidCallback onAccept;

  const UsagePolicyDialog({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Camera.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Semi-transparent overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
          
          // Usage policy dialog
          Center(
            child: Container(
              width: 348,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title with icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Usage policy',
                        style: AppTheme.headingSmall.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Policy points
                  _buildPolicyPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's',
                  ),
                  const SizedBox(height: 16),
                  
                  _buildPolicyPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's',
                  ),
                  const SizedBox(height: 16),
                  
                  _buildPolicyPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's',
                  ),
                  const SizedBox(height: 16),
                  
                  _buildPolicyPoint(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's',
                  ),
                  const SizedBox(height: 24),
                  
                  // Accept button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Accept policy's',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPolicyPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontFamily: 'Vazirmatn',
            ),
          ),
        ),
      ],
    );
  }
}
```

### 5. Camera Controls Widget

```dart
import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class CameraControls extends StatelessWidget {
  final bool isRecording;
  final bool isFlashOn;
  final bool isFrontCamera;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleFlash;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onClose;

  const CameraControls({
    Key? key,
    required this.isRecording,
    required this.isFlashOn,
    required this.isFrontCamera,
    required this.onSwitchCamera,
    required this.onToggleFlash,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Close button (top left)
        Positioned(
          top: 60,
          left: 16,
          child: _buildControlButton(
            icon: Icons.close,
            onTap: onClose,
          ),
        ),
        
        // Flash button (top right)
        Positioned(
          top: 60,
          right: 16,
          child: _buildControlButton(
            icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
            onTap: onToggleFlash,
          ),
        ),
        
        // Switch camera button (below flash)
        Positioned(
          top: 110,
          right: 16,
          child: _buildControlButton(
            icon: Icons.flip_camera_ios,
            onTap: onSwitchCamera,
          ),
        ),
        
        // Bottom controls
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Record button
              GestureDetector(
                onTap: isRecording ? onStopRecording : onStartRecording,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isRecording ? Colors.red : AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: isRecording
                          ? const Icon(
                              Icons.stop,
                              color: Colors.white,
                              size: 30,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
```

### 6. Video Preview Widget

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class VideoPreview extends StatefulWidget {
  final String videoPath;
  final VoidCallback onPublish;
  final VoidCallback onDiscard;

  const VideoPreview({
    Key? key,
    required this.videoPath,
    required this.onPublish,
    required this.onDiscard,
  }) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Future<void> _initVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video preview
        Positioned.fill(
          child: _controller.value.isInitialized
              ? GestureDetector(
                  onTap: _togglePlayPause,
                  child: VideoPlayer(_controller),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
        ),
        
        // Play/pause indicator
        if (_controller.value.isInitialized && !_isPlaying)
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        
        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: widget.onDiscard,
                  ),
                  Text(
                    'Preview',
                    style: AppTheme.bodyLarge,
                  ),
                  const SizedBox(width: 40), // For balance
                ],
              ),
            ),
          ),
        ),
        
        // Bottom controls
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Discard button
              ElevatedButton.icon(
                onPressed: widget.onDiscard,
                icon: const Icon(Icons.delete),
                label: const Text('Discard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
              
              // Publish button
              ElevatedButton.icon(
                onPressed: widget.onPublish,
                icon: const Icon(Icons.publish),
                label: const Text('Publish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

### 7. Route Updates

Update the `routes.dart` file to add the camera route:

```dart
static const String camera = '/camera';

// In the GetPage list
GetPage(
  name: camera,
  page: () => const CameraScreen(),
  transition: Transition.rightToLeft,
)
```

### 8. Navigation Updates

Update the navigation in the `feed_screen.dart` file:

```dart
case 2:
  // Navigate to camera screen
  Get.toNamed(AppRoutes.camera);
  break;
```

## Implementation Steps

1. Add the required dependencies to pubspec.yaml
2. Create the folder structure
3. Implement the RecordedVideo model
4. Implement the CameraController
5. Implement the CameraScreen
6. Implement the UsagePolicyDialog
7. Implement the CameraControls widget
8. Implement the VideoPreview widget
9. Update the routes.dart file
10. Update the navigation in the feed_screen.dart file
11. Test the implementation

## Notes

- The camera functionality requires camera and microphone permissions, which are handled in the CameraController.
- The usage policy dialog is shown each time the camera screen is opened.
- The camera screen supports only video recording, not photo capture.
- The recorded video is published to the feed when the user taps the Publish button.
- Error handling is implemented for camera initialization, recording, and publishing.