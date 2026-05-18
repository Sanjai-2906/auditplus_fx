import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../sections/sections.dart';

class MethodDialog extends StatefulWidget {
  final String method;
  const MethodDialog({required this.method, super.key});

  @override
  State<MethodDialog> createState() => _MethodDialogState();
}

class _MethodDialogState extends State<MethodDialog> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("method in method dialog: ${widget.method}");
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        width: MediaQuery.of(context).size.width * 0.95,
        // height: MediaQuery.of(context).size.height * 0.8,
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
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        if ((widget.method == "M1" && val.isM1Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM1LongAllChecked,
                            shortAllChecked: check.isM1ShortAllChecked,
                            isMethodChecked: val.isM1Checked,
                            methodId: "MM1",
                            title: "Method 1",
                          ),
                        if ((widget.method == "M2" && val.isM2Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM2LongAllChecked,
                            shortAllChecked: check.isM2ShortAllChecked,
                            isMethodChecked: val.isM2Checked,
                            methodId: "MM2",
                            title: "Method 2",
                          ),
                        if ((widget.method == "M3" && val.isM3Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM3LongAllChecked,
                            shortAllChecked: check.isM3ShortAllChecked,
                            isMethodChecked: val.isM3Checked,
                            methodId: "MM3",
                            title: "Method 3",
                          ),
                        if ((widget.method == "M4" && val.isM4Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM4LongAllChecked,
                            shortAllChecked: check.isM4ShortAllChecked,
                            isMethodChecked: val.isM4Checked,
                            methodId: "MM4",
                            title: "Method 4",
                          ),
                        if ((widget.method == "M5" && val.isM5Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM5LongAllChecked,
                            shortAllChecked: check.isM5ShortAllChecked,
                            isMethodChecked: val.isM5Checked,
                            methodId: "MM5",
                            title: "Method 5",
                          ),
                        if ((widget.method == "M6" && val.isM6Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM6LongAllChecked,
                            shortAllChecked: check.isM6ShortAllChecked,
                            isMethodChecked: val.isM6Checked,
                            methodId: "MM6",
                            title: "Method 6",
                          ),
                        if ((widget.method == "M7" && val.isM7Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM7LongAllChecked,
                            shortAllChecked: check.isM7ShortAllChecked,
                            isMethodChecked: val.isM7Checked,
                            methodId: "MM7",
                            title: "Method 7",
                          ),
                        if ((widget.method == "M8" && val.isM8Checked) || widget.method == "ALL")
                          _buildMethodContainer(
                            context: context,
                            symbol: symbol,
                            longAllChecked: check.isM8LongAllChecked,
                            shortAllChecked: check.isM8ShortAllChecked,
                            isMethodChecked: val.isM8Checked,
                            methodId: "MM8",
                            title: "Method 8",
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
}

Widget _buildMethodContainer({
  required BuildContext context,
  required String symbol,
  required bool Function(String) longAllChecked,
  required bool Function(String) shortAllChecked,
  required bool isMethodChecked,
  required String methodId,
  required String title,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: title,
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
              backgroundColor: longAllChecked(symbol) && isMethodChecked
                  ? Colors.lightGreen
                  : Color.fromARGB(255, 199, 199, 199),
              minimumSize: Size(55, 40),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: longAllChecked(symbol) && isMethodChecked
                ? () {
                    if (symbol != "") {
                      openPosition(methodId, 'ORDER_TYPE_BUY', null, context);
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
              backgroundColor: shortAllChecked(symbol) && isMethodChecked
                  ? Colors.red
                  : Color.fromARGB(255, 199, 199, 199),
              minimumSize: Size(55, 40),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: shortAllChecked(symbol) && isMethodChecked
                ? () {
                    if (symbol != "") {
                      openPosition(methodId, 'ORDER_TYPE_SELL', null, context);
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
                onClosePosition(context, "POSITION_CLOSE_ID", methodId);
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
                      child: AutomaticClosingSection(method: methodId),
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
  );
}
