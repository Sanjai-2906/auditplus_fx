import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import 'sections.dart';

Widget methodDialog(BuildContext context) {
  return Dialog(
    insetPadding: EdgeInsets.zero,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Color.fromRGBO(189, 232, 245, 1), borderRadius: BorderRadius.circular(12)),
      child: Consumer2<CheckedBoxProvider, ValueProvider>(
        builder: (context, check, val, child) {
          final symbol = val.manualSelectedValue ?? "";
          return Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.red, size: 25),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Method 1',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM1LongAllChecked(symbol) && val.isM1Checked
                              ? Colors.lightGreen
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM1LongAllChecked(symbol) && val.isM1Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM1", 'ORDER_TYPE_BUY', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Long', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM1ShortAllChecked(symbol) && val.isM1Checked
                              ? Colors.red
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM1ShortAllChecked(symbol) && val.isM1Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM1", 'ORDER_TYPE_SELL', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Short', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (symbol != "") {
                            onClosePosition(context, "POSITION_CLOSE_ID", "MM1");
                          } else {
                            toastification.show(
                              backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                              context: context,
                              title: const Text('Symbol!'),
                              description: const Text('Select a Symbol'),
                              type: ToastificationType.info,
                              alignment: Alignment.center,
                              autoCloseDuration: const Duration(seconds: 1),
                            );
                          }
                        },
                        child: Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Consumer<ValueProvider>(
                        builder: (context, vol, child) {
                          return SizedBox(
                            width: 65,
                            child: TextFormField(
                              controller: vol.manualVolumeController,
                              onChanged: (newValue) {
                                final parsedValue = double.tryParse(newValue);
                                if (parsedValue != null) {
                                  vol.setManualVolume(parsedValue);
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(252, 255, 255, 255),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                                ),
                              ),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(189, 232, 245, 1),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: AutomaticClosingSection(method: "MM1"),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add_box, color: Colors.black, size: 40),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Method 2',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM2LongAllChecked(symbol) && val.isM2Checked
                              ? Colors.lightGreen
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM2LongAllChecked(symbol) && val.isM2Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM2", 'ORDER_TYPE_BUY', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Long', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM2ShortAllChecked(symbol) && val.isM2Checked
                              ? Colors.red
                              : Color.fromARGB(255, 199, 199, 199),

                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM2ShortAllChecked(symbol) && val.isM2Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM2", 'ORDER_TYPE_SELL', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Short', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (symbol != "") {
                            onClosePosition(context, "POSITION_CLOSE_ID", "MM2");
                          } else {
                            toastification.show(
                              backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                              context: context,
                              title: const Text('Symbol!'),
                              description: const Text('Select a Symbol'),
                              type: ToastificationType.info,
                              alignment: Alignment.center,
                              autoCloseDuration: const Duration(seconds: 1),
                            );
                          }
                        },
                        child: Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Consumer<ValueProvider>(
                        builder: (context, vol, child) {
                          return SizedBox(
                            width: 65,
                            child: TextFormField(
                              controller: vol.manualVolumeController,
                              onChanged: (newValue) {
                                final parsedValue = double.tryParse(newValue);
                                if (parsedValue != null) {
                                  vol.setManualVolume(parsedValue);
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(252, 255, 255, 255),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                                ),
                              ),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(189, 232, 245, 1),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: AutomaticClosingSection(method: "MM2"),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add_box, color: Colors.black, size: 40),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Method 3',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM3LongAllChecked(symbol) && val.isM3Checked
                              ? Colors.lightGreen
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM3LongAllChecked(symbol) && val.isM3Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM3", 'ORDER_TYPE_BUY', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Long', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM3ShortAllChecked(symbol) && val.isM3Checked
                              ? Colors.red
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM3ShortAllChecked(symbol) && val.isM3Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM3", 'ORDER_TYPE_SELL', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Short', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (symbol != "") {
                            onClosePosition(context, "POSITION_CLOSE_ID", "MM3");
                          } else {
                            toastification.show(
                              backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                              context: context,
                              title: const Text('Symbol!'),
                              description: const Text('Select a Symbol'),
                              type: ToastificationType.info,
                              alignment: Alignment.center,
                              autoCloseDuration: const Duration(seconds: 1),
                            );
                          }
                        },
                        child: Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Consumer<ValueProvider>(
                        builder: (context, vol, child) {
                          return SizedBox(
                            width: 65,
                            child: TextFormField(
                              controller: vol.manualVolumeController,
                              onChanged: (newValue) {
                                final parsedValue = double.tryParse(newValue);
                                if (parsedValue != null) {
                                  vol.setManualVolume(parsedValue);
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(252, 255, 255, 255),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                                ),
                              ),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(189, 232, 245, 1),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: AutomaticClosingSection(method: "MM3"),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add_box, color: Colors.black, size: 40),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Method 4',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM4LongAllChecked(symbol) && val.isM4Checked
                              ? Colors.lightGreen
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM4LongAllChecked(symbol) && val.isM4Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM4", 'ORDER_TYPE_BUY', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Long', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: check.isM4ShortAllChecked(symbol) && val.isM4Checked
                              ? Colors.red
                              : Color.fromARGB(255, 199, 199, 199),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: check.isM4ShortAllChecked(symbol) && val.isM4Checked
                            ? () {
                                if (symbol != "") {
                                  openPosition("MM4", 'ORDER_TYPE_SELL', null, context);
                                } else {
                                  toastification.show(
                                    backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                    context: context,
                                    title: const Text('Error!'),
                                    description: const Text('Select Symbol'),
                                    type: ToastificationType.error,
                                    alignment: Alignment.center,
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                }
                              }
                            : null,
                        child: Text('Short', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                          minimumSize: Size(55, 40),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (symbol != "") {
                            onClosePosition(context, "POSITION_CLOSE_ID", "MM4");
                          } else {
                            toastification.show(
                              backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                              context: context,
                              title: const Text('Symbol!'),
                              description: const Text('Select a Symbol'),
                              type: ToastificationType.info,
                              alignment: Alignment.center,
                              autoCloseDuration: const Duration(seconds: 1),
                            );
                          }
                        },
                        child: Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Consumer<ValueProvider>(
                        builder: (context, vol, child) {
                          return SizedBox(
                            width: 65,
                            child: TextFormField(
                              controller: vol.manualVolumeController,
                              onChanged: (newValue) {
                                final parsedValue = double.tryParse(newValue);
                                if (parsedValue != null) {
                                  vol.setManualVolume(parsedValue);
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(252, 255, 255, 255),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                                ),
                              ),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(189, 232, 245, 1),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: AutomaticClosingSection(method: "MM4"),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add_box, color: Colors.black, size: 40),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
