import 'package:get/get.dart';
import 'package:yum_gott_app/features/home/domain/models/category_model.dart';
import 'package:yum_gott_app/features/product/domain/models/product_model.dart';
import 'package:yum_gott_app/features/restaurant/domain/models/restaurant_model.dart';

class HomeController extends GetxController {
  // Selected category index
  final RxInt selectedCategoryIndex = 0.obs;
  
  // Categories
  final RxList<Category> categories = <Category>[].obs;
  
  // Featured restaurants
  final RxList<Restaurant> featuredRestaurants = <Restaurant>[].obs;
  
  // Nearby restaurants
  final RxList<Restaurant> nearbyRestaurants = <Restaurant>[].obs;
  
  // Popular products
  final RxList<Product> popularProducts = <Product>[].obs;
  
  // Recommended products
  final RxList<Product> recommendedProducts = <Product>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  
  void loadData() {
    // Load categories
    categories.value = Category.getSampleCategories();
    
    // Load restaurants
    final allRestaurants = Restaurant.getSampleRestaurants();
    featuredRestaurants.value = allRestaurants;
    nearbyRestaurants.value = allRestaurants;
    
    // Load products
    popularProducts.value = Product.getPopularProducts();
    recommendedProducts.value = Product.getRecommendedProducts();
  }
  
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    // In a real app, we would filter restaurants and products based on the selected category
  }
  
  void navigateToRestaurantDetails(String restaurantId) {
    // Navigate to restaurant details screen
    // Get.toNamed(AppRoutes.restaurantDetails, arguments: restaurantId);
  }
  
  void navigateToProductDetails(String productId) {
    // Navigate to product details screen
    // Get.toNamed(AppRoutes.productDetails, arguments: productId);
  }
  
  void toggleFavoriteRestaurant(String restaurantId) {
    // Toggle favorite status for a restaurant
    // In a real app, this would update the database
  }
  
  void toggleFavoriteProduct(String productId) {
    // Toggle favorite status for a product
    // In a real app, this would update the database
  }
}