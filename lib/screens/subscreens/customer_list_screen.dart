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
    customers = [
      Customer(
          name: 'John Doe', contactNumber: '1234567890', pendingAmount: 150.0),
      Customer(
          name: 'Jane Smith',
          contactNumber: '0987654321',
          pendingAmount: 200.0),
      Customer(
          name: 'Alice Johnson',
          contactNumber: '1122334455',
          pendingAmount: 75.0),
      Customer(
          name: 'Bob Brown', contactNumber: '6677889900', pendingAmount: 300.0),
    ];
    filteredCustomers = List.from(customers);
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
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.black), // Set background color to black
                          foregroundColor: MaterialStateProperty.all(
                              Colors.white), // Set text color to white
                        ),
                        onPressed: () {
                          searchCustomers(searchController.text);
                        },
                        child: const Text('Search'),
                      ),
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
