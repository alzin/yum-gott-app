import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/home/domain/models/category_model.dart';
import 'package:yum_gott_app/features/home/presentation/controllers/home_controller.dart';
import 'package:yum_gott_app/features/home/presentation/widgets/category_item.dart';
import 'package:yum_gott_app/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:yum_gott_app/features/home/presentation/widgets/section_header.dart';
import 'package:yum_gott_app/features/product/domain/models/product_model.dart';
import 'package:yum_gott_app/features/product/presentation/widgets/product_card.dart';
import 'package:yum_gott_app/features/restaurant/domain/models/restaurant_model.dart';
import 'package:yum_gott_app/features/restaurant/presentation/widgets/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          child: CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                backgroundColor: AppTheme.darkBackground,
                floating: true,
                title: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deliver to',
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Current Location',
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  // Notifications button
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Navigate to notifications screen
                    },
                  ),
                ],
              ),

              // Search bar
              SliverToBoxAdapter(
                child: SearchBarWidget(
                  onFilterTap: () {
                    // Show filter options
                  },
                ),
              ),

              // Categories
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Categories',
                    ),
                    SizedBox(
                      height: 110,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return Obx(
                              () => CategoryItem(
                                category: category,
                                isSelected: controller.selectedCategoryIndex.value == index,
                                onTap: () => controller.selectCategory(index),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Featured restaurants
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Featured Restaurants',
                      actionText: 'See All',
                      onActionTap: () {
                        // Navigate to all restaurants screen
                      },
                    ),
                    SizedBox(
                      height: 220,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.featuredRestaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = controller.featuredRestaurants[index];
                            return RestaurantCard(
                              restaurant: restaurant,
                              onTap: () => controller.navigateToRestaurantDetails(restaurant.id),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Popular dishes
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Popular Dishes',
                      actionText: 'See All',
                      onActionTap: () {
                        // Navigate to all popular dishes screen
                      },
                    ),
                    SizedBox(
                      height: 220,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.popularProducts.length,
                          itemBuilder: (context, index) {
                            final product = controller.popularProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () => controller.navigateToProductDetails(product.id),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Recommended for you
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Recommended for You',
                      actionText: 'See All',
                      onActionTap: () {
                        // Navigate to all recommended dishes screen
                      },
                    ),
                    SizedBox(
                      height: 220,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.recommendedProducts.length,
                          itemBuilder: (context, index) {
                            final product = controller.recommendedProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () => controller.navigateToProductDetails(product.id),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Nearby restaurants
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Nearby Restaurants',
                      actionText: 'See All',
                      onActionTap: () {
                        // Navigate to all nearby restaurants screen
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () => Column(
                          children: controller.nearbyRestaurants
                              .take(3)
                              .map(
                                (restaurant) => RestaurantCard(
                                  restaurant: restaurant,
                                  isHorizontal: true,
                                  onTap: () => controller.navigateToRestaurantDetails(restaurant.id),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
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
              // Navigate to add content screen
              // Get.toNamed(AppRoutes.addContent);
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
    );
  }
}