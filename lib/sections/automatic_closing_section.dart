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
    'MM5': 'MM5ReversalPlusPlusChecked',
    'MM6': 'MM6ReversalPlusPlusChecked',
    'MM7': 'MM7ReversalPlusPlusChecked',
    'MM8': 'MM8ReversalPlusPlusChecked',
    'MM9': 'MM9ReversalPlusPlusChecked',
    'AM1': 'AM1ReversalPlusPlusChecked',
    'AM2': 'AM2ReversalPlusPlusChecked',
    'AM3': 'AM3ReversalPlusPlusChecked',
    'AM4': 'AM4ReversalPlusPlusChecked',
    'AM5': 'AM5ReversalPlusPlusChecked',
    'AM6': 'AM6ReversalPlusPlusChecked',
    'AM7': 'AM7ReversalPlusPlusChecked',
    'AM8': 'AM8ReversalPlusPlusChecked',
    'AM9': 'AM9ReversalPlusPlusChecked',
  }[widget.method]!;

  String get reversalPlus => {
    'MM1': 'MM1ReversalPlusChecked',
    'MM2': 'MM2ReversalPlusChecked',
    'MM3': 'MM3ReversalPlusChecked',
    'MM4': 'MM4ReversalPlusChecked',
    'MM5': 'MM5ReversalPlusChecked',
    'MM6': 'MM6ReversalPlusChecked',
    'MM7': 'MM7ReversalPlusChecked',
    'MM8': 'MM8ReversalPlusChecked',
    'MM9': 'MM9ReversalPlusChecked',
    'AM1': 'AM1ReversalPlusChecked',
    'AM2': 'AM2ReversalPlusChecked',
    'AM3': 'AM3ReversalPlusChecked',
    'AM4': 'AM4ReversalPlusChecked',
    'AM5': 'AM5ReversalPlusChecked',
    'AM6': 'AM6ReversalPlusChecked',
    'AM7': 'AM7ReversalPlusChecked',
    'AM8': 'AM8ReversalPlusChecked',
    'AM9': 'AM9ReversalPlusChecked',
  }[widget.method]!;

  String get reversal => {
    'MM1': 'MM1ReversalChecked',
    'MM2': 'MM2ReversalChecked',
    'MM3': 'MM3ReversalChecked',
    'MM4': 'MM4ReversalChecked',
    'MM5': 'MM5ReversalChecked',
    'MM6': 'MM6ReversalChecked',
    'MM7': 'MM7ReversalChecked',
    'MM8': 'MM8ReversalChecked',
    'MM9': 'MM9ReversalChecked',
    'AM1': 'AM1ReversalChecked',
    'AM2': 'AM2ReversalChecked',
    'AM3': 'AM3ReversalChecked',
    'AM4': 'AM4ReversalChecked',
    'AM5': 'AM5ReversalChecked',
    'AM6': 'AM6ReversalChecked',
    'AM7': 'AM7ReversalChecked',
    'AM8': 'AM8ReversalChecked',
    'AM9': 'AM9ReversalChecked',
  }[widget.method]!;

  String get signal => {
    'MM1': 'MM1SignalExitChecked',
    'MM2': 'MM2SignalExitChecked',
    'MM3': 'MM3SignalExitChecked',
    'MM4': 'MM4SignalExitChecked',
    'MM5': 'MM5SignalExitChecked',
    'MM6': 'MM6SignalExitChecked',
    'MM7': 'MM7SignalExitChecked',
    'MM8': 'MM8SignalExitChecked',
    'MM9': 'MM9SignalExitChecked',
    'AM1': 'AM1SignalExitChecked',
    'AM2': 'AM2SignalExitChecked',
    'AM3': 'AM3SignalExitChecked',
    'AM4': 'AM4SignalExitChecked',
    'AM5': 'AM5SignalExitChecked',
    'AM6': 'AM6SignalExitChecked',
    'AM7': 'AM7SignalExitChecked',
    'AM8': 'AM8SignalExitChecked',
    'AM9': 'AM9SignalExitChecked',
  }[widget.method]!;

  String get tc => {
    'MM1': 'MM1TcChangeChecked',
    'MM2': 'MM2TcChangeChecked',
    'MM3': 'MM3TcChangeChecked',
    'MM4': 'MM4TcChangeChecked',
    'MM5': 'MM5TcChangeChecked',
    'MM6': 'MM6TcChangeChecked',
    'MM7': 'MM7TcChangeChecked',
    'MM8': 'MM8TcChangeChecked',
    'MM9': 'MM9TcChangeChecked',
    'AM1': 'AM1TcChangeChecked',
    'AM2': 'AM2TcChangeChecked',
    'AM3': 'AM3TcChangeChecked',
    'AM4': 'AM4TcChangeChecked',
    'AM5': 'AM5TcChangeChecked',
    'AM6': 'AM6TcChangeChecked',
    'AM7': 'AM7TcChangeChecked',
    'AM8': 'AM8TcChangeChecked',
    'AM9': 'AM9TcChangeChecked',
  }[widget.method]!;

  String get tt => {
    'MM1': 'MM1TtChecked',
    'MM2': 'MM2TtChecked',
    'MM3': 'MM3TtChecked',
    'MM4': 'MM4TtChecked',
    'MM5': 'MM5TtChecked',
    'MM6': 'MM6TtChecked',
    'MM7': 'MM7TtChecked',
    'MM8': 'MM8TtChecked',
    'MM9': 'MM9TtChecked',
    'AM1': 'AM1TtChecked',
    'AM2': 'AM2TtChecked',
    'AM3': 'AM3TtChecked',
    'AM4': 'AM4TtChecked',
    'AM5': 'AM5TtChecked',
    'AM6': 'AM6TtChecked',
    'AM7': 'AM7TtChecked',
    'AM8': 'AM8TtChecked',
    'AM9': 'AM9TtChecked',
  }[widget.method]!;

  String get hw => {
    'MM1': 'MM1HwChecked',
    'MM2': 'MM2HwChecked',
    'MM3': 'MM3HwChecked',
    'MM4': 'MM4HwChecked',
    'MM5': 'MM5HwChecked',
    'MM6': 'MM6HwChecked',
    'MM7': 'MM7HwChecked',
    'MM8': 'MM8HwChecked',
    'MM9': 'MM9HwChecked',
    'AM1': 'AM1HwChecked',
    'AM2': 'AM2HwChecked',
    'AM3': 'AM3HwChecked',
    'AM4': 'AM4HwChecked',
    'AM5': 'AM5HwChecked',
    'AM6': 'AM6HwChecked',
    'AM7': 'AM7HwChecked',
    'AM8': 'AM8HwChecked',
    'AM9': 'AM9HwChecked',
  }[widget.method]!;

  String get hwTh => {
    'MM1': 'MM1HWTHChecked',
    'MM2': 'MM2HWTHChecked',
    'MM3': 'MM3HWTHChecked',
    'MM4': 'MM4HWTHChecked',
    'MM5': 'MM5HWTHChecked',
    'MM6': 'MM6HWTHChecked',
    'MM7': 'MM7HWTHChecked',
    'MM8': 'MM8HWTHChecked',
    'MM9': 'MM9HWTHChecked',
    'AM1': 'AM1HWTHChecked',
    'AM2': 'AM2HWTHChecked',
    'AM3': 'AM3HWTHChecked',
    'AM4': 'AM4HWTHChecked',
    'AM5': 'AM5HWTHChecked',
    'AM6': 'AM6HWTHChecked',
    'AM7': 'AM7HWTHChecked',
    'AM8': 'AM8HWTHChecked',
    'AM9': 'AM9HWTHChecked',
  }[widget.method]!;

  String get mf => {
    'MM1': 'MM1MfChecked',
    'MM2': 'MM2MfChecked',
    'MM3': 'MM3MfChecked',
    'MM4': 'MM4MfChecked',
    'MM5': 'MM5MfChecked',
    'MM6': 'MM6MfChecked',
    'MM7': 'MM7MfChecked',
    'MM8': 'MM8MfChecked',
    'MM9': 'MM9MfChecked',
    'AM1': 'AM1MfChecked',
    'AM2': 'AM2MfChecked',
    'AM3': 'AM3MfChecked',
    'AM4': 'AM4MfChecked',
    'AM5': 'AM5MfChecked',
    'AM6': 'AM6MfChecked',
    'AM7': 'AM7MfChecked',
    'AM8': 'AM8MfChecked',
    'AM9': 'AM9MfChecked',
  }[widget.method]!;

  String get tcTt => {
    'MM1': 'MM1TCCROSSEDTTChecked',
    'MM2': 'MM2TCCROSSEDTTChecked',
    'MM3': 'MM3TCCROSSEDTTChecked',
    'MM4': 'MM4TCCROSSEDTTChecked',
    'MM5': 'MM5TCCROSSEDTTChecked',
    'MM6': 'MM6TCCROSSEDTTChecked',
    'MM7': 'MM7TCCROSSEDTTChecked',
    'MM8': 'MM8TCCROSSEDTTChecked',
    'MM9': 'MM9TCCROSSEDTTChecked',
    'AM1': 'AM1TCCROSSEDTTChecked',
    'AM2': 'AM2TCCROSSEDTTChecked',
    'AM3': 'AM3TCCROSSEDTTChecked',
    'AM4': 'AM4TCCROSSEDTTChecked',
    'AM5': 'AM5TCCROSSEDTTChecked',
    'AM6': 'AM6TCCROSSEDTTChecked',
    'AM7': 'AM7TCCROSSEDTTChecked',
    'AM8': 'AM8TCCROSSEDTTChecked',
    'AM9': 'AM9TCCROSSEDTTChecked',
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
            (widget.method == "MM1" || widget.method == "MM2") ||
                widget.method == "MM3" ||
                widget.method == "MM4" ||
                widget.method == "MM5" ||
                widget.method == "MM6" ||
                widget.method == "MM7" ||
                widget.method == "MM8" ||
                widget.method == "MM9"
            ? value.manualSelectedValue
            : widget.amSymbol;
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: _buildRealUI(symbol ?? "", widget.method, checkedbox),
        );
      },
    );
  }

  Widget _buildPlaceholderUI() {
    return Container(
      padding: EdgeInsets.all(5),
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
    final isAm4 = method == "AM4";
    final isAm5 = method == "AM5";
    final isAm8 = method == "AM8";
    return Container(
      padding: EdgeInsets.all(5),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: checkedbox.getValue(symbol, method, tt)
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
                onPressed: !isAm8
                    ? () async {
                        await checkedbox.changeValue(symbol, method, tt, context);
                      }
                    : () {},
                child: Row(
                  spacing: 3,
                  children: [
                    Text("TT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.arrow_upward_rounded,
                      color: checkedbox.getValue(symbol, method, tt)
                          ? Color.fromRGBO(6, 255, 14, 1)
                          : Color.fromRGBO(0, 57, 2, 1),
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: checkedbox.getValue(symbol, method, tt) ? Colors.red : Color.fromRGBO(102, 7, 0, 1),
                      size: 20.0,
                    ),
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
                style: checkedbox.getValue(symbol, method, tc)
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
                onPressed: !isAm8
                    ? () {}
                    : () async {
                        await checkedbox.changeValue(symbol, method, tc, context);
                      },
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
                onPressed: isAm4 || isAm5
                    ? () {}
                    : () async {
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
                onPressed: isAm4 || isAm5
                    ? () {}
                    : () async {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        ],
      ),
    );
  }
}
