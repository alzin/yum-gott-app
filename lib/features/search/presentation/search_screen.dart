import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/product/domain/models/product_model.dart';
import 'package:yum_gott_app/features/product/presentation/widgets/product_card.dart';
import 'package:yum_gott_app/features/restaurant/domain/models/restaurant_model.dart';
import 'package:yum_gott_app/features/restaurant/presentation/widgets/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<Restaurant> _restaurants = [];
  final List<Product> _products = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _restaurants.clear();
        _products.clear();
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      
      // Filter restaurants by name or cuisine
      _restaurants.clear();
      _restaurants.addAll(
        Restaurant.getSampleRestaurants().where(
          (restaurant) => restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
              restaurant.cuisine.toLowerCase().contains(query.toLowerCase()),
        ),
      );
      
      // Filter products by name
      _products.clear();
      _products.addAll(
        Product.getSampleProducts().where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.restaurantName.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: TextField(
          controller: _searchController,
          style: AppTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Search for restaurants or dishes',
            hintStyle: AppTheme.bodyMedium.copyWith(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  )
                : null,
          ),
          onChanged: _performSearch,
          autofocus: true,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Restaurants'),
            Tab(text: 'Dishes'),
          ],
        ),
      ),
      body: _isSearching
          ? TabBarView(
              controller: _tabController,
              children: [
                // Restaurants tab
                _restaurants.isEmpty
                    ? const Center(
                        child: Text('No restaurants found'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurant: _restaurants[index],
                            isHorizontal: true,
                            onTap: () {
                              // Navigate to restaurant details
                            },
                          );
                        },
                      ),
                
                // Dishes tab
                _products.isEmpty
                    ? const Center(
                        child: Text('No dishes found'),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: _products[index],
                            onTap: () {
                              // Navigate to product details
                            },
                          );
                        },
                      ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 80,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search for restaurants or dishes',
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}