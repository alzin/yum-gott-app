import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/camera/domain/models/product.dart';
import 'package:yum_gott_app/features/camera/presentation/controllers/camera_controller.dart';

// ...imports remain the same

class ProductSelectionScreen extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onProductSelected;

  const ProductSelectionScreen({
    Key? key,
    required this.products,
    required this.onProductSelected,
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
            child: Image.asset('assets/images/Camera.png', fit: BoxFit.cover),
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

          // Close Button
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

          // Flash + Rotate
          Positioned(
            top: 63,
            right: 17,
            child: Column(
              children: [
                _glassIconButton(() => controller.toggleFlash(), Icons.bolt),
                const SizedBox(height: 12),
                _glassIconButton(() => controller.switchCamera(), Icons.rotate_left),
              ],
            ),
          ),

          // Modal with scrollable content
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
                    _handleBar(),
                    const SizedBox(height: 29),
                    Text(
                      'Choose the Products that you want to Review?',
                      style: AppTheme.headingSmall.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Vazirmatn',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    _searchBar(),
                    const SizedBox(height: 30),

                    /// Grid inside scroll
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Obx(() {
                          final isSelected = controller.selectedProductId.value == product.id;
                          return GestureDetector(
                            onTap: () => controller.selectedProductId.value = product.id,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFB6ED2F) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 82,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(product.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.black : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    product.restaurant,
                                    style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: isSelected ? Colors.black : const Color(0xFFE7E7E7),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    product.timestamp,
                                    style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300,
                                      color: isSelected ? Colors.black : const Color(0xFFD2D2D2),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),

                    const SizedBox(height: 24),
                    _noteSection(),
                    const SizedBox(height: 20),
                    _nextButton(context, products, onProductSelected, controller),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassIconButton(VoidCallback onPressed, IconData icon) {
    return ClipRRect(
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
            icon: Icon(icon, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  Widget _handleBar() => Container(
        width: 83,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(1.5),
        ),
      );

  Widget _searchBar() => Container(
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
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Color(0xFF95989D),
              fontSize: 12,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF95989D),
              size: 18,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 11),
          ),
        ),
      );

  Widget _noteSection() => RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Note: \n',
              style: TextStyle(
                fontFamily: 'Vazirmatn',
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text:
                  'You can only make a video review of restaurants and products that you ordered through the application.',
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
      );

  Widget _nextButton(BuildContext context, List<Product> products,
      Function(Product) onProductSelected, CustomCameraController controller) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: () {
          final selectedProduct = products.firstWhere(
            (product) => product.id == controller.selectedProductId.value,
          );
          onProductSelected(selectedProduct);
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
    );
  }
}

