import 'package:farm_track/screens/dialogs/customer_registration_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  final List<String> _customerNames = [
    "John Doe",
    "Jane Smith",
    "Bob Johnson",
    "Alice Williams"
  ];

  final TextEditingController _platesQuantityController =
      TextEditingController();
  final TextEditingController _givenDateController = TextEditingController();
  final TextEditingController _receivedDateController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _receivedAmountController =
      TextEditingController();
  final TextEditingController _pendingAmountController =
      TextEditingController();

  String? _selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _selectedCustomer = null;
                    _platesQuantityController.clear();
                    _givenDateController.clear();
                    _receivedDateController.clear();
                    _totalAmountController.clear();
                    _receivedAmountController.clear();
                    _pendingAmountController.clear();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF3b4a37),
                    side: const BorderSide(
                      color: Color(0xFF3b4a37),
                      width: 0.5,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Record saved successfully!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                _selectedCustomer = null;
                                _platesQuantityController.clear();
                                _givenDateController.clear();
                                _receivedDateController.clear();
                                _totalAmountController.clear();
                                _receivedAmountController.clear();
                                _pendingAmountController.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b4a37),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 54, bottom: 20),
        child: SingleChildScrollView(
          child: Center(
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
                        // Customer Name Dropdown with Add button
                        Row(
                          children: [
                            Expanded(
                              child: DropdownSearch<String>(
                                items: _customerNames,
                                selectedItem: _selectedCustomer,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: 'Customer Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCustomer = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a customer';
                                  }
                                  return null;
                                },
                                popupProps: const PopupProps.menu(
                                  showSearchBox: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), // Spacing
                            // Add button
                            ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CustomerRegistrationDialog(
                                    onRegister: (customerName, address,
                                        contactNumber, aadharNumber) {
                                      setState(() {
                                        // Handle the registration logic here, e.g., add to the customer list
                                        _customerNames.add(customerName);
                                      });
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3b4a37),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Given Date field
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
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              _givenDateController.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Received Date field
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
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              _receivedDateController.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Plates Quantity field
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
                              return 'Please enter the plates quantity';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Total Amount field
                        TextFormField(
                          controller: _totalAmountController,
                          decoration: InputDecoration(
                            labelText: 'Total Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.money),
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
                        // Received Amount field
                        TextFormField(
                          controller: _receivedAmountController,
                          decoration: InputDecoration(
                            labelText: 'Received Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.money_off),
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
                        // Pending Amount field
                        TextFormField(
                          controller: _pendingAmountController,
                          decoration: InputDecoration(
                            labelText: 'Pending Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.money_off),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pending amount';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
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
    _platesQuantityController.dispose();
    _givenDateController.dispose();
    _receivedDateController.dispose();
    _totalAmountController.dispose();
    _receivedAmountController.dispose();
    _pendingAmountController.dispose();
    super.dispose();
  }
}
