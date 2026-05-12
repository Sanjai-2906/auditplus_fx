// ignore_for_file: use_build_context_synchronously

import 'package:auditplus_fx/models/models.dart';
import 'package:flutter/material.dart';
import '../api_methods/api_methods.dart';

Future timeDialog(BuildContext context, LiveAutomaticTradeModel item, String method) {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(189, 232, 245, 1),
            title: Text("Trade Range"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        Text("Start Time: ", style: TextStyle(fontSize: 14)),
                        Text(
                          startTime != null
                              // ? startTime!.format(context)
                              ? format24(startTime!)
                              : item.startTime == null
                              ? "No Start Time"
                              // : TimeOfDay.fromDateTime(item.startTime!).format(context),
                              : format24(TimeOfDay.fromDateTime(item.startTime!)),
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
                        final picked = await _selectTime(context);

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
                    Row(
                      spacing: 5,
                      children: [
                        Text("End Time: ", style: TextStyle(fontSize: 14)),
                        Text(
                          endTime != null
                              // ? endTime!.format(context)
                              ? format24(endTime!)
                              : item.endTime == null
                              ? "No end Time"
                              // : TimeOfDay.fromDateTime(item.endTime!).format(context),
                              : format24(TimeOfDay.fromDateTime(item.endTime!)),
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
                        final picked = await _selectTime(context);

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
                  final existingStart = item.startTime;
                  final existingEnd = item.endTime;
                  DateTime? finalStart;
                  DateTime? finalEnd;
                  final now = DateTime.now();
                  if (startTime != null) {
                    finalStart = DateTime(now.year, now.month, now.day, startTime!.hour, startTime!.minute);
                  } else {
                    finalStart = existingStart;
                  }
                  if (endTime != null) {
                    finalEnd = DateTime(now.year, now.month, now.day, endTime!.hour, endTime!.minute);
                  } else {
                    finalEnd = existingEnd;
                  }
                  if (finalStart == null || finalEnd == null) {
                    return;
                  }
                  // overnight support
                  if (finalEnd.isBefore(finalStart)) {
                    finalEnd = finalEnd.add(Duration(days: 1));
                  }
                  final data = CurrentAutomationModel(
                    symbol: item.symbol,
                    volume: item.volume,
                    isEnabled: true,
                    action: ActionType.add,
                    method: method,
                    startTime: finalStart,
                    endTime: finalEnd,
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

// Future<TimeOfDay?> _selectTime(BuildContext context) async {
//   return await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//     builder: (BuildContext context, Widget? child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           timePickerTheme: TimePickerThemeData(
//             backgroundColor: const Color.fromARGB(255, 201, 237, 243),
//             dialBackgroundColor: Colors.white,
//             dialHandColor: Colors.black,
//             hourMinuteColor: Colors.white,
//             hourMinuteTextColor: Colors.black,
//             hourMinuteShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: const BorderSide(color: Colors.black, width: 2),
//             ),
//             dayPeriodColor: Colors.white,
//             dayPeriodTextColor: Colors.black,
//             dayPeriodShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: const BorderSide(color: Colors.black, width: 2),
//             ),
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );
// }
Future<TimeOfDay?> _selectTime(BuildContext context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: true, // <-- railway format
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color.fromARGB(255, 201, 237, 243),
              dialBackgroundColor: Colors.white,
              dialHandColor: Colors.black,
              hourMinuteColor: Colors.white,
              hourMinuteTextColor: Colors.black,
            ),
          ),
          child: child!,
        ),
      );
    },
  );
}

String format24(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}
