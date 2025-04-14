import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:yum_gott_app/features/feed/domain/models/video_model.dart';

class FeedController extends GetxController {
  // List of videos
  final RxList<VideoModel> videos = <VideoModel>[].obs;
  
  // Current video index
  final RxInt currentIndex = 0.obs;
  
  // Video controllers
  final RxMap<String, VideoPlayerController?> videoControllers = <String, VideoPlayerController?>{}.obs;
  
  // Loading state
  final RxBool isLoading = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadVideos();
  }
  
  @override
  void onClose() {
    disposeAllControllers();
    super.onClose();
  }
  
  void loadVideos() {
    isLoading.value = true;
    // In a real app, this would be an API call
    videos.value = VideoModel.getSampleVideos();
    
    // Initialize the first video controller
    if (videos.isNotEmpty) {
      initializeController(0);
    }
    
    isLoading.value = false;
  }
  
  void initializeController(int index) async {
    if (index < 0 || index >= videos.length) return;
    
    final video = videos[index];
    
    // Check if controller already exists
    if (videoControllers.containsKey(video.id) && videoControllers[video.id] != null) {
      return;
    }
    
    // Create the appropriate controller based on the URL type
    VideoPlayerController controller;
    
    // Check if the video URL is a file path (starts with /)
    if (video.videoUrl.startsWith('/')) {
      controller = VideoPlayerController.file(File(video.videoUrl));
    } else {
      // Otherwise, assume it's an asset
      controller = VideoPlayerController.asset(video.videoUrl);
    }
    
    videoControllers[video.id] = controller;
    
    await controller.initialize();
    controller.setLooping(true);
    
    // Auto-play the current video
    if (index == currentIndex.value) {
      controller.play();
    }
    
    update(); // Notify listeners
  }
  
  void onPageChanged(int index) {
    // Pause the previous video
    final previousVideo = videos[currentIndex.value];
    final previousController = videoControllers[previousVideo.id];
    previousController?.pause();
    
    // Update current index
    currentIndex.value = index;
    
    // Initialize the next controller if needed
    initializeController(index);
    
    // Play the current video
    final currentVideo = videos[index];
    final currentController = videoControllers[currentVideo.id];
    currentController?.play();
    
    // Preload the next video
    if (index < videos.length - 1) {
      initializeController(index + 1);
    }
  }
  
  void togglePlayPause(String videoId) {
    final controller = videoControllers[videoId];
    if (controller == null) return;
    
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    
    update(); // Notify listeners
  }
  
  void toggleLike(String videoId) {
    final index = videos.indexWhere((video) => video.id == videoId);
    if (index == -1) return;
    
    final video = videos[index];
    final updatedVideo = VideoModel(
      id: video.id,
      videoUrl: video.videoUrl,
      thumbnailUrl: video.thumbnailUrl,
      restaurantName: video.restaurantName,
      restaurantId: video.restaurantId,
      restaurantLogoUrl: video.restaurantLogoUrl,
      foodName: video.foodName,
      foodCategory: video.foodCategory,
      description: video.description,
      likes: video.isLiked ? video.likes - 1 : video.likes + 1,
      comments: video.comments,
      shares: video.shares,
      rating: video.rating,
      distance: video.distance,
      userName: video.userName,
      userProfileUrl: video.userProfileUrl,
      isLiked: !video.isLiked,
    );
    
    videos[index] = updatedVideo;
    update(); // Notify listeners
  }
  
  void shareVideo(String videoId) {
    // In a real app, this would open a share dialog
    final index = videos.indexWhere((video) => video.id == videoId);
    if (index == -1) return;
    
    final video = videos[index];
    final updatedVideo = VideoModel(
      id: video.id,
      videoUrl: video.videoUrl,
      thumbnailUrl: video.thumbnailUrl,
      restaurantName: video.restaurantName,
      restaurantId: video.restaurantId,
      restaurantLogoUrl: video.restaurantLogoUrl,
      foodName: video.foodName,
      foodCategory: video.foodCategory,
      description: video.description,
      likes: video.likes,
      comments: video.comments,
      shares: video.shares + 1,
      rating: video.rating,
      distance: video.distance,
      userName: video.userName,
      userProfileUrl: video.userProfileUrl,
      isLiked: video.isLiked,
    );
    
    videos[index] = updatedVideo;
    update(); // Notify listeners
  }
  
  void navigateToRestaurant(String restaurantId) {
    // Navigate to restaurant details screen
    // Get.toNamed(AppRoutes.restaurantDetails, arguments: restaurantId);
  }
  
  void navigateToComments(String videoId) {
    // Navigate to comments screen
    // Get.toNamed(AppRoutes.comments, arguments: videoId);
  }
  
  void disposeController(String videoId) {
    final controller = videoControllers[videoId];
    if (controller != null) {
      controller.dispose();
      videoControllers.remove(videoId);
    }
    
  }
  
  void disposeAllControllers() {
    for (final controller in videoControllers.values) {
      controller?.dispose();
    }
    videoControllers.clear();
  }
  
  // Add a new video to the feed
  void addVideo(String videoPath, String thumbnailPath) {
    // Create a new video model
    final newVideo = VideoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      videoUrl: videoPath,
      thumbnailUrl: thumbnailPath,
      restaurantName: 'My Restaurant',
      restaurantId: '1',
      restaurantLogoUrl: 'assets/images/pizza.png',
      foodName: 'My Food',
      foodCategory: 'Homemade',
      description: 'Video recorded with Yum Gott app',
      likes: 0,
      comments: 0,
      shares: 0,
      rating: 5.0,
      distance: '0 km',
      userName: 'Me',
      userProfileUrl: 'assets/images/boy.png',
    );
    
    // Add the video to the beginning of the list
    final updatedVideos = <VideoModel>[newVideo];
    updatedVideos.addAll(videos);
    videos.value = updatedVideos;
    
    // Initialize the controller for the new video
    initializeController(0);
    
    // Update current index to show the new video
    currentIndex.value = 0;
  }
}