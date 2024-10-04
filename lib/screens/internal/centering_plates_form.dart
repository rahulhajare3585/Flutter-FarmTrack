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
      home: const CenteringPlatesScreen(),
    );
  }
}

class CenteringPlatesScreen extends StatefulWidget {
  const CenteringPlatesScreen({Key? key}) : super(key: key);

  @override
  _CenteringPlatesScreenState createState() => _CenteringPlatesScreenState();
}

class _CenteringPlatesScreenState extends State<CenteringPlatesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _platesQuantityController =
      TextEditingController();
  final TextEditingController _givenDateController = TextEditingController();
  final TextEditingController _receivedDateController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _receivedAmountController =
      TextEditingController();
  final TextEditingController _pendingAmountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Make the whole screen scrollable
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
                        'Centering Plates Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Customer Name
                      TextFormField(
                        controller: _customerNameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the customer name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Address
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Contact No
                      TextFormField(
                        controller: _contactNoController,
                        decoration: InputDecoration(
                          labelText: 'Contact No',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the contact number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Plates Quantity
                      TextFormField(
                        controller: _platesQuantityController,
                        decoration: InputDecoration(
                          labelText: 'Plates Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.format_list_numbered),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the quantity of plates';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Given Date
                      TextFormField(
                        controller: _givenDateController,
                        decoration: InputDecoration(
                          labelText: 'Given Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the given date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Received Date
                      TextFormField(
                        controller: _receivedDateController,
                        decoration: InputDecoration(
                          labelText: 'Received Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the received date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Total Amount
                      TextFormField(
                        controller: _totalAmountController,
                        decoration: InputDecoration(
                          labelText: 'Total Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the total amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Received Amount
                      TextFormField(
                        controller: _receivedAmountController,
                        decoration: InputDecoration(
                          labelText: 'Received Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the received amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Pending Amount
                      TextFormField(
                        controller: _pendingAmountController,
                        decoration: InputDecoration(
                          labelText: 'Pending Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the pending amount';
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
                                      'Centering plates details submitted successfully!'),
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
    _customerNameController.dispose();
    _addressController.dispose();
    _contactNoController.dispose();
    _platesQuantityController.dispose();
    _givenDateController.dispose();
    _receivedDateController.dispose();
    _totalAmountController.dispose();
    _receivedAmountController.dispose();
    _pendingAmountController.dispose();
    super.dispose();
  }
}
