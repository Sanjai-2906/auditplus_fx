import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/providers.dart';

class ManualMethodSection extends StatefulWidget {
  const ManualMethodSection({super.key});

  @override
  State<ManualMethodSection> createState() => _ManualMethodSectionState();
}

class _ManualMethodSectionState extends State<ManualMethodSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5, top: 10),
      child: Consumer<ValueProvider>(
        builder: (context, val, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRow("Catcher", "LongTcChecked", "ShortTcChecked"),
                  if (!(val.isM4Checked || val.isM5Checked)) _buildRow("Tracer", "LongTtChecked", "ShortTtChecked"),
                  if (val.isM1Checked || val.isM2Checked || val.isM3Checked)
                    _buildRow("Neo Cloud", "LongNeoChecked", "ShortNeoChecked"),
                  if (val.isM3Checked || val.isM8Checked)
                    _buildRow("Signal Exit", "LongSignalExitChecked", "ShortSignalExitChecked"),
                  if (val.isM1Checked || val.isM2Checked) _buildRow("MF", "LongMfChecked", "ShortMfChecked"),
                  // _buildRow("HW", "LongHwChecked", "ShortHwChecked"),
                  if (val.isM1Checked || val.isM4Checked || val.isM5Checked)
                    _buildRow("Signal", "LongSignalChecked", "ShortSignalChecked"),
                  if (val.isM2Checked || val.isM6Checked || val.isM7Checked || val.isM8Checked)
                    _buildRow("Reversal", "LongReversalChecked", "ShortReversalChecked"),
                  if (val.isM2Checked || val.isM6Checked || val.isM7Checked || val.isM8Checked)
                    _buildRow("Reversal Plus", "LongReversalPlusChecked", "ShortReversalPlusChecked"),
                  if (val.isM5Checked) _buildRow("Divergence", "LongDivergenceChecked", "ShortDivergenceChecked"),
                  if (val.isM1Checked) _buildRow("Tc Cross Tt", "LongTcCrossTtChecked", "ShortTcCrossTtChecked"),
                ],
              ),
            ],
          );
        },
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
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                      onChanged: (_) async {
                        await checkedBox.changeValue(symbol, 'MM', longField, context);
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
                      onChanged: (_) async {
                        await checkedBox.changeValue(symbol, 'MM', shortField, context);
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
