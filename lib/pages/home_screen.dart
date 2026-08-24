// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auditplus_fx/pages/automation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';
import '../utils/utils.dart';
import '../sections/sections.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

late List<String> list;

class HomeScreenState extends State<HomeScreen> {
  List<String> list = [];
  List<SearchFieldListItem<String>> symbols = [];
  bool isLoading = true;
  bool _isDialogOpen = false;
  String? lastTriggeredMethod;
  Set<String> _activeTriggeredMethods = {};
  late Future<void> _initFuture;
  late TextEditingController _symbolController;

  late TextEditingController _tokenController;
  late FocusNode _symbolFocusNode;
  final FocusNode _longButtonFocusNode = FocusNode();
  final FocusNode _shortButtonFocusNode = FocusNode();
  final FocusNode _closeButtonFocusNode = FocusNode();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _symbolFocusNode = FocusNode();
    _tokenController = TextEditingController();
    _symbolController = TextEditingController();

    _initFuture = _initializeApp(context);
  }

  Future<void> _initializeApp(BuildContext context) async {
    final provider = Provider.of<MytokenProvider>(context, listen: false);

    while (provider.isLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final token = provider.token;

    if (token == null || token.isEmpty) {
      return;
    }

    list = await getList(context);

    symbols = list.map((el) {
      return SearchFieldListItem<String>(el, value: el.toString());
    }).toList();

    if (list.isNotEmpty) {}

    if (mounted) {
      _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
        if (!mounted) return;
        liveUpdation(context);
      });
    }
  }

  bool _setEquals(Set<String> a, Set<String> b) {
    if (a.length != b.length) return false;
    for (final item in a) {
      if (!b.contains(item)) return false;
    }
    return true;
  }

  String? _pickEnabledMethod(Set<String> triggers, ValueProvider auto) {
    final orderedMethods = [
      if (auto.isM1Checked) "M1",
      if (auto.isM2Checked) "M2",
      if (auto.isM3Checked) "M3",
      if (auto.isM4Checked) "M4",
      if (auto.isM5Checked) "M5",
      if (auto.isM6Checked) "M6",
      if (auto.isM7Checked) "M7",
      if (auto.isM8Checked) "M8",
    ];

    for (final method in orderedMethods) {
      if (triggers.any((e) => e.startsWith(method))) {
        return method;
      }
    }
    return null;
  }

  void _checkAndShowMethodDialog(BuildContext context, ValueProvider auto, CheckedBoxProvider check) {
    final symbol = auto.manualSelectedValue;

    if (symbol == null || symbol.isEmpty) return;
    if (check.isLoading) return;
    if (_isDialogOpen) return;

    final currentTriggered = <String>{};

    if (check.isM1LongAllChecked(symbol)) currentTriggered.add("M1_LONG");
    if (check.isM1ShortAllChecked(symbol)) currentTriggered.add("M1_SHORT");
    if (check.isM2LongAllChecked(symbol)) currentTriggered.add("M2_LONG");
    if (check.isM2ShortAllChecked(symbol)) currentTriggered.add("M2_SHORT");
    if (check.isM3LongAllChecked(symbol)) currentTriggered.add("M3_LONG");
    if (check.isM3ShortAllChecked(symbol)) currentTriggered.add("M3_SHORT");
    if (check.isM4LongAllChecked(symbol)) currentTriggered.add("M4_LONG");
    if (check.isM4ShortAllChecked(symbol)) currentTriggered.add("M4_SHORT");
    if (check.isM5LongAllChecked(symbol)) currentTriggered.add("M5_LONG");
    if (check.isM5ShortAllChecked(symbol)) currentTriggered.add("M5_SHORT");
    if (check.isM6LongAllChecked(symbol)) currentTriggered.add("M6_LONG");
    if (check.isM6ShortAllChecked(symbol)) currentTriggered.add("M6_SHORT");
    if (check.isM7LongAllChecked(symbol)) currentTriggered.add("M7_LONG");
    if (check.isM7ShortAllChecked(symbol)) currentTriggered.add("M7_SHORT");
    if (check.isM8LongAllChecked(symbol)) currentTriggered.add("M8_LONG");
    if (check.isM8ShortAllChecked(symbol)) currentTriggered.add("M8_SHORT");

    if (currentTriggered.isEmpty) {
      _activeTriggeredMethods.clear();
      lastTriggeredMethod = null;
      return;
    }

    if (_setEquals(currentTriggered, _activeTriggeredMethods)) {
      return;
    }
    final newTriggers = currentTriggered.difference(_activeTriggeredMethods);
    _activeTriggeredMethods = {...currentTriggered};

    if (newTriggers.isEmpty) return;

    final method = _pickEnabledMethod(newTriggers, auto);
    if (method == null) return;

    lastTriggeredMethod = method;
    _isDialogOpen = true;

    showDialog(
      context: context,
      builder: (_) => MethodDialog(method: method),
    ).then((_) {
      if (!mounted) return;
      setState(() {
        _isDialogOpen = false;
      });
    });
  }

  @override
  void dispose() {
    _symbolFocusNode.dispose();
    _symbolController.dispose();
    _longButtonFocusNode.dispose();
    _shortButtonFocusNode.dispose();
    _closeButtonFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        final myTokenProvider = Provider.of<MytokenProvider>(context);

        //  Case 1: Still waiting (either token or list)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color.fromRGBO(209, 238, 250, 1),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Center(
                  child: Text("Token getting...", style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        }

        //  Case 2: Error (optional)
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(209, 238, 250, 1),
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        //Case 3: If the value provider loading - show CircularprogressIndicator
        if (context.watch<ValueProvider>().isLoading) {
          return CircularProgressIndicator();
        }

        //  Case 4: Token missing — show input screen
        final token = myTokenProvider.token;
        if (token == null || token.isEmpty) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(209, 238, 250, 1),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  const Text('Enter the token', style: TextStyle(fontSize: 16, color: Colors.black)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _tokenController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Token'),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        side: BorderSide(color: Colors.black, width: 1.2),
                      ),
                      backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                    ),
                    onPressed: () {
                      myTokenProvider.setToken(_tokenController.text);
                      setState(() {});
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        }

        //  Case 5: Everything ready → show your main UI
        return Scaffold(
          backgroundColor: const Color.fromRGBO(209, 238, 250, 1),
          drawer: Drawer(
            backgroundColor: const Color.fromRGBO(209, 238, 250, 1),
            width: MediaQuery.of(context).size.width * 0.6,
            child: DrawerWidget(),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromRGBO(33, 52, 72, 1),
            actions: <Widget>[
              Consumer<ValueProvider>(
                builder: (context, auto, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: auto.isAutomaticSectionEnabled
                            ? Color.fromRGBO(44, 187, 104, 1)
                            : Color.fromRGBO(189, 232, 245, 1),
                        foregroundColor: auto.isAutomaticSectionEnabled ? Color.fromRGBO(2, 12, 40, 1) : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      onPressed: () => auto.setAutomaticEnable(),
                      child: Text('AUTO', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ],
            title: Text('Auditplus Fx', style: TextStyle(color: Colors.white)),
          ),
          body: Consumer2<ValueProvider, CheckedBoxProvider>(
            builder: (context, auto, check, child) {
              if (!auto.isAutomaticSectionEnabled && auto.manualSelectedValue != null && !check.isLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  _checkAndShowMethodDialog(context, auto, check);
                });
              }
              return auto.isAutomaticSectionEnabled
                  ? AutomationScreen(symbols: symbols)
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: double.infinity),
                            decoration: BoxDecoration(color: Color.fromRGBO(84, 119, 146, 1)),
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Consumer<ValueProvider>(
                                  builder: (context, drop, child) {
                                    return SizedBox(
                                      width: 150,
                                      height: 35,
                                      child: SearchField<String>(
                                        controller: _symbolController,
                                        focusNode: _symbolFocusNode,
                                        suggestions: symbols,
                                        suggestionState: Suggestion.hidden,
                                        selectedValue: symbols.contains(drop.manualSelectedItem)
                                            ? drop.manualSelectedItem
                                            : null,
                                        searchInputDecoration: SearchInputDecoration(
                                          hintText: "Symbols",
                                          filled: true,
                                          fillColor: Colors.white,
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(33, 52, 72, 1),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        maxSuggestionsInViewPort: 6,
                                        onSearchTextChanged: (searchText) {
                                          if (searchText.isEmpty) {
                                            return List<SearchFieldListItem<String>>.from(symbols);
                                          }

                                          final query = searchText.toUpperCase();
                                          return symbols.where((s) {
                                            final key = s.searchKey.toUpperCase();
                                            final value = (s.value ?? '').toUpperCase();
                                            return key.contains(query) || value.contains(query);
                                          }).toList();
                                        },
                                        onSuggestionTap: (SearchFieldListItem<String> item) {
                                          _symbolController.text = item.searchKey;
                                          _symbolFocusNode.unfocus();

                                          context.read<ValueProvider>().setSelectedItem(item, context);
                                          context.read<CheckedBoxProvider>().loadAll(item.value!);
                                        },
                                        onSubmit: (item) {
                                          Provider.of<ValueProvider>(
                                            context,
                                            listen: false,
                                          ).setSelectedItem(SearchFieldListItem(item), context);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () => showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => MethodDialog(method: "ALL"),
                                  ),
                                  child: Text(
                                    'All Methods',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(context: context, builder: (context) => settingDialog());
                                  },
                                  icon: Icon(Icons.settings, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.9, child: ManualMethodSection()),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}

Widget settingDialog() {
  return Dialog(
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(189, 232, 245, 1), borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ValueProvider>(
        builder: (context, val, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Methods', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM1Checked,
                    onChanged: (_) {
                      val.enableMethod("MM1");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM2Checked,
                    onChanged: (_) {
                      val.enableMethod("MM2");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM3Checked,
                    onChanged: (value) {
                      val.enableMethod("MM3");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 4', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM4Checked,
                    onChanged: (_) {
                      val.enableMethod("MM4");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM5Checked,
                    onChanged: (_) {
                      val.enableMethod("MM5");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 6', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM6Checked,
                    onChanged: (_) {
                      val.enableMethod("MM6");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 7', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM7Checked,
                    onChanged: (_) {
                      val.enableMethod("MM7");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Method 8', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Checkbox(
                    value: val.isM8Checked,
                    onChanged: (_) {
                      val.enableMethod("MM8");
                    },
                    activeColor: Colors.green,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text('Method 9', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              //     Checkbox(
              //       value: val.isM9Checked,
              //       onChanged: (_) {
              //         val.enableMethod("MM9");
              //       },
              //       activeColor: Colors.green,
              //     ),
              //   ],
              // ),
            ],
          );
        },
      ),
    ),
  );
}
