class Product {
  final int id;
  final String name;
  final String restaurant;
  final String timestamp;
  final String image;
  final bool selected;

  Product({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.timestamp,
    required this.image,
    this.selected = false,
  });

  Product copyWith({
    int? id,
    String? name,
    String? restaurant,
    String? timestamp,
    String? image,
    bool? selected,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      restaurant: restaurant ?? this.restaurant,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
      selected: selected ?? this.selected,
    );
  }
}