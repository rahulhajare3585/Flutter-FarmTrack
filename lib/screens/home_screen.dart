import 'package:farm_track/screens/Authentications/login_screen.dart';
import 'package:farm_track/screens/subscreens/fuel_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'subscreens/customer_list_screen.dart';
import 'subscreens/driver_details_screen.dart';
import 'subscreens/profile_screen.dart';
import 'subscreens/expense_overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // Start with the Home tab selected (center)

  // List of all the tabs/screens
  static const List<Widget> _tabs = <Widget>[
    FuelTab(),
    CustomerTab(),
    HomeTab(), // Home tab is now in the center
    EmployeeTab(),
    ProfileTab(),
  ];

  // Update the selected index when tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to log out by clearing preferences and navigating to login screen
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored preferences (logout)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: 'Fuel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Driver/Operator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 14, 44, 6),
        selectedFontSize: 16,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpenseOverviewScreen();
  }
}

// Fuel Tab
class FuelTab extends StatelessWidget {
  const FuelTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FuelListScreen();
  }
}

// Customer Tab
class CustomerTab extends StatelessWidget {
  const CustomerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomerListScreen();
  }
}

// Employee Tab
class EmployeeTab extends StatelessWidget {
  const EmployeeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverDetailsScreen();
  }
}

// Profile Tab
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
