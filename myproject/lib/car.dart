import 'package:flutter/material.dart';
import 'UserParkedPage.dart'; // Importing the UserParkedPage.dart file

class CarParkingUI extends StatefulWidget {
  @override
  _CarParkingUIState createState() => _CarParkingUIState();
}

class _CarParkingUIState extends State<CarParkingUI> {
  int numSlots = 5; // Number of parking slots
  List<bool> parkingSlots =
      List.generate(5, (index) => false); // Initialize slots as empty
  List<String?> owners = List.filled(5, null); // Initialize owners list with null

  int? selectedSlot; // To store the selected slot

  DateTime? parkedTime; // To store the time when the car is parked

  void toggleParking(int slot) {
    // Prompt for owner's name
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String ownerName = '';
        return AlertDialog(
          title: Text("Enter Owner's Name"),
          content: TextField(
            onChanged: (value) {
              ownerName = value;
            },
            decoration: InputDecoration(hintText: "Owner's Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                if (ownerName.isNotEmpty) {
                  setState(() {
                    owners[slot] = ownerName;
                    parkingSlots[slot] = true; // Mark slot as occupied
                    parkedTime = DateTime.now(); // Record parked time
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void parkCar() {
    if (selectedSlot != null) {
      if (!parkingSlots[selectedSlot! - 1]) {
        toggleParking(selectedSlot! - 1);
        setState(() {
          selectedSlot = null; // Clear selected slot after parking
        });
      } else {
        // Show a message if the slot is already occupied
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Slot Not Available"),
              content: Text("The selected slot is already occupied. Please choose another slot."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Show a message if no slot is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Parking Slot"),
            content: Text("Please select a parking slot first."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void unparkCar(int slot) {
    if (parkingSlots[slot]) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          int minutesParked = DateTime.now().difference(parkedTime!).inMinutes;
          int charge = minutesParked; // Charge per minute is 1 rupee
          return AlertDialog(
            title: Text("Confirm"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Do you want to unpark the car from Slot ${slot + 1}?"),
                SizedBox(height: 10),
                Text("Parking Duration: $minutesParked minutes"),
                Text("Charge: $charge rupees"),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Unpark"),
                onPressed: () {
                  setState(() {
                    parkingSlots[slot] = false; // Mark slot as empty
                    owners[slot] = null; // Clear owner's name
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      // Show a message if the slot is not occupied
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Slot Not Occupied"),
            content: Text("The selected slot is not occupied."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToUserParkedPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserParkedPage()), // Navigate to UserParkedPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700, // Set app bar color to pleasant elegant blue
        title: Text(
          'Car Parking System',
          // Removed style property to make text color black
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.directions_car),
            onPressed: navigateToUserParkedPage, // Navigate to UserParkedPage when car icon is pressed
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/ui2.png', // Background image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: numSlots,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToUserParkedPage(); // Navigate to UserParkedPage when slot image is tapped
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  color: parkingSlots[index] ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    parkingSlots[index] ? 'assets/car_parked.png' : 'assets/car_empty.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              parkingSlots[index]
                                  ? 'Slot ${index + 1} (Occupied by ${owners[index]})'
                                  : 'Slot ${index + 1} (Empty)',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20),
                            if (parkingSlots[index])
                              ElevatedButton(
                                onPressed: () {
                                  unparkCar(index);
                                },
                                child: Text('Unpark'),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Select Parking Slot"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(numSlots, (index) {
                                final slot = index + 1;
                                return ListTile(
                                  title: Text("Slot $slot"),
                                  onTap: () {
                                    setState(() {
                                      selectedSlot = slot;
                                    });
                                    Navigator.of(context).pop();
                                    parkCar(); // Automatically park the car after selecting the slot
                                  },
                                  tileColor: selectedSlot == slot ? Color.fromARGB(255, 6, 125, 223) : null,
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Park'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Car Parking App',
    home: CarParkingUI(),
  ));
}