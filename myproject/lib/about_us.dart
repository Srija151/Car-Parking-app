import 'package:flutter/material.dart';
import 'main.dart'; // Importing the main.dart file
import 'contact_us.dart'; // Importing the contact_us.dart file

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blue.shade700, // Change app bar color to a pleasant elegant blue
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate to the home page
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline), // Add icon for About Us page
            onPressed: () {}, // No action needed as we are already on the About Us page
          ),
          IconButton(
            icon: Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.pushNamed(context, '/contact'); // Navigate to the Contact Us page
            },
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(), // Ensure the container takes up the entire screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui2.png'),
            fit: BoxFit.cover, // Scale background image to cover the entire screen
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/aboutus.png'),
              ),
              SizedBox(height: 20),
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change text color to black
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to our car parking app! We provide convenient solutions for efficient parking management.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black), // Change text color to black
              ),
              SizedBox(height: 20),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change text color to black
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Our mission is to optimize urban mobility by providing smart and sustainable parking solutions that enhance convenience and reduce congestion.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black), // Change text color to black
              ),
            ],
          ),
        ),
      ),
    );
  }
}
