import 'package:flutter/material.dart';

class FuelEntry {
  final DateTime date;
  final double quantity;
  final double amount;

  FuelEntry({
    required this.date,
    required this.quantity,
    required this.amount,
  });
}

class FuelListScreen extends StatefulWidget {
  const FuelListScreen({Key? key}) : super(key: key);

  @override
  _FuelListScreenState createState() => _FuelListScreenState();
}

class _FuelListScreenState extends State<FuelListScreen> {
  List<FuelEntry> fuelEntries = [];
  List<FuelEntry> filteredFuelEntries = [];
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fuelEntries = [
      FuelEntry(date: DateTime(2024, 10, 1), quantity: 50, amount: 100.0),
      FuelEntry(date: DateTime(2024, 10, 5), quantity: 60, amount: 120.0),
      FuelEntry(date: DateTime(2024, 10, 6), quantity: 40, amount: 80.0),
      FuelEntry(date: DateTime(2024, 10, 7), quantity: 30, amount: 60.0),
    ];
    filteredFuelEntries = List.from(fuelEntries);
  }

  void searchByDate(String dateString) {
    setState(() {
      filteredFuelEntries = fuelEntries.where((entry) {
        return entry.date.toLocal().toString().split(' ')[0] == dateString;
      }).toList();
    });
  }

  Future<void> pickDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode()); // Close keyboard
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      searchByDate(dateController.text); // Filter list by selected date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Filter by Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () => pickDate(context),
                    readOnly: true, // Prevents keyboard from appearing
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    searchByDate(dateController.text);
                  },
                  child: const Text('Filter'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFuelEntries.length,
                itemBuilder: (context, index) {
                  final fuelEntry = filteredFuelEntries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                          'Date: ${fuelEntry.date.toLocal().toString().split(' ')[0]}'),
                      subtitle: Text('Quantity: ${fuelEntry.quantity} L'),
                      trailing: Text('₹${fuelEntry.amount.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
