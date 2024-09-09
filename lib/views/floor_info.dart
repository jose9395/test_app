import 'package:flutter/material.dart';
import 'package:test_app/model/lead_model.dart';
import 'package:test_app/views/view_details_page.dart';

Widget buildFloorInfoTab({required Estimate lead}) {
  String oldInfo = lead.oldHouseAdditionalInfo;
  if (oldInfo.isEmpty) {
    oldInfo = "Nil";
  }
  String newInfo = lead.newHouseAdditionalInfo;
  if (newInfo.isEmpty) {
    newInfo = "Nil";
  }

  return Flexible(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            color: const Color.fromARGB(255, 221, 216, 216),
            padding: EdgeInsets.all(8).copyWith(left: 18),
            child: const Text(
              'Existing House Details',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailRow(label: 'Floor No.', value: lead.oldFloorNo),
                const SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Elevator Available',
                    value: lead.oldElevatorAvailability),
                const SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Packing Required', value: lead.packingService),
                const SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Distance from Door to Truck',
                    value: lead.oldParkingDistance),
                SizedBox(
                  height: 10,
                ),
                const Text('Additional Information',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  oldInfo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: const Color.fromARGB(255, 221, 216, 216),
            padding: EdgeInsets.all(8).copyWith(left: 18),
            child: const Text(
              'New House Details',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailRow(label: 'Floor No.', value: lead.newFloorNo),
                SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Elevator Available',
                    value: lead.newElevatorAvailability),
                SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Unpacking Required', value: lead.packingService),
                SizedBox(
                  height: 10,
                ),
                DetailRow(
                    label: 'Distance from Door to Truck',
                    value: lead.newParkingDistance),
                SizedBox(
                  height: 10,
                ),
                Text('Additional Information',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(newInfo,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
