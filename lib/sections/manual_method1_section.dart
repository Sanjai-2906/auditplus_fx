import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:auditplus_fx/Providers/providers.dart';
import 'package:auditplus_fx/intent.dart';
import 'package:auditplus_fx/sections/automatic_closing_section.dart';

class ManualMethod1Section extends StatefulWidget {
  const ManualMethod1Section({super.key});

  @override
  State<ManualMethod1Section> createState() => _ManualMethod1SectionState();
}

class _ManualMethod1SectionState extends State<ManualMethod1Section> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Consumer3<MytokenProvider, CheckedBoxProvider, ValueProvider>(
                builder: (context, myToken, checkedBox, value, child) {
                  final symbol = value.manualSelectedValue;
                  if (symbol == null || checkedBox.mmValuesPerSymbol[symbol] == null) {
                    // return const Center(child: CircularProgressIndicator());
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        ElevatedButton(
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
                        ElevatedButton(
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
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      ElevatedButton(
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
                          backgroundColor: checkedBox.isM1LongAllChecked(symbol) ? Colors.lightGreen : Colors.grey,
                          textStyle: TextStyle(inherit: true, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: checkedBox.isM1LongAllChecked(symbol)
                            ? () {
                                final token = Provider.of<MytokenProvider>(context, listen: false).token;
                                if (token != null) {
                                  Actions.invoke(
                                    context,
                                    const LongIntent(method: 'MM1', actionType: "ORDER_TYPE_BUY"),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 40),
                          maximumSize: Size(100, 50),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: checkedBox.isM1ShortAllChecked(symbol) ? Colors.red : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          elevation: 8.0,
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: checkedBox.isM1ShortAllChecked(symbol)
                            ? () {
                                final token = Provider.of<MytokenProvider>(context, listen: false).token;
                                if (token != null) {
                                  Actions.invoke(
                                    context,
                                    const ShortIntent(method: 'MM1', actionType: "ORDER_TYPE_SELL"),
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
                    ],
                  );
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'Catcher',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'Tracer',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'NEO Cloud',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'Confirmation',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'MF',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'TREND',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Text(
                      'REVERSAL',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Consumer2<ValueProvider, CheckedBoxProvider>(
                builder: (context, value, checkedBox, child) {
                  if (checkedBox.isLoading || value.manualSelectedValue == null) {
                    // return const Center(child: CircularProgressIndicator());
                    return Column(children: List.generate(7, (_) => _placeHolderCheckboxRow('long')));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCheckboxRow('long', 'LongTcChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongTtChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongNeoChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongConfChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongM1MfChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongM1TrendChecked', checkedBox, value),
                      _buildCheckboxRow('long', 'LongM1ReversalChecked', checkedBox, value),
                    ],
                  );
                },
              ),
              Consumer2<ValueProvider, CheckedBoxProvider>(
                builder: (context, value, checkedBox, child) {
                  if (checkedBox.isLoading || value.manualSelectedValue == null) {
                    // return const Center(child: CircularProgressIndicator());
                    return Column(children: List.generate(7, (_) => _placeHolderCheckboxRow('short')));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCheckboxRow('short', 'ShortTcChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortTtChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortNeoChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortConfChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortM1MfChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortM1TrendChecked', checkedBox, value),
                      _buildCheckboxRow('short', 'ShortM1ReversalChecked', checkedBox, value),
                    ],
                  );
                },
              ),
            ],
          ),
          AutomaticClosingSection(method: 'MM1'),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(String method, String checkboxField, CheckedBoxProvider checkedBox, ValueProvider value) {
    final symbol = value.manualSelectedValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (method == 'long')
          Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 18)
        else
          Icon(Icons.arrow_downward_rounded, color: Colors.red, size: 18),
        Checkbox(
          value: symbol != null ? checkedBox.getValue(symbol, "MM", checkboxField) : false,
          onChanged: symbol != null
              ? (bool? newValue) {
                  checkedBox.changeValue(value.manualSelectedValue!, 'MM1', checkboxField, context);
                }
              : null,
          activeColor: method == 'long' ? Colors.green : Colors.red,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Widget _placeHolderCheckboxRow(String method) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (method == 'long')
          Icon(Icons.arrow_upward_rounded, color: Colors.green, size: 18)
        else
          Icon(Icons.arrow_downward_rounded, color: Colors.red, size: 18),
        Checkbox(value: false, onChanged: (bool? newValue) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ],
    );
  }
}
