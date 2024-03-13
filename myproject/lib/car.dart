import 'package:flutter/material.dart';
import 'UserParkedPage.dart';
import 'OwnerInformationPage.dart';

class CarParkingUI extends StatefulWidget {
  @override
  _CarParkingUIState createState() => _CarParkingUIState();
}

class _CarParkingUIState extends State<CarParkingUI> {
  int numSlots = 5;
  List<bool> parkingSlots = List.generate(5, (index) => false);
  List<String?> owners = List.filled(5, null);

  int? selectedSlot;
  DateTime? parkedTime;

  void toggleParking(int slot) {
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
                    parkingSlots[slot] = true;
                    parkedTime = DateTime.now();
                  });
                  Navigator.of(context).pop();
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
          selectedSlot = null;
        });
      } else {
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
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
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
                  Navigator.of(context).pop();
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
          int charge = minutesParked;
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
                    parkingSlots[slot] = false;
                    owners[slot] = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToUserParkedPage() {
    if (parkingSlots.contains(true)) {
      int slot = parkingSlots.indexOf(true) + 1;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserParkedPage(slotNumber: slot, parkedTime: parkedTime!, charge: DateTime.now().difference(parkedTime!).inMinutes)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No Car Parked"),
            content: Text("No car is currently parked. Please park a car first."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToOwnerInformationPage() {
    if (parkingSlots.contains(true)) {
      int slot = parkingSlots.indexOf(true) + 1;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OwnerInformationPage(
            parkingSlots: parkingSlots,
            owners: owners,
            parkedTimes: List.generate(numSlots, (index) {
              return parkingSlots[index] ? parkedTime : null;
            }),
            charges: List.generate(numSlots, (index) {
              return parkingSlots[index]
                  ? DateTime.now().difference(parkedTime!).inMinutes
                  : 0;
            }),
          ),
        ),
      );
    } else {
      // Navigate to OwnerInformationPage with empty data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OwnerInformationPage(
            parkingSlots: List.filled(numSlots, false),
            owners: List.filled(numSlots, null),
            parkedTimes: List.filled(numSlots, null),
            charges: List.filled(numSlots, 0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 27, 50),
        title: Text(
          'Car Parking System',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.directions_car),
            color: Colors.white, // Set icon color to white
            onPressed: navigateToUserParkedPage,
          ),
          IconButton(
            icon: Icon(Icons.info),
            color: Colors.white, // Set icon color to white
            onPressed: navigateToOwnerInformationPage,
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/ui4.png',
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
                                if (!parkingSlots[index]) {
                                  setState(() {
                                    selectedSlot = index + 1;
                                  });
                                }
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  color: parkingSlots[index] ? Colors.green : (selectedSlot == index + 1 ? Colors.blue : Colors.red),
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
                                    parkCar();
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
