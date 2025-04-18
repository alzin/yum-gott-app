import 'dart:io';
import 'package:camera/camera.dart' as camera;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yum_gott_app/features/camera/domain/models/recorded_video.dart';
import 'package:yum_gott_app/features/camera/domain/models/restaurant.dart';
import 'package:yum_gott_app/features/camera/domain/models/product.dart';
import 'package:yum_gott_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:yum_gott_app/routes.dart';

class CustomCameraController extends GetxController {
  // Available cameras
  final RxList<camera.CameraDescription> cameras = <camera.CameraDescription>[].obs;
  
  // Active camera controller
  Rx<camera.CameraController?> cameraController = Rx<camera.CameraController?>(null);
  
  // Camera state
  final RxBool isInitialized = false.obs;
  final RxBool isRecording = false.obs;
  final RxBool isFrontCamera = false.obs;
  final RxBool isFlashOn = false.obs;
  
  // Screen state
  final RxBool showUsagePolicy = true.obs;
  final RxBool showRestaurantSelection = false.obs;
  final RxBool showProductSelection = false.obs;
  
  // Restaurant selection
  final RxInt selectedRestaurantId = 1.obs;
  final RxList<Restaurant> restaurants = <Restaurant>[
    Restaurant(
      id: 1,
      name: "Observatory Bar & Grill",
      description: "Thick handmade udon noodles in a rich miso broth, garnished with tofu....",
      location: "Sweden",
      image: "assets/images/pizza.png",
    ),
    Restaurant(
      id: 2,
      name: "Tasty Bites",
      description: "Thick handmade udon noodles in a rich miso broth, garnished with tofu....",
      location: "Sweden",
      image: "assets/images/pizza.png",
    ),
  ].obs;
  
  // Recorded video
  final Rx<RecordedVideo?> recordedVideo = Rx<RecordedVideo?>(null);
  
  // Selected restaurant
  final Rx<Restaurant?> selectedRestaurant = Rx<Restaurant?>(null);
  
  // Product selection
  final RxInt selectedProductId = 1.obs;
  final RxList<Product> products = <Product>[].obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  
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
        final availableCameras = await camera.availableCameras();
        cameras.value = availableCameras;
        
        // Initialize with back camera by default
        if (cameras.isNotEmpty) {
          final backCamera = cameras.firstWhere(
            (cam) => cam.lensDirection == camera.CameraLensDirection.back,
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
  Future<void> _initCameraController(camera.CameraDescription cameraDesc) async {
    // Dispose previous controller if exists
    if (cameraController.value != null) {
      await cameraController.value!.dispose();
    }
    
    // Create new controller
    final controller = camera.CameraController(
      cameraDesc,
      camera.ResolutionPreset.high,
      enableAudio: true,
    );
    
    // Initialize controller
    try {
      await controller.initialize();
      cameraController.value = controller;
      isInitialized.value = true;
      
      // Set flash mode
      if (isFlashOn.value) {
        await controller.setFlashMode(camera.FlashMode.torch);
      } else {
        await controller.setFlashMode(camera.FlashMode.off);
      }
      
      // Update camera direction
      isFrontCamera.value = cameraDesc.lensDirection == camera.CameraLensDirection.front;
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
          ? camera.CameraLensDirection.back
          : camera.CameraLensDirection.front;
      
      final newCamera = cameras.firstWhere(
        (cam) => cam.lensDirection == newDirection,
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
        await cameraController.value!.setFlashMode(camera.FlashMode.torch);
      } else {
        await cameraController.value!.setFlashMode(camera.FlashMode.off);
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
      feedController.addVideo(
        recordedVideo.value!.filePath,
        recordedVideo.value!.thumbnailPath,
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
  
  // Accept usage policy
  void acceptUsagePolicy() {
    showUsagePolicy.value = false;
    showRestaurantSelection.value = true;
  }
  
  // Select restaurant
  void selectRestaurant(Restaurant restaurant) {
    selectedRestaurant.value = restaurant;
    showRestaurantSelection.value = false;
    
    // Load products for the selected restaurant
    loadProductsForRestaurant(restaurant.id);
    
    // Show product selection screen
    showProductSelection.value = true;
  }
  
  // Load products for a restaurant
  void loadProductsForRestaurant(int restaurantId) {
    // In a real app, this would fetch products from an API
    // For now, we'll use mock data
    products.value = [
      Product(
        id: 1,
        name: "Chicken Biryani",
        restaurant: "KFC REST",
        timestamp: "2024/08/10 12:08AM",
        image: "assets/images/pizza.png",
        selected: true,
      ),
      Product(
        id: 2,
        name: "Pizza Margarita",
        restaurant: "KFC REST",
        timestamp: "2024/08/10 12:08AM",
        image: "assets/images/pizza.png",
        selected: false,
      ),
      Product(
        id: 3,
        name: "Orange Juice",
        restaurant: "KFC REST",
        timestamp: "2024/08/10 12:08AM",
        image: "assets/images/pizza.png",
        selected: false,
      ),
      Product(
        id: 4,
        name: "Chicken Biryani",
        restaurant: "KFC REST",
        timestamp: "2024/08/10 12:08AM",
        image: "assets/images/pizza.png",
        selected: false,
      ),
      Product(
        id: 5,
        name: "Chicken Biryani",
        restaurant: "KFC REST",
        timestamp: "2024/08/10 12:08AM",
        image: "assets/images/pizza.png",
        selected: false,
      ),
    ];
    
    // Set the first product as selected by default
    selectedProductId.value = products[0].id;
  }
  
  // Select product
  void selectProduct(Product product) {
    selectedProduct.value = product;
    showProductSelection.value = false;
  }
}