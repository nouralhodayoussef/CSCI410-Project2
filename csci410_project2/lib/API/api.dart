import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/cars.dart';

Future<List<Car>> fetchData() async {
String path = "http://localhost/cars/CSCI410-Project2/getCars.php";
  Uri url = Uri.parse(path);

  List<Car> carsList = []; 

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonArray = convert.jsonDecode(response.body);
      for (var row in jsonArray) {
        Car car = Car(
          int.parse(row['id']),
          row['name'],
          row['brand'],
          double.parse(row['price']),
          row['description'],
          row['url'],
        );
        carsList.add(car);
      }
    } 
  } catch (exception) {
    print("Exception occurred: $exception");
  }

  return carsList; 
}
