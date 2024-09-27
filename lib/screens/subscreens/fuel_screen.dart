import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 221, 240, 218),
        ),
        useMaterial3: true,
      ),
      home: const FuelScreen(),
    );
  }
}

class FuelScreen extends StatefulWidget {
  const FuelScreen({Key? key}) : super(key: key);

  @override
  _FuelScreenState createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _stationNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Allow scrolling for the screen
        child: Center(
          // Center the card
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fuel Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Type
                      TextFormField(
                        controller: _typeController,
                        decoration: InputDecoration(
                          labelText: 'Fuel Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.local_gas_station),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the fuel type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Quantity
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity (Liters)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.format_list_numbered),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the quantity';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Price
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price per Liter',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.monetization_on),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Total
                      TextFormField(
                        controller: _totalController,
                        decoration: InputDecoration(
                          labelText: 'Total Cost',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the total cost';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Station Name
                      TextFormField(
                        controller: _stationNameController,
                        decoration: InputDecoration(
                          labelText: 'Station Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.local_gas_station),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the station name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Submit Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle successful submission here
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Success'),
                                  content: const Text(
                                      'Fuel details submitted successfully!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF3b4a37), // Button color
                            foregroundColor: Colors.white, // Text color
                          ),
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _typeController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _totalController.dispose();
    _stationNameController.dispose();
    super.dispose();
  }
}
