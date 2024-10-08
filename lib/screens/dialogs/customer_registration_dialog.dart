import 'package:flutter/material.dart';

class CustomerRegistrationDialog extends StatelessWidget {
  final Function(String, String, String, String?) onRegister;

  CustomerRegistrationDialog({required this.onRegister});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _customerNameController =
        TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _contactNumberController =
        TextEditingController();
    final TextEditingController _aadharNumberController =
        TextEditingController();

    return AlertDialog(
      title: const Text('New Customer'),
      content: SizedBox(
        height: 300, // Adjust height as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
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
              TextFormField(
                controller: _aadharNumberController,
                decoration: InputDecoration(
                  labelText: 'Aadhar Number (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.assignment),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final customerName = _customerNameController.text;
            final address = _addressController.text;
            final contactNumber = _contactNumberController.text;
            final aadharNumber = _aadharNumberController.text.isNotEmpty
                ? _aadharNumberController.text
                : null;

            if (customerName.isNotEmpty &&
                address.isNotEmpty &&
                contactNumber.isNotEmpty) {
              onRegister(customerName, address, contactNumber, aadharNumber);
              Navigator.pop(context); // Close the dialog
            } else {
              // Show a Snackbar for incomplete fields
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please fill in all required fields')),
              );
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
