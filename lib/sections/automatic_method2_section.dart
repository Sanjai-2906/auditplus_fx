import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../models/models.dart';
import 'sections.dart';

class AutomaticMethod2Section extends StatefulWidget {
  const AutomaticMethod2Section({super.key});

  @override
  State<AutomaticMethod2Section> createState() => _AutomaticMethod2SectionState();
}

class _AutomaticMethod2SectionState extends State<AutomaticMethod2Section> {
  Set<String> expandedSymbols = {};
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<ValueProvider>(
            builder: (context, autoLive, child) {
              if (autoLive.liveAutomaticTradeM2.isEmpty) {
                return Text("No items found");
              } else {
                return SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.height * 0.7,
                    child: Consumer<ValueProvider>(
                      builder: (context, autoLive, child) {
                        final items = autoLive.liveAutomaticTradeM2.values.toList();
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final symbol = items[index].symbol;

                            if (!context.read<CheckedBoxProvider>().am2ValuesPerSymbol.containsKey(symbol)) {
                              Future.microtask(() {
                                // ignore: use_build_context_synchronously
                                context.read<CheckedBoxProvider>().loadFromApi(symbol, 'AM2');
                              });
                            }
                            return Padding(
                              key: ValueKey(items[index].symbol),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(color: Colors.black),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 110,
                                              height: 35,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3.0),
                                                child: Text(
                                                  items[index].symbol,
                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 65,
                                              height: 35,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3.0),
                                                child: Text(
                                                  items[index].volume.toStringAsFixed(2),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(37, 99, 235, 1),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              style: ElevatedButton.styleFrom(
                                                maximumSize: Size(75, 40),
                                                backgroundColor: Color.fromRGBO(229, 231, 235, 1),
                                                foregroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadiusGeometry.circular(5),
                                                  side: BorderSide(color: Colors.black, width: 1),
                                                ),
                                              ),
                                              onPressed: () async {
                                                final data = CurrentAutomationModel(
                                                  symbol: items[index].symbol,
                                                  volume: items[index].volume,
                                                  isEnabled: true,
                                                  action: ActionType.close,
                                                  method: "AM2",
                                                );
                                                await automaticTrading(context, data);
                                              },
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              style: ElevatedButton.styleFrom(
                                                maximumSize: Size(45, 40),
                                                backgroundColor: Color.fromRGBO(254, 226, 226, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadiusGeometry.circular(5),
                                                  side: BorderSide(color: Colors.black, width: 1),
                                                ),
                                              ),
                                              onPressed: () async {
                                                final data = CurrentAutomationModel(
                                                  symbol: items[index].symbol,
                                                  volume: items[index].volume,
                                                  isEnabled: false,
                                                  action: ActionType.disable,
                                                  method: "AM2",
                                                );
                                                await automaticTrading(context, data);
                                                autoLive.removeLiveTrade(data.symbol, data.method);
                                              },
                                              icon: Icon(Icons.close, color: Color.fromRGBO(239, 68, 68, 1)),
                                            ),
                                            IconButton(
                                              style: ElevatedButton.styleFrom(
                                                maximumSize: Size(45, 40),
                                                backgroundColor: Color.fromRGBO(50, 187, 221, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadiusGeometry.circular(5),
                                                  side: BorderSide(color: Colors.black, width: 1),
                                                ),
                                              ),
                                              onPressed: () {
                                                final symbol = items[index].symbol;

                                                setState(() {
                                                  if (expandedSymbols.contains(symbol)) {
                                                    expandedSymbols.remove(symbol);
                                                  } else {
                                                    expandedSymbols.add(symbol);
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.add, color: Color.fromRGBO(12, 9, 56, 1)),
                                            ),
                                          ],
                                        ),
                                        if (expandedSymbols.contains(items[index].symbol))
                                          AutomaticClosingSection(method: 'AM2', amSymbol: items[index].symbol),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
