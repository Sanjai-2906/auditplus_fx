import 'package:auditplus_fx/sections/automatic_method1_section.dart';
import 'package:auditplus_fx/sections/sections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../models/models.dart';

class AutomationScreen extends StatefulWidget {
  final List<SearchFieldListItem<String>> symbols;
  const AutomationScreen({super.key, required this.symbols});

  @override
  State<AutomationScreen> createState() => _AutomationScreenState();
}

class _AutomationScreenState extends State<AutomationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(209, 238, 250, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Consumer<ValueProvider>(
              builder: (context, am, child) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade200,
                    color: Color.fromRGBO(209, 238, 250, 1),
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => am.changeMethodScreen('AM', Method.method1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: am.autoScreenView == Method.method1
                                  ? const Color.fromRGBO(33, 52, 72, 1)
                                  // : Colors.transparent,
                                  : Color.fromRGBO(209, 238, 250, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Method1",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: am.autoScreenView == Method.method1
                                      // ? Colors.white
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => am.changeMethodScreen('AM', Method.method2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: am.autoScreenView == Method.method2
                                  ? const Color.fromRGBO(33, 52, 72, 1)
                                  // : Colors.transparent,
                                  : Color.fromRGBO(209, 238, 250, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Method2",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: am.autoScreenView == Method.method2 ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5, bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.7,
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<ValueProvider>(
                          builder: (context, drop, child) {
                            return SizedBox(
                              width: 110,
                              height: 35,
                              child: SearchField<String>(
                                suggestions: widget.symbols,
                                suggestionState: Suggestion.hidden,
                                selectedValue: widget.symbols.any((e) => e.searchKey == drop.amSelectedItem?.searchKey)
                                    ? drop.amSelectedItem
                                    : null,
                                searchInputDecoration: SearchInputDecoration(
                                  hintText: "Symbols",
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.black, width: 1),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                                  ),
                                ),
                                maxSuggestionsInViewPort: 6,
                                onSearchTextChanged: (searchText) {
                                  if (searchText.isEmpty) {
                                    return List<SearchFieldListItem<String>>.from(widget.symbols);
                                  }
                                  context.read<ValueProvider>().amClearSelectedValue();

                                  final query = searchText.toUpperCase();
                                  return widget.symbols.where((s) {
                                    final key = s.searchKey.toUpperCase();
                                    final value = (s.value ?? '').toUpperCase();
                                    return key.contains(query) || value.contains(query);
                                  }).toList();
                                },
                                onSuggestionTap: (SearchFieldListItem<String> item) {
                                  context.read<ValueProvider>().setAMSelectedItem(item, context);
                                },
                                onSubmit: (item) async {
                                  Provider.of<ValueProvider>(
                                    context,
                                    listen: false,
                                  ).setAMSelectedItem(SearchFieldListItem(item), context);
                                  final data = CurrentAutomationModel(
                                    symbol: drop.amSelectedValue ?? "",
                                    volume: drop.amVolume,
                                    isEnabled: true,
                                    action: ActionType.add,
                                    method: "AM",
                                  );
                                  await automaticTrading(context, data);
                                },
                              ),
                            );
                          },
                        ),
                        Consumer<ValueProvider>(
                          builder: (context, drop, child) {
                            return SizedBox(
                              height: 35,
                              width: 100,
                              child: TextFormField(
                                controller: drop.amVolumeController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (newValue) {
                                  final parsedValue = double.tryParse(newValue);
                                  if (parsedValue != null) {
                                    drop.setAMVolume('AM', parsedValue);
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  final data = CurrentAutomationModel(
                                    symbol: drop.amSelectedValue ?? "",
                                    volume: drop.amVolume,
                                    isEnabled: true,
                                    action: ActionType.add,
                                    method: "AM",
                                  );
                                  await automaticTrading(context, data);
                                },
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 6),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.black),
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
                        SizedBox(width: 70),
                        Consumer<ValueProvider>(
                          builder: (context, autoLive, child) {
                            return TextButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(75, 40),
                                backgroundColor: Color.fromRGBO(2, 172, 58, 1),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                String method = autoLive.autoScreenView == Method.method1 ? 'AM1' : 'AM2';
                                final data = CurrentAutomationModel(
                                  symbol: autoLive.amSelectedValue ?? "",
                                  volume: autoLive.amVolume,
                                  isEnabled: true,
                                  action: ActionType.add,
                                  // method: "AM",
                                  method: method,
                                );
                                await automaticTrading(context, data);
                                autoLive.addLiveTrade(data);
                              },
                              child: Text('Add', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer<ValueProvider>(
              builder: (context, screen, child) {
                return PageView(
                  // Link this to your provider's state to jump between sections
                  controller: PageController(initialPage: screen.autoScreenView == Method.method1 ? 0 : 1),
                  onPageChanged: (index) {
                    final method = index == 0 ? Method.method1 : Method.method2;
                    screen.changeMethodScreen('AM', method);
                  },
                  physics: const BouncingScrollPhysics(), // Optional: for a nice bounce effect
                  children: [AutomaticMethod1Section(), AutomaticMethod2Section()],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
