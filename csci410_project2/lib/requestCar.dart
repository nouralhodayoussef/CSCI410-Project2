import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestCarScreen extends StatefulWidget {
  @override
  _RequestCarScreenState createState() => _RequestCarScreenState();
}

class _RequestCarScreenState extends State<RequestCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carDetailsController = TextEditingController();

  Future<void> submitRequest() async {
    final url = Uri.http(
        'csci410cargallery.atwebpages.com','/request_car.php');

    final response = await http.post(
      url,
      body: {
        'user_name': userNameController.text,
        'user_email': userEmailController.text,
        'car_name': carNameController.text,
        'car_brand': carBrandController.text,
        'car_details': carDetailsController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit request.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Car"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 82, 113),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: userEmailController,
                decoration: InputDecoration(labelText: 'Your Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: carNameController,
                decoration: InputDecoration(labelText: 'Car Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: carBrandController,
                decoration: InputDecoration(labelText: 'Car Brand'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car brand';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: carDetailsController,
                decoration: InputDecoration(labelText: 'Car Details'),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    submitRequest();
                  }
                },
                child: Text('Submit Request', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 20, 82, 113),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
