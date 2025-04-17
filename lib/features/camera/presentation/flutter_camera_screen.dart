import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/camera/domain/models/recorded_video.dart';
import 'package:yum_gott_app/features/camera/presentation/controllers/camera_controller.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/usage_policy_dialog.dart';
import 'package:yum_gott_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:yum_gott_app/routes.dart';

class FlutterCameraScreen extends StatefulWidget {
  const FlutterCameraScreen({Key? key}) : super(key: key);

  @override
  State<FlutterCameraScreen> createState() => _FlutterCameraScreenState();
}

class _FlutterCameraScreenState extends State<FlutterCameraScreen> {
  final RxBool showUsagePolicy = true.obs;
  RecordedVideo? recordedVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        // Show usage policy dialog
        if (showUsagePolicy.value) {
          return UsagePolicyDialog(
            onAccept: () => showUsagePolicy.value = false,
          );
        }

        // Show flutter camera
        return FlutterCamera(
          color: AppTheme.primaryColor,
          onImageCaptured: (value) {
            // We're only interested in video recording
          },
          onVideoRecorded: (value) async {
            final path = value.path;
            print('Video recorded: $path');
            
            // Create thumbnail path
            final thumbnailPath = '${path.replaceAll('.mp4', '')}_thumbnail.jpg';
            
            // Create RecordedVideo object
            recordedVideo = RecordedVideo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              filePath: path,
              thumbnailPath: thumbnailPath,
              createdAt: DateTime.now(),
              duration: const Duration(seconds: 10), // Placeholder
            );
            
            // Show preview dialog
            await _showVideoPreviewDialog(context, path);
          },
        );
      }),
    );
  }

  Future<void> _showVideoPreviewDialog(BuildContext context, String videoPath) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Video preview (simplified for this example)
                Container(
                  height: 300,
                  color: Colors.grey[900],
                  child: Center(
                    child: Icon(
                      Icons.video_library,
                      size: 64,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Discard button
                      ElevatedButton.icon(
                        onPressed: () {
                          _discardRecording();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Discard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      
                      // Publish button
                      ElevatedButton.icon(
                        onPressed: () {
                          _publishVideo();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.publish),
                        label: const Text('Publish'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Discard recorded video
  void _discardRecording() {
    if (recordedVideo != null) {
      // Delete video file
      final videoFile = File(recordedVideo!.filePath);
      if (videoFile.existsSync()) {
        videoFile.deleteSync();
      }
      
      // Delete thumbnail file
      final thumbnailFile = File(recordedVideo!.thumbnailPath);
      if (thumbnailFile.existsSync()) {
        thumbnailFile.deleteSync();
      }
      
      // Clear recorded video
      recordedVideo = null;
    }
  }

  // Publish video to feed
  Future<void> _publishVideo() async {
    if (recordedVideo == null) return;
    
    try {
      // Get feed controller
      final feedController = Get.find<FeedController>();
      
      // Add video to feed
      feedController.addVideo(
        recordedVideo!.filePath,
        recordedVideo!.thumbnailPath,
      );
      
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
}