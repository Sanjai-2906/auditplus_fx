// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auditplus_fx/models/models.dart';
import 'package:flutter/material.dart';
import '../api_methods/api_methods.dart';

Future timeDialog(BuildContext context, LiveAutomaticTradeModel item, String method) {
  TimeOfDay? startTime = item.startTime;
  TimeOfDay? endTime = item.endTime;
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(189, 232, 245, 1),
            title: Text("Exceptional Range"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Time: ", style: TextStyle(fontSize: 14)),
                        Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          startTime != null
                              ? "${startTime!.hour.toString().padLeft(2, '0')}:"
                                    "${startTime!.minute.toString().padLeft(2, '0')}"
                              : item.startTime == null
                              ? "No Time"
                              : "${item.startTime!.hour.toString().padLeft(2, '0')}:"
                                    "${item.startTime!.minute.toString().padLeft(2, '0')}",
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(45, 10),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        final picked = await pickTime(context, startTime);
                        if (picked != null) {
                          setStateDialog(() {
                            startTime = picked;
                          });
                        }
                      },
                      child: Icon(Icons.punch_clock_outlined, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text("End Time: ", style: TextStyle(fontSize: 14)),
                        Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          endTime != null
                              ? "${endTime!.hour.toString().padLeft(2, '0')}:"
                                    "${endTime!.minute.toString().padLeft(2, '0')}"
                              : item.endTime == null
                              ? "No Time"
                              : "${item.endTime!.hour.toString().padLeft(2, '0')}:"
                                    "${item.endTime!.minute.toString().padLeft(2, '0')}",
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(45, 15),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        final picked = await pickTime(context, endTime);
                        if (picked != null) {
                          setStateDialog(() {
                            endTime = picked;
                          });
                        }
                      },
                      child: Icon(Icons.punch_clock_outlined, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onPressed: () async {
                  if (startTime == null || endTime == null) {
                    return;
                  }
                  final data = CurrentAutomationModel(
                    symbol: item.symbol,
                    volume: item.volume,
                    isEnabled: true,
                    action: ActionType.add,
                    method: method,
                    startTime: startTime,
                    endTime: endTime,
                  );
                  await automaticTrading(context, data);
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay? time) async {
  return await showTimePicker(
    context: context,
    initialTime: time ?? TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
    },
  );
}
