import 'package:flutter/material.dart';
import 'model/cars.dart';
import 'API/api.dart';

class PriceFilterScreen extends StatefulWidget {
  @override
  _PriceFilterScreenState createState() => _PriceFilterScreenState();
}

class _PriceFilterScreenState extends State<PriceFilterScreen> {
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  List<Car> carsList = [];
  bool isLoading = false;

  Future<void> fetchCarsByPrice(double minPrice, double maxPrice) async {
    setState(() {
      isLoading = true;
    });

    List<Car> fetchedCars = await fetchCarsByPriceRange(minPrice, maxPrice);

    setState(() {
      carsList = fetchedCars;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter by Price"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 20, 82, 113),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Price Range:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: minPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Minimum Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: maxPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Maximum Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final double minPrice = double.tryParse(minPriceController.text) ?? 0.0;
                final double maxPrice = double.tryParse(maxPriceController.text) ?? 0.0;

                fetchCarsByPrice(minPrice, maxPrice);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 82, 113),
              ),
              child: const Text("Search"),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: carsList.isEmpty
                        ? const Text("No cars found in this price range.")
                        : ListView.builder(
                            itemCount: carsList.length,
                            itemBuilder: (context, index) {
                              final car = carsList[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                  leading: Image.network(
                                    car.imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(car.name),
                                  subtitle: Text("\$${car.price.toStringAsFixed(2)}"),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
