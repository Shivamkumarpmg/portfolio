import 'package:flutter/material.dart';

class EmpDashboard extends StatefulWidget {
  const EmpDashboard({super.key});

  @override
  State<EmpDashboard> createState() => _EmpDashboardState();
}

class _EmpDashboardState extends State<EmpDashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Employee Dashboard", style: TextStyle(
            color: Colors.black
          ),),
        ],
      ),
    );
  }
}
