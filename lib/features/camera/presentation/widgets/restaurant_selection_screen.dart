import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/camera/domain/models/restaurant.dart';
import 'package:yum_gott_app/features/camera/presentation/controllers/camera_controller.dart';

class RestaurantSelectionScreen extends StatelessWidget {
  final List<Restaurant> restaurants;
  final Function(Restaurant) onRestaurantSelected;

  const RestaurantSelectionScreen({
    Key? key,
    required this.restaurants,
    required this.onRestaurantSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomCameraController>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Camera.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 47, color: Colors.black.withOpacity(0.5)),
          ),

          /// Close Button
          Positioned(
            top: 63,
            left: 17,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34383B).withOpacity(0.5),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 24),
                    padding: EdgeInsets.zero,
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
          ),

          /// Flash + Rotate buttons
          Positioned(
            top: 63,
            right: 17,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34383B).withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.bolt, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        onPressed: () => controller.toggleFlash(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34383B).withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.rotate_left, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        onPressed: () => controller.switchCamera(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Modal Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Color(0xFF0C0C0C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(19),
                  topRight: Radius.circular(19),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 18,
                  left: 18,
                  right: 18,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 83,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 29),
                      child: Text(
                        'Choose the restaurant you want to Review his Product?',
                        style: AppTheme.headingSmall.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF212326),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Color(0xFF95989D),
                            fontSize: 12,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF95989D),
                            size: 18,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Restaurants list
                    for (int i = 0; i < restaurants.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Radio<int>(
                              value: restaurants[i].id,
                              groupValue: controller.selectedRestaurantId.value,
                              onChanged: (value) {
                                controller.selectedRestaurantId.value = value!;
                              },
                              activeColor: const Color(0xFFB6ED2F),
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return const Color(0xFFB6ED2F);
                                  }
                                  return Colors.white;
                                },
                              ),
                            )),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(11),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          restaurants[i].image,
                                          width: 79,
                                          height: 79,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 12,
                                          right: 8,
                                          left: 2,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              restaurants[i].name,
                                              style: const TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              restaurants[i].description,
                                              style: TextStyle(
                                                fontFamily: 'Vazirmatn',
                                                fontSize: 10,
                                                color: Colors.white.withOpacity(0.6),
                                                height: 1.3,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Color(0xFF95989D),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  restaurants[i].location,
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 10,
                                                    color: Color(0xFF95989D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    /// Note
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Note: \n',
                            style: TextStyle(
                              fontFamily: 'Vazirmatn',
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'You can only make a video review of restaurants and products that you ordered it through the application.',
                            style: TextStyle(
                              fontFamily: 'Vazirmatn',
                              fontSize: 13,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Next button
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          final selectedRestaurant = restaurants.firstWhere(
                            (restaurant) => restaurant.id == controller.selectedRestaurantId.value,
                          );
                          onRestaurantSelected(selectedRestaurant);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB6ED2F),
                          foregroundColor: const Color(0xFF0C0C0C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontFamily: 'Vazirmatn',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
