import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:auditplus_fx/Providers/providers.dart';
import 'package:auditplus_fx/intent.dart';
import 'package:auditplus_fx/sections/automatic_closing_section.dart';

class ManualMethod2Section extends StatefulWidget {
  const ManualMethod2Section({super.key});

  @override
  State<ManualMethod2Section> createState() => _ManualMethod2SectionState();
}

class _ManualMethod2SectionState extends State<ManualMethod2Section> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 120),
                  Expanded(
                    child: Consumer3<MytokenProvider, CheckedBoxProvider, ValueProvider>(
                      builder: (context, myToken, checkedBox, value, child) {
                        final symbol = value.manualSelectedValue;
                        if (symbol == null || checkedBox.mmValuesPerSymbol[symbol] == null) {
                          // return const Center(child: CircularProgressIndicator());
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 40),
                                    maximumSize: Size(100, 50),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black, width: 2),
                                    ),
                                    elevation: 8.0,
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color.fromARGB(255, 199, 199, 199),
                                    textStyle: TextStyle(inherit: true, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  child: Text('Long'),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 40),
                                    maximumSize: Size(100, 50),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: const Color.fromARGB(255, 199, 199, 199),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black, width: 2),
                                    ),
                                    elevation: 8.0,
                                    foregroundColor: Colors.black,
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  child: Text('Short'),
                                ),
                              ),
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: 5,
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 40),
                                  maximumSize: Size(100, 50),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  elevation: 8.0,
                                  foregroundColor: Colors.black,
                                  backgroundColor: checkedBox.isM2LongAllChecked(symbol)
                                      ? Colors.lightGreen
                                      : Colors.grey,
                                  textStyle: TextStyle(inherit: true, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                onPressed: checkedBox.isM2LongAllChecked(symbol)
                                    ? () {
                                        final token = Provider.of<MytokenProvider>(context, listen: false).token;
                                        if (token != null) {
                                          Actions.invoke(
                                            context,
                                            const LongIntent(method: 'MM2', actionType: "ORDER_TYPE_BUY"),
                                          );
                                        } else {
                                          toastification.show(
                                            backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                            context: context,
                                            title: const Text('Error!'),
                                            description: const Text('Your token is empty'),
                                            type: ToastificationType.error,
                                            alignment: Alignment.center,
                                            autoCloseDuration: const Duration(seconds: 2),
                                          );
                                        }
                                      }
                                    : null,
                                child: Text('Long'),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 40),
                                  maximumSize: Size(100, 50),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: checkedBox.isM2ShortAllChecked(symbol) ? Colors.red : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  elevation: 8.0,
                                  foregroundColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                onPressed: checkedBox.isM2ShortAllChecked(symbol)
                                    ? () {
                                        final token = Provider.of<MytokenProvider>(context, listen: false).token;
                                        if (token != null) {
                                          Actions.invoke(
                                            context,
                                            const ShortIntent(method: 'MM2', actionType: "ORDER_TYPE_SELL"),
                                          );
                                        } else {
                                          toastification.show(
                                            backgroundColor: Color.fromRGBO(242, 186, 185, 1),
                                            context: context,
                                            title: const Text('Error!'),
                                            description: const Text('Your token is empty'),
                                            type: ToastificationType.error,
                                            alignment: Alignment.center,
                                            autoCloseDuration: const Duration(seconds: 2),
                                          );
                                        }
                                      }
                                    : null,
                                child: Text('Short'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildRow("Divergence", "LongDivergenceChecked", "ShortDivergenceChecked"),
              _buildRow("Reversal Plus", "LongRevPlusChecked", "ShortRevChecked"),
              _buildRow("Catcher", "LongCatcherChecked", "ShortCatcherChecked"),
              _buildRow("MF", "LongM2MfChecked", "ShortM2MfChecked"),
              _buildRow("HW", "LongM2HwChecked", "ShortM2HwChecked"),
              _buildRow("HWTH", "LongM2HwThChecked", "ShortM2HwThChecked"),
            ],
          ),
          AutomaticClosingSection(method: 'MM2'),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String longField, String shortField) {
    return Consumer2<ValueProvider, CheckedBoxProvider>(
      builder: (context, value, checkedBox, child) {
        final symbol = value.manualSelectedValue;

        if (symbol == null || checkedBox.isLoading) {
          return _rowPlaceholder(title);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 18),
                    Checkbox(
                      value: checkedBox.getValue(symbol, "MM", longField),
                      onChanged: (_) {
                        checkedBox.changeValue(symbol, 'MM2', longField, context);
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward_rounded, color: Colors.red, size: 18),
                    Checkbox(
                      value: checkedBox.getValue(symbol, "MM", shortField),
                      onChanged: (_) {
                        checkedBox.changeValue(symbol, 'MM2', shortField, context);
                      },
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _rowPlaceholder(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 18),
                Checkbox(value: false, onChanged: null),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_downward_rounded, color: Colors.red, size: 18),
                Checkbox(value: false, onChanged: null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
