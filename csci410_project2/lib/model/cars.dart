class Car {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;

  Car(
    this.id,
    this.name,
    this.brand,
    this.price,
    this.description,
    this.imageUrl,
  );

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      json['id'], 
      json['name'],
      json['brand'],
      (json['price'] as num).toDouble(),
      json['description'],
      json['image_url'] ?? 'imgs/logo.png',
    );
  }
}
