import 'package:farm_track/databese/database_helper.dart';
import 'package:flutter/material.dart';

class Customer {
  final String name;
  final String contactNumber;
  final double pendingAmount;

  Customer({
    required this.name,
    required this.contactNumber,
    required this.pendingAmount,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'],
      contactNumber: map['contact'],
      pendingAmount: map['pendingAmount'] ?? 0.0,
    );
  }
}

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<Customer> customers = [];
  List<Customer> filteredCustomers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  // Load customers from SQLite database
  Future<void> _loadCustomers() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> customerMaps = await dbHelper.getCustomers();
    List<Customer> loadedCustomers =
        customerMaps.map((map) => Customer.fromMap(map)).toList();
    setState(() {
      customers = loadedCustomers;
      filteredCustomers = List.from(loadedCustomers);
    });
  }

  void searchCustomers(String query) {
    setState(() {
      filteredCustomers = customers.where((customer) {
        return customer.name.toLowerCase().contains(query.toLowerCase()) ||
            customer.contactNumber.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 54.0), // Top padding
          child: Card(
            elevation: 8, // Card shadow
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Search by Name or Contact No',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) => searchCustomers(value),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = filteredCustomers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(customer.name),
                            subtitle:
                                Text('Contact: ${customer.contactNumber}'),
                            trailing: Text(
                                '\$${customer.pendingAmount.toStringAsFixed(2)}'),
                          ),
                        );
                      },
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
    searchController.dispose();
    super.dispose();
  }
}
