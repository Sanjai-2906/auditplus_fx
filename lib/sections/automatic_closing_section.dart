import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/providers.dart';

class AutomaticClosingSection extends StatefulWidget {
  final String method;
  final String? amSymbol;
  const AutomaticClosingSection({super.key, required this.method, this.amSymbol});

  @override
  State<AutomaticClosingSection> createState() => _AutomaticClosingSectionState();
}

class _AutomaticClosingSectionState extends State<AutomaticClosingSection> {
  String get reversalPlusPlus => {
    'MM1': 'MM1ReversalPlusPlusChecked',
    'MM2': 'MM2ReversalPlusPlusChecked',
    'MM3': 'MM3ReversalPlusPlusChecked',
    'MM4': 'MM4ReversalPlusPlusChecked',
    'AM1': 'AM1ReversalPlusPlusChecked',
    'AM2': 'AM2ReversalPlusPlusChecked',
    'AM3': 'AM3ReversalPlusPlusChecked',
    'AM4': 'AM4ReversalPlusPlusChecked',
  }[widget.method]!;

  String get reversalPlus => {
    'MM1': 'MM1ReversalPlusChecked',
    'MM2': 'MM2ReversalPlusChecked',
    'MM3': 'MM3ReversalPlusChecked',
    'MM4': 'MM4ReversalPlusChecked',
    'AM1': 'AM1ReversalPlusChecked',
    'AM2': 'AM2ReversalPlusChecked',
    'AM3': 'AM3ReversalPlusChecked',
    'AM4': 'AM4ReversalPlusChecked',
  }[widget.method]!;

  String get reversal => {
    'MM1': 'MM1ReversalChecked',
    'MM2': 'MM2ReversalChecked',
    'MM3': 'MM3ReversalChecked',
    'MM4': 'MM4ReversalChecked',
    'AM1': 'AM1ReversalChecked',
    'AM2': 'AM2ReversalChecked',
    'AM3': 'AM3ReversalChecked',
    'AM4': 'AM4ReversalChecked',
  }[widget.method]!;

  String get signal => {
    'MM1': 'MM1SignalExitChecked',
    'MM2': 'MM2SignalExitChecked',
    'MM3': 'MM3SignalExitChecked',
    'MM4': 'MM4SignalExitChecked',
    'AM1': 'AM1SignalExitChecked',
    'AM2': 'AM2SignalExitChecked',
    'AM3': 'AM3SignalExitChecked',
    'AM4': 'AM4SignalExitChecked',
  }[widget.method]!;

  String get tc => {
    'MM1': 'MM1TcChangeChecked',
    'MM2': 'MM2TcChangeChecked',
    'MM3': 'MM3TcChangeChecked',
    'MM4': 'MM4TcChangeChecked',
    'AM1': 'AM1TcChangeChecked',
    'AM2': 'AM2TcChangeChecked',
    'AM3': 'AM3TcChangeChecked',
    'AM4': 'AM4TcChangeChecked',
  }[widget.method]!;

  String get hw => {
    'MM1': 'MM1HwChecked',
    'MM2': 'MM2HwChecked',
    'MM3': 'MM3HwChecked',
    'MM4': 'MM4HwChecked',
    'AM1': 'AM1HwChecked',
    'AM2': 'AM2HwChecked',
    'AM3': 'AM3HwChecked',
    'AM4': 'AM4HwChecked',
  }[widget.method]!;

  String get hwTh => {
    'MM1': 'MM1HWTHChecked',
    'MM2': 'MM2HWTHChecked',
    'MM3': 'MM3HWTHChecked',
    'MM4': 'MM4HWTHChecked',
    'AM1': 'AM1HWTHChecked',
    'AM2': 'AM2HWTHChecked',
    'AM3': 'AM3HWTHChecked',
    'AM4': 'AM4HWTHChecked',
  }[widget.method]!;

  String get mf => {
    'MM1': 'MM1MfChecked',
    'MM2': 'MM2MfChecked',
    'MM3': 'MM3MfChecked',
    'MM4': 'MM4MfChecked',
    'AM1': 'AM1MfChecked',
    'AM2': 'AM2MfChecked',
    'AM3': 'AM3MfChecked',
    'AM4': 'AM4MfChecked',
  }[widget.method]!;

