class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String restaurantName;
  final String restaurantId;
  final bool isFavorite;
  final String description;
  final List<String> categories;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.restaurantName,
    required this.restaurantId,
    this.isFavorite = false,
    required this.description,
    required this.categories,
  });

  // Sample data for testing
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Double Cheeseburger',
        imageUrl: 'assets/images/product1.jpg',
        price: 8.99,
        rating: 4.7,
        restaurantName: 'Burger King',
        restaurantId: '1',
        isFavorite: true,
        description: 'Delicious double cheeseburger with fresh vegetables and special sauce.',
        categories: ['Burger', 'Fast Food'],
      ),
      Product(
        id: '2',
        name: 'Pepperoni Pizza',
        imageUrl: 'assets/images/product2.jpg',
        price: 12.99,
        rating: 4.5,
        restaurantName: 'Pizza Hut',
        restaurantId: '2',
        description: 'Classic pepperoni pizza with extra cheese and tomato sauce.',
        categories: ['Pizza', 'Italian'],
      ),
      Product(
        id: '3',
        name: 'California Roll',
        imageUrl: 'assets/images/product3.jpg',
        price: 9.99,
        rating: 4.8,
        restaurantName: 'Sushi Palace',
        restaurantId: '3',
        isFavorite: true,
        description: 'Fresh California roll with avocado, crab, and cucumber.',
        categories: ['Sushi', 'Japanese'],
      ),
      Product(
        id: '4',
        name: 'Chicken Tacos',
        imageUrl: 'assets/images/product4.jpg',
        price: 7.99,
        rating: 4.2,
        restaurantName: 'Taco Bell',
        restaurantId: '4',
        description: 'Spicy chicken tacos with fresh salsa and guacamole.',
        categories: ['Tacos', 'Mexican'],
      ),
      Product(
        id: '5',
        name: 'Italian BMT',
        imageUrl: 'assets/images/product5.jpg',
        price: 6.99,
        rating: 4.4,
        restaurantName: 'Subway',
        restaurantId: '5',
        description: 'Italian BMT sandwich with salami, pepperoni, and ham.',
        categories: ['Sandwich', 'Fast Food'],
      ),
    ];
  }

  // Get popular products
  static List<Product> getPopularProducts() {
    final allProducts = getSampleProducts();
    allProducts.sort((a, b) => b.rating.compareTo(a.rating));
    return allProducts.take(3).toList();
  }

  // Get recommended products
  static List<Product> getRecommendedProducts() {
    final allProducts = getSampleProducts();
    // In a real app, this would be based on user preferences
    return allProducts.where((product) => product.isFavorite).toList();
  }
}