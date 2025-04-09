class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String iconUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.iconUrl,
  });

  // Sample data for testing
  static List<Category> getSampleCategories() {
    return [
      Category(
        id: '1',
        name: 'Burger',
        imageUrl: 'assets/images/category_burger.jpg',
        iconUrl: 'assets/icons/burger_icon.png',
      ),
      Category(
        id: '2',
        name: 'Pizza',
        imageUrl: 'assets/images/category_pizza.jpg',
        iconUrl: 'assets/icons/pizza_icon.png',
      ),
      Category(
        id: '3',
        name: 'Sushi',
        imageUrl: 'assets/images/category_sushi.jpg',
        iconUrl: 'assets/icons/sushi_icon.png',
      ),
      Category(
        id: '4',
        name: 'Tacos',
        imageUrl: 'assets/images/category_tacos.jpg',
        iconUrl: 'assets/icons/tacos_icon.png',
      ),
      Category(
        id: '5',
        name: 'Sandwich',
        imageUrl: 'assets/images/category_sandwich.jpg',
        iconUrl: 'assets/icons/sandwich_icon.png',
      ),
      Category(
        id: '6',
        name: 'Dessert',
        imageUrl: 'assets/images/category_dessert.jpg',
        iconUrl: 'assets/icons/dessert_icon.png',
      ),
      Category(
        id: '7',
        name: 'Drinks',
        imageUrl: 'assets/images/category_drinks.jpg',
        iconUrl: 'assets/icons/drinks_icon.png',
      ),
    ];
  }
}