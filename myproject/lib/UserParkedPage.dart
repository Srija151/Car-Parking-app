import 'package:flutter/material.dart';

class UserParkedPage extends StatelessWidget {
  final int slotNumber;
  final DateTime parkedTime;
  final int charge;

  UserParkedPage({
    required this.slotNumber,
    required this.parkedTime,
    required this.charge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Parked Page',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 2, 28, 54), // Customizing app bar color
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui4.png'), // Add background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Slot Number: $slotNumber',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 8, 5, 5), // Text color
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Parked Time: ${parkedTime.toString()}',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 9, 2, 2), // Text color
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Charge: $charge',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 17, 7, 7), // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
