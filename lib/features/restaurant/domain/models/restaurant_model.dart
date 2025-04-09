class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final String deliveryTime;
  final double deliveryFee;
  final bool isFavorite;
  final String distance;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isFavorite = false,
    required this.distance,
  });

  // Sample data for testing
  static List<Restaurant> getSampleRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Burger King',
        imageUrl: 'assets/images/restaurant1.jpg',
        rating: 4.5,
        cuisine: 'Fast Food',
        deliveryTime: '15-20 min',
        deliveryFee: 2.99,
        isFavorite: true,
        distance: '1.2 km',
      ),
      Restaurant(
        id: '2',
        name: 'Pizza Hut',
        imageUrl: 'assets/images/restaurant2.jpg',
        rating: 4.2,
        cuisine: 'Italian',
        deliveryTime: '25-30 min',
        deliveryFee: 3.99,
        distance: '2.5 km',
      ),
      Restaurant(
        id: '3',
        name: 'Sushi Palace',
        imageUrl: 'assets/images/restaurant3.jpg',
        rating: 4.8,
        cuisine: 'Japanese',
        deliveryTime: '20-25 min',
        deliveryFee: 4.99,
        distance: '3.0 km',
      ),
      Restaurant(
        id: '4',
        name: 'Taco Bell',
        imageUrl: 'assets/images/restaurant4.jpg',
        rating: 4.0,
        cuisine: 'Mexican',
        deliveryTime: '15-20 min',
        deliveryFee: 2.49,
        distance: '1.8 km',
      ),
      Restaurant(
        id: '5',
        name: 'Subway',
        imageUrl: 'assets/images/restaurant5.jpg',
        rating: 4.3,
        cuisine: 'Sandwiches',
        deliveryTime: '10-15 min',
        deliveryFee: 1.99,
        isFavorite: true,
        distance: '0.8 km',
      ),
    ];
  }
}