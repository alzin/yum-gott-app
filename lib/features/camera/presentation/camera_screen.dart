import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart' as camera;
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/camera/presentation/controllers/camera_controller.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/usage_policy_dialog.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/camera_controls.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/video_preview.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/restaurant_selection_screen.dart';
import 'package:yum_gott_app/features/camera/presentation/widgets/product_selection_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(CustomCameraController());
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        // Show usage policy dialog
        if (controller.showUsagePolicy.value) {
          return UsagePolicyDialog(
            onAccept: controller.acceptUsagePolicy,
          );
        }
        
        // Show restaurant selection after accepting usage policy
        if (controller.showRestaurantSelection.value) {
          return RestaurantSelectionScreen(
            restaurants: controller.restaurants,
            onRestaurantSelected: controller.selectRestaurant,
          );
        }
        
        // Show product selection after selecting a restaurant
        if (controller.showProductSelection.value) {
          return ProductSelectionScreen(
            products: controller.products,
            onProductSelected: controller.selectProduct,
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
                child: camera.CameraPreview(controller.cameraController.value!),
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