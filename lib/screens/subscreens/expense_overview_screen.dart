import 'package:farm_track/screens/internal/centering_plates_form.dart';
import 'package:farm_track/screens/internal/jcb_work_screen.dart';
import 'package:farm_track/screens/internal/tractor_work_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseOverviewScreen(),
    );
  }
}

class ExpenseOverviewScreen extends StatefulWidget {
  @override
  _ExpenseOverviewScreenState createState() => _ExpenseOverviewScreenState();
}

class _ExpenseOverviewScreenState extends State<ExpenseOverviewScreen> {
  // Sample data
  double fuelConsumption = 30;
  double totalExpenses = 50;
  double totalIncome = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Monthly Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Additional UI Component
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Fuel Consumption: $fuelConsumption%',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Total Expenses: $totalExpenses%',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Total Income: $totalIncome%',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Pie Chart
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: PieChart(
                        PieChartData(
                          sections: showingSections(),
                          centerSpaceRadius: 40,
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Legend
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLegendRow(Colors.blue, 'Fuel Consumption'),
                      buildLegendRow(Colors.red, 'Total Expenses'),
                      buildLegendRow(Colors.green, 'Total Income'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Floating Action Buttons at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      // Action for Plates
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CenteringPlatesScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset('assets/images/plates.png'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      //action for tractors
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TractorWorkScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset('assets/images/tractor.png'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Action for JCB
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JcbWorkScreen(),
                        ),
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset('assets/images/jcb.png')),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Function to create pie chart sections
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: fuelConsumption,
        title: '${fuelConsumption.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalExpenses,
        title: '${totalExpenses.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: totalIncome,
        title: '${totalIncome.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  // Function to build the legend
  Widget buildLegendRow(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
