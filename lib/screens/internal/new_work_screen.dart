import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewWorkScreen(),
    );
  }
}

class NewWorkScreen extends StatefulWidget {
  @override
  _NewWorkScreenState createState() => _NewWorkScreenState();
}

class _NewWorkScreenState extends State<NewWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  double total = 0;

  @override
  void initState() {
    super.initState();
    // Set today's date by default
    _dateController.text = DateTime.now()
        .toLocal()
        .toString()
        .split(' ')[0]; // Format to YYYY-MM-DD
  }

  void _calculateTotal() {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 0;
    setState(() {
      total = quantity * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Work'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Name
                  TextFormField(
                    controller: _customerController,
                    decoration: InputDecoration(
                      labelText: 'Customer Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a customer name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Date
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Work Type
                  TextFormField(
                    controller: _workTypeController,
                    decoration: InputDecoration(
                      labelText: 'Work Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a work type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Quantity
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.format_list_numbered),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _calculateTotal(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Rate
                  TextFormField(
                    controller: _rateController,
                    decoration: InputDecoration(
                      labelText: 'Rate',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _calculateTotal(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a rate';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Total
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Total',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calculate),
                    ),
                    readOnly: true,
                    controller:
                        TextEditingController(text: total.toStringAsFixed(2)),
                  ),
                  SizedBox(height: 16),

                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle save logic here
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Success'),
                              content: Text('Work details saved successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: Text('OK'),
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
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customerController.dispose();
    _dateController.dispose();
    _workTypeController.dispose();
    _quantityController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}