  String get tcTt => {
    'MM1': 'MM1TCCROSSEDTTChecked',
    'MM2': 'MM2TCCROSSEDTTChecked',
    'MM3': 'MM3TCCROSSEDTTChecked',
    'MM4': 'MM4TCCROSSEDTTChecked',
    'AM1': 'AM1TCCROSSEDTTChecked',
    'AM2': 'AM2TCCROSSEDTTChecked',
    'AM3': 'AM3TCCROSSEDTTChecked',
    'AM4': 'AM4TCCROSSEDTTChecked',
  }[widget.method]!;

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckedBoxProvider>(
      builder: (context, checkedbox, child) {
        if (checkedbox.isLoading) {
          return _buildPlaceholderUI();
        }
        final value = context.read<ValueProvider>();
        final symbol =
            (widget.method == "MM1" || widget.method == "MM2") || widget.method == "MM3" || widget.method == "MM4"
            ? value.manualSelectedValue
            : widget.amSymbol;
        String method = "";
        if (widget.method == "MM1") {
          method = "MM1";
        } else if (widget.method == "MM2") {
          method = "MM2";
        } else if (widget.method == "MM3") {
          method = "MM3";
        } else if (widget.method == "MM4") {
          method = "MM4";
        } else if (widget.method == "AM1") {
          method = "AM1";
        } else if (widget.method == "AM2") {
          method = "AM2";
        } else if (widget.method == "AM3") {
          method = "AM3";
        } else if (widget.method == "AM4") {
          method = "AM4";
        }
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: _buildRealUI(symbol ?? "", method, checkedbox),
        );
      },
    );
  }

  Widget _buildPlaceholderUI() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.5, color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Automatic Closing",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.add, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Sig", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.close, color: Color.fromRGBO(102, 7, 0, 1), size: 20.0),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("TC", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.arrow_upward_rounded, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                    Icon(Icons.arrow_downward_rounded, color: Color.fromRGBO(102, 7, 0, 1), size: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("HW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.arrow_upward_rounded, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                    Icon(Icons.arrow_downward_rounded, color: Color.fromRGBO(102, 7, 0, 1), size: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("MF", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.arrow_upward_rounded, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                    Icon(Icons.arrow_downward_rounded, color: Color.fromRGBO(102, 7, 0, 1), size: 20.0),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.add, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                    Icon(Icons.add, color: Color.fromRGBO(0, 57, 2, 1), size: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("HW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.close, color: Color.fromRGBO(102, 7, 0, 1), size: 20.0),
                    Text("TH", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRealUI(String symbol, String method, CheckedBoxProvider checkedbox) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(87, 71, 111, 197),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.5, color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Automatic Closing",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, tcTt)
                    ? ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, tcTt, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("HW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.close,
                      color: checkedbox.getValue(symbol, method, tcTt) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: checkedbox.getValue(symbol, method, hw)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: checkedbox.getValue(symbol, method, hw) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                    Text("TT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, reversal)
                    ? ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, reversal, context);
                },
                child: Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, signal)
                    ? ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, signal, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Sig", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.close,
                      color: checkedbox.getValue(symbol, method, signal) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadiusGeometry.circular(10)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                ),
                onPressed: () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("TC", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(Icons.arrow_upward_rounded, color: Color.fromRGBO(6, 255, 14, 1), size: 20.0),
                    Icon(Icons.arrow_downward_rounded, color: Colors.red, size: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, hw)
                    ? ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, hw, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("HW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: checkedbox.getValue(symbol, method, hw)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: checkedbox.getValue(symbol, method, hw) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, mf)
                    ? ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, mf, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("MF", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: checkedbox.getValue(symbol, method, mf)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: checkedbox.getValue(symbol, method, mf) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, reversalPlus)
                    ? ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, reversalPlus, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.add,
                      color: checkedbox.getValue(symbol, method, reversalPlus)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, reversalPlusPlus)
                    ? ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, reversalPlusPlus, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("Rev", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.add,
                      color: checkedbox.getValue(symbol, method, reversalPlusPlus)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.add,
                      color: checkedbox.getValue(symbol, method, reversalPlusPlus)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, hwTh)
                    ? ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromRGBO(190, 190, 190, 1),
                      ),
                onPressed: () async {
                  await checkedbox.changeValue(symbol, method, hwTh, context);
                },
                child: Row(
                  spacing: 3,
                  children: [
                    Text("HW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.close,
                      color: checkedbox.getValue(symbol, method, hwTh) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
                    Text("TH", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
