import 'package:flutter/material.dart';
// Importing the about_us.dart file
// Importing the main.dart file

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 1, 26, 50), // Change app bar color to a pleasant elegant blue
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white, // Set icon color to white
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate to the home page
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white, // Set icon color to white
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/about'); // Navigate to the About Us page
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.contact_phone,
              color: Colors.white, // Set icon color to white
            ), // Add icon for Contact Us page
            onPressed: () {}, // No action needed as we are already on the Contact Us page
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(), // Ensure the container takes up the entire screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui4.png'), // Add background image
            fit: BoxFit.cover, // Scale background image to cover the entire screen
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/contactus.png', // Add path to your contact image
                  height: 200, // Adjust image height as needed
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Set text color to black
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.black, // Set icon color to black
                    ),
                    SizedBox(width: 10),
                    Text(
                      'info@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.black), // Set text color to black
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.black, // Set icon color to black
                    ),
                    SizedBox(width: 10),
                    Text(
                      '+1-123-456-7890',
                      style: TextStyle(fontSize: 16, color: Colors.black), // Set text color to black
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black, // Set icon color to black
                    ),
                    SizedBox(width: 10),
                    Text(
                      '123 Main St, City, Country',
                      style: TextStyle(fontSize: 16, color: Colors.black), // Set text color to black
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
