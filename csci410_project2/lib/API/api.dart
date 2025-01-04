import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../model/cars.dart';

List<Car> carsList = [];

Future<List<Car>> fetchData() async {
  try {
    final url = Uri.http("csci410cargallery.atwebpages.com","/getCars.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      carsList.clear();
      final jsonArray = convert.jsonDecode(response.body);

      for (var row in jsonArray) {
        Car car = Car(
          int.parse(row['id'] ?? '0'),
          row['name'] ?? 'Unknown',
          row['brand'] ?? 'Unknown',
          double.parse(row['price'] ?? '0.0'),
          row['description'] ?? '',
          row['url'] ?? 'imgs/tesla-model-3.png',
        );
        carsList.add(car);
      }
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (exception) {
    print("Exception occurred: $exception");
  }

  return carsList;
}

Future<List<Car>> fetchCarsByPriceRange(
    double minPrice, double maxPrice) async {
  final url = Uri.http(
  'csci410cargallery.atwebpages.com',
  '/getCarsByPrice.php',
  {
    'min_price': minPrice.toString(),
    'max_price': maxPrice.toString(),
  },
);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    carsList.clear();
    final List<dynamic> jsonArray = json.decode(response.body);

    for (var row in jsonArray) {
      Car car = Car(
        int.tryParse(row['id'].toString()) ?? 0, 
        row['name'] ?? 'Unknown',
        row['brand'] ?? 'Unknown',
        double.tryParse(row['price'].toString()) ?? 0.0, 
        row['description'] ?? '',
        row['url'] ?? 'imgs/logo.png', 
      );
      carsList.add(car);
    }
  } else {
    print('Failed to fetch cars by price: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to fetch cars by price');
  }

  return carsList;
}

