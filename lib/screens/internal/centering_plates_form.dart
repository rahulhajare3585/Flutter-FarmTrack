import 'package:farm_track/databese/database_helper.dart';
import 'package:farm_track/screens/dialogs/customer_registration_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CenteringPlatesScreen extends StatefulWidget {
  @override
  _CenteringPlatesScreenState createState() => _CenteringPlatesScreenState();
}

class _CenteringPlatesScreenState extends State<CenteringPlatesScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> _customerNames = []; // Will be populated from the database

  final TextEditingController _platesQuantityController =
      TextEditingController();
  final TextEditingController _givenDateController = TextEditingController();
  final TextEditingController _receivedDateController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _receivedAmountController =
      TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _pendingAmountController =
      TextEditingController();
  final TextEditingController _totalDaysController =
      TextEditingController(); // New Controller for Total Days

  String? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _setDefaultGivenDate(); // Set today's date by default for Given Date
  }

  Future<void> _loadCustomers() async {
    var dbHelper = DatabaseHelper();
    var customers = await dbHelper.getCustomers();
    setState(() {
      _customerNames =
          customers.map((customer) => customer['name'] as String).toList();
    });
  }

  // Set today's date by default for Given Date
  void _setDefaultGivenDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    setState(() {
      _givenDateController.text = formattedDate;
    });
  }

  // Calculate the total days between Given Date and Received Date
  void _calculateTotalDays() {
    if (_givenDateController.text.isNotEmpty &&
        _receivedDateController.text.isNotEmpty) {
      DateTime? givenDate = _parseDate(_givenDateController.text);
      DateTime? receivedDate = _parseDate(_receivedDateController.text);

      if (givenDate != null && receivedDate != null) {
        int differenceInDays = receivedDate.difference(givenDate).inDays;
        _totalDaysController.text = differenceInDays.toString();
      }
    }
  }

  // Calculate the total amount
  void _calculateTotalAmount() {
    if (_totalDaysController.text.isNotEmpty &&
        _rateController.text.isNotEmpty &&
        _platesQuantityController.text.isNotEmpty) {
      // Parse input values
      int totalDays = int.tryParse(_totalDaysController.text) ?? 0;
      double ratePer100Plates = double.tryParse(_rateController.text) ?? 0;
      int plateQuantity = int.tryParse(_platesQuantityController.text) ?? 0;

      if (totalDays > 0 && ratePer100Plates > 0 && plateQuantity > 0) {
        // Calculate number of 100-plate batches
        double plateBatches = plateQuantity / 100;

        // Calculate the total amount based on the number of days and batches
        double totalAmount = (ratePer100Plates / 30) * totalDays * plateBatches;

        // Update the total amount in the controller
        setState(() {
          _totalAmountController.text = totalAmount.toStringAsFixed(2);
        });
      }
    }
  }

//calculate pending amount
  void _calculatePendingAmount() {
    double totalAmount = double.tryParse(_totalAmountController.text) ?? 0;
    double receivedAmount =
        double.tryParse(_receivedAmountController.text) ?? 0;
    double pendingAmount = totalAmount - receivedAmount;
    setState(() {
      _pendingAmountController.text = pendingAmount.toStringAsFixed(2);
    });
  }

  // Helper method to parse the date string
  DateTime? _parseDate(String date) {
    try {
      List<String> parts = date.split('-');
      return DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                    _totalDaysController.clear();
                    _rateController.clear();
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
                                _totalDaysController.clear();
                                _rateController.clear();
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
                            const SizedBox(width: 10),
                            // Add button
                            ElevatedButton.icon(
                              onPressed: () {
                                // Implement the logic to add a new customer
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CustomerRegistrationDialog(
                                    onRegister: (customerName, address,
                                        contactNumber, aadharNumber) async {
                                      var dbHelper = DatabaseHelper();
                                      await dbHelper.insertCustomer(
                                        customerName,
                                        address,
                                        contactNumber,
                                        aadharNumber,
                                      );
                                      await _loadCustomers();
                                      setState(() {
                                        _selectedCustomer = customerName;
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
                              String formattedDate =
                                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                              setState(() {
                                _givenDateController.text = formattedDate;
                                _calculateTotalDays();
                              });
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
                              String formattedDate =
                                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                              setState(() {
                                _receivedDateController.text = formattedDate;
                                _calculateTotalDays(); // Recalculate the total days
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Total Days field (calculated automatically)
                        TextFormField(
                          controller: _totalDaysController,
                          decoration: InputDecoration(
                            labelText: 'Total Days',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.date_range),
                          ),
                          readOnly: true, // This field is read-only
                        ),
                        const SizedBox(height: 16),
                        // Plates Quantity field
                        TextFormField(
                          controller: _platesQuantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Plates Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.format_list_numbered),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the quantity of plates';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Rate Quantity field
                        TextFormField(
                          controller: _rateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Rate',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.format_list_numbered),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Rate of 100 plates/month';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Recalculate total amount when rate is changed
                            _calculateTotalAmount();
                          },
                        ),
                        const SizedBox(height: 16),
                        // Total Amount field
                        TextFormField(
                          controller: _totalAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Total Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Received Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the received amount';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _calculatePendingAmount();
                          },
                        ),
                        const SizedBox(height: 16),
                        // Pending Amount field (calculated from total and received amount)
                        TextFormField(
                          controller: _pendingAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Pending Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.money_off),
                          ),
                          readOnly: true, // Automatically calculated
                        ),
                        const SizedBox(height: 16),
                        // Calculate pending amount when total and received amounts are filled
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
}
