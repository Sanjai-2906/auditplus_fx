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
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
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
                              backgroundColor: checkedBox.isM2LongAllChecked(symbol) ? Colors.lightGreen : Colors.grey,
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
                          ElevatedButton(
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
                        ],
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          'Divergence',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '(OR)',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Reversal Plus',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          'Catcher',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          'MF',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '(OR)',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          'HW',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '(OR)',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: Text(
                          'HWTH',
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
                          _buildCheckboxRow('long', 'LongDivergenceChecked', checkedBox, value),
                          _buildCheckboxRow('long', 'LongRevPlusChecked', checkedBox, value),
                          _buildCheckboxRow('long', 'LongCatcherChecked', checkedBox, value),
                          _buildCheckboxRow('long', 'LongM2MfChecked', checkedBox, value),
                          _buildCheckboxRow('long', 'LongM2HwChecked', checkedBox, value),
                          _buildCheckboxRow('long', 'LongM2HwThChecked', checkedBox, value),
                        ],
                      );
                    },
                  ),
                  Consumer2<ValueProvider, CheckedBoxProvider>(
                    builder: (context, value, checkedBox, child) {
                      if (checkedBox.isLoading || value.manualSelectedValue == null) {
                        return Column(children: List.generate(7, (_) => _placeHolderCheckboxRow('short')));
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildCheckboxRow('short', 'ShortDivergenceChecked', checkedBox, value),
                          _buildCheckboxRow('short', 'ShortRevChecked', checkedBox, value),
                          _buildCheckboxRow('short', 'ShortCatcherChecked', checkedBox, value),
                          _buildCheckboxRow('short', 'ShortM2MfChecked', checkedBox, value),
                          _buildCheckboxRow('short', 'ShortM2HwChecked', checkedBox, value),
                          _buildCheckboxRow('short', 'ShortM2HwThChecked', checkedBox, value),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          AutomaticClosingSection(method: 'MM2'),
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
                  checkedBox.changeValue(value.manualSelectedValue!, 'MM2', checkboxField, context);
                }
              : null,
          activeColor: method == 'long' ? Colors.green : Colors.red,
          checkColor: Colors.white,
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
