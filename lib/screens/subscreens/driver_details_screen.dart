import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DriverDetailsScreen(),
    );
  }
}

class DriverDetailsScreen extends StatefulWidget {
  @override
  _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _dojController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  // Date pickers
  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.toLocal()}".split(' ')[0]; // Format date to YYYY-MM-DD
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card to contain the form
            Card(
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
                      // Header for Driver Details
                      const Text(
                        'Driver Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Village
                      TextFormField(
                        controller: _villageController,
                        decoration: InputDecoration(
                          labelText: 'Village',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.location_city_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a village';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Telephone
                      TextFormField(
                        controller: _telController,
                        decoration: InputDecoration(
                          labelText: 'Telephone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a telephone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // District
                      TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.map_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a district';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Contact No
                      TextFormField(
                        controller: _contactNoController,
                        decoration: InputDecoration(
                          labelText: 'Contact No',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.contact_phone_outlined),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a contact number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Date of Birth
                      TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _dobController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date of birth';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Date of Joining
                      TextFormField(
                        controller: _dojController,
                        decoration: InputDecoration(
                          labelText: 'Date of Joining',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _dojController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date of joining';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Salary
                      TextFormField(
                        controller: _salaryController,
                        decoration: InputDecoration(
                          labelText: 'Salary',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.attach_money_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a salary';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Submit Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Show a dialog box on successful submission
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Success'),
                                  content:
                                      Text('Details Submitted Successfully!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
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
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _villageController.dispose();
    _telController.dispose();
    _districtController.dispose();
    _contactNoController.dispose();
    _dobController.dispose();
    _dojController.dispose();
    _salaryController.dispose();
    super.dispose();
  }
}
