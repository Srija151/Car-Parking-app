import 'package:flutter/material.dart';
import 'dart:async'; // Add this import statement

class UserParkedPage extends StatefulWidget {
  final int? parkedSlot;
  final String? ownerName; // Added ownerName parameter

  UserParkedPage({this.parkedSlot, this.ownerName}); // Modified constructor

  @override
  _UserParkedPageState createState() => _UserParkedPageState();
}

class _UserParkedPageState extends State<UserParkedPage> {
  late Timer _timer;
  int _elapsedTime = 0;
  double _charge = 0.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _elapsedTime++;
        _calculateCharge();
      });
    });
  }

  void _calculateCharge() {
    // Assuming charge is 1 rupee per minute
    _charge = _elapsedTime * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text(
          'User Parked Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.parkedSlot != null && widget.ownerName != null) // Check if slot is booked
                Column(
                  children: [
                    Text(
                      'Parked Slot: ${widget.parkedSlot}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Owner Name: ${widget.ownerName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Elapsed Time: $_elapsedTime minutes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Charge: $_charge rupees',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              else // If slot is not booked
                Text(
                  'No slot is booked',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
