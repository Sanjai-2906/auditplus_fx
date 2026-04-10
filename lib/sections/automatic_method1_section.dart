import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../models/models.dart';
import 'sections.dart';

class AutomaticMethod1Section extends StatefulWidget {
  const AutomaticMethod1Section({super.key});

  @override
  State<AutomaticMethod1Section> createState() => _AutomaticMethod1SectionState();
}

class _AutomaticMethod1SectionState extends State<AutomaticMethod1Section> {
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
              if (autoLive.liveAutomaticTradeM1.isEmpty) {
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
                        return ListView.builder(
                          itemCount: autoLive.liveAutomaticTradeM1.length,
                          itemBuilder: (context, index) {
                            final symbol = autoLive.liveAutomaticTradeM1[index].symbol;

                            if (!context.read<CheckedBoxProvider>().am1ValuesPerSymbol.containsKey(symbol)) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.read<CheckedBoxProvider>().loadFromApi(symbol, 'AM1');
                              });
                            }
                            return Padding(
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
                                                  autoLive.liveAutomaticTradeM1[index].symbol,
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
                                                  autoLive.liveAutomaticTradeM1[index].volume.toString(),
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
                                                  // symbol: autoLive.amSelectedValue ?? "",
                                                  symbol: autoLive.liveAutomaticTradeM1[index].symbol,
                                                  // volume: autoLive.amVolume,
                                                  volume: autoLive.liveAutomaticTradeM1[index].volume,
                                                  isEnabled: true,
                                                  action: ActionType.close,
                                                  method: "AM1",
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
                                                  // symbol: autoLive.amSelectedValue ?? "",
                                                  symbol: autoLive.liveAutomaticTradeM1[index].symbol,
                                                  // volume: autoLive.amVolume,
                                                  volume: autoLive.liveAutomaticTradeM1[index].volume,
                                                  isEnabled: false,
                                                  action: ActionType.disable,
                                                  method: "AM1",
                                                );
                                                await automaticTrading(context, data);
                                                // autoLive.removeLiveTrade(data.symbol);
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
                                                final symbol = autoLive.liveAutomaticTradeM1[index].symbol;

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
                                        if (expandedSymbols.contains(autoLive.liveAutomaticTradeM1[index].symbol))
                                          AutomaticClosingSection(
                                            method: 'AM1',
                                            amSymbol: autoLive.liveAutomaticTradeM1[index].symbol,
                                          ),
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
