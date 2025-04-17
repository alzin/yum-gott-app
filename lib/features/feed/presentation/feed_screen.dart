import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:yum_gott_app/features/feed/presentation/widgets/video_player_item.dart';
import 'package:yum_gott_app/routes.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  late FeedController _feedController;

  @override
  void initState() {
    super.initState();
    _feedController = Get.put(FeedController());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause videos when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      final currentVideo = _feedController.videos[_feedController.currentIndex.value];
      final controller = _feedController.videoControllers[currentVideo.id];
      controller?.pause();
    }
    
    // When app is resumed, play current video if it was playing before
    if (state == AppLifecycleState.resumed) {
      final currentVideo = _feedController.videos[_feedController.currentIndex.value];
      final controller = _feedController.videoControllers[currentVideo.id];
      controller?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () {
          if (_feedController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          if (_feedController.videos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.video_library,
                    color: Colors.white,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No videos available',
                    style: AppTheme.headingMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _feedController.loadVideos(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _feedController.videos.length,
            onPageChanged: _feedController.onPageChanged,
            itemBuilder: (context, index) {
              final video = _feedController.videos[index];
              return VideoPlayerItem(
                video: video,
                index: index,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF1F1F29),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF1F1F29),
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, size: 40),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {
            // Handle navigation
            switch (index) {
              case 0:
                // Already on home screen
                break;
              case 1:
                // Navigate to search screen
                // Get.toNamed(AppRoutes.search);
                break;
              case 2:
                // Navigate to camera screen
                Get.toNamed(AppRoutes.camera);
                break;
              case 3:
                // Navigate to cart screen
                // Get.toNamed(AppRoutes.cart);
                break;
              case 4:
                // Navigate to profile screen
                // Get.toNamed(AppRoutes.profile);
                break;
            }
          },
        ),
      ),
    );
  }
}