class Car {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;


  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  List<Car> carsList = [];

}