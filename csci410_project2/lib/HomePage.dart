import 'package:flutter/material.dart';
import 'CarCard.dart';
import 'API/api.dart';
import 'model/cars.dart';
import 'PriceFilterScreen.dart';
import 'requestCar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Car> carsList = [];
  List<Car> filteredCarsList = [];
  List<String> brands = ['All'];
  String selectedBrand = 'All';

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    List<Car> fetchedCars = await fetchData();

    List<String> fetchedBrands = ['All'];
    for (var car in fetchedCars) {
      if (!fetchedBrands.contains(car.brand)) {
        fetchedBrands.add(car.brand);
      }
    }

    setState(() {
      carsList = fetchedCars;
      filteredCarsList = fetchedCars;
      brands = fetchedBrands;
    });
  }

  void filterCars(String brand) {
    setState(() {
      selectedBrand = brand;
      if (brand == 'All') {
        filteredCarsList = carsList;
      } else {
        filteredCarsList = carsList.where((car) => car.brand == brand).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars List"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 20, 82, 113),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PriceFilterScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestCarScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands.map((brand) {
                  final isSelected = selectedBrand == brand;
                  return GestureDetector(
                    onTap: () => filterCars(brand),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255, 20, 82, 113)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        brand,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: filteredCarsList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: filteredCarsList.length,
                    itemBuilder: (context, index) {
                      final car = filteredCarsList[index];
                      return CarCard(car: car);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
