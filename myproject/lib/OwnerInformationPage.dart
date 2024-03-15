import 'package:flutter/material.dart';

class OwnerInformationPage extends StatelessWidget {
  final List<bool> parkingSlots;
  final List<String?> owners;
  final List<DateTime?> parkedTimes;
  final List<int> charges;

  const OwnerInformationPage({super.key, 
    required this.parkingSlots,
    required this.owners,
    required this.parkedTimes,
    required this.charges,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Information Page',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 2, 34, 65), // Customizing app bar color
        iconTheme: const IconThemeData(color: Colors.white), // Set arrow color to white
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui4.png'), // Add background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Detailed Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20, // Add spacing between columns
                    headingRowHeight: 50, // Increase heading row height
                    dataRowHeight: 60, // Increase data row height
                    dividerThickness: 2, // Add divider thickness
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Add border
                      borderRadius: BorderRadius.circular(10), // Add border radius
                    ),
                    columns: const [
                      DataColumn(
                        label: Text('Slot Number'),
                      ),
                      DataColumn(
                        label: Text('Owner Name'),
                      ),
                      DataColumn(
                        label: Text('Parked Time'),
                      ),
                      DataColumn(
                        label: Text('Charge'),
                      ),
                    ],
                    rows: List.generate(parkingSlots.length, (index) {
                      final slotNumber = index + 1;
                      final owner = owners[index];
                      final parkedTime = parkedTimes[index];
                      final charge = charges[index];

                      return DataRow(
                        color: MaterialStateColor.resolveWith((states) => index.isEven ? Colors.grey.shade100 : Colors.white), // Alternate row colors
                        cells: [
                          DataCell(
                            Center(child: Text(slotNumber.toString())),
                          ),
                          DataCell(
                            Center(child: Text(owner ?? '')),
                          ),
                          DataCell(
                            Center(child: Text(parkedTime != null ? parkedTime.toString() : '')),
                          ),
                          DataCell(
                            Center(child: Text(charge.toString())),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
