import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FarmTrack'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.local_gas_station), text: "Fuel"),
            Tab(icon: Icon(Icons.person_outline), text: "Customer"),
            Tab(icon: Icon(Icons.people_outline), text: "Employee"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTab(),
          FuelTab(),
          CustomerTab(),
          EmployeeTab(),
        ],
      ),
    );
  }
}

// Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Fuel Tab
class FuelTab extends StatelessWidget {
  const FuelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Fuel Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Customer Tab
class CustomerTab extends StatelessWidget {
  const CustomerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Customer Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Employee Tab
class EmployeeTab extends StatelessWidget {
  const EmployeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Employee Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
