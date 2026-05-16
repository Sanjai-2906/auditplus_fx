// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class AutomaticMethod9Section extends StatefulWidget {
  const AutomaticMethod9Section({super.key});

  @override
  State<AutomaticMethod9Section> createState() => _AutomaticMethod9SectionState();
}

class _AutomaticMethod9SectionState extends State<AutomaticMethod9Section> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 5, bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<ValueProvider>(
                    builder: (context, autoLive, child) {
                      if (autoLive.liveAutomaticTradeM9.isEmpty) {
                        return Text("No items found");
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          child: Consumer<ValueProvider>(
                            builder: (context, autoLive, child) {
                              final items = autoLive.liveAutomaticTradeM9.values.toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    key: ValueKey(items[index].symbol),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 5.0, bottom: 5.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            borderRadius: BorderRadius.circular(15),
                                            border: BoxBorder.all(color: Colors.black),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      items[index].symbol,
                                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      items[index].volume.toStringAsFixed(2),
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(37, 99, 235, 1),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    style: ElevatedButton.styleFrom(
                                                      maximumSize: Size(45, 40),
                                                      backgroundColor: Color.fromRGBO(137, 207, 253, 1),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadiusGeometry.circular(5),
                                                        side: BorderSide(color: Colors.black, width: 1),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      await timeDialog(context, items[index], "AM9");
                                                      await Provider.of<ValueProvider>(
                                                        context,
                                                        listen: false,
                                                      ).updateTradeRange();
                                                    },
                                                    icon: Icon(Icons.hourglass_bottom, color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: TextButton(
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
                                                          method: "AM9",
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
                                                        method: "AM9",
                                                      );
                                                      await automaticTrading(context, data);
                                                      autoLive.removeLiveTrade(data.symbol, data.method);
                                                    },
                                                    icon: Icon(Icons.close, color: Color.fromRGBO(239, 68, 68, 1)),
                                                  ),
                                                ],
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
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
