import 'package:auditplus_fx/models/models.dart';
import 'package:auditplus_fx/utils/create_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late List<String> list;
  String? startDate;
  String? endDate;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  SearchFieldListItem<String>? menuSelectedItem;
  late FocusNode _menuSymbolFocusNode;
  String menuSelectedValue = "ALL";
  List<SearchFieldListItem<String>> symbols = [];
  SearchFieldListItem<String>? get allItem => symbols.isNotEmpty ? symbols.first : null; // report List
  List<DbReportModel> reportList = [];

  // new logic
  List<DbReportModel> allReportList = [];
  List<DbReportModel> filteredReportList = [];

  String selectedSymbol = "ALL";
  @override
  void initState() {
    super.initState();

    _menuSymbolFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp(context);
    });
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

    // ignore: use_build_context_synchronously
    list = await getList(context);

    symbols = [
      SearchFieldListItem<String>("ALL", value: "ALL"),
      ...list.map((el) => SearchFieldListItem<String>(el, value: el)),
    ];
    final now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // ignore: use_build_context_synchronously
    final res = await getReport(context, "ALL", formattedDate, formattedDate);
    if (!mounted) return;
    setState(() {
      allReportList = res;
      filteredReportList = res;

      if (symbols.isNotEmpty) {
        menuSelectedItem = symbols.first;
      }

      menuSelectedValue = "ALL";
      selectedSymbol = "ALL";

      fromDateController.text = formattedDate;
      toDateController.text = formattedDate;
    });
  }

  Future<void> pickDate({required bool isFromDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2026),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formatted =
          '${pickedDate.year}-'
          '${pickedDate.month.toString().padLeft(2, '0')}-'
          '${pickedDate.day.toString().padLeft(2, '0')}';

      final apiFormat = DateFormat('yyyy-MM-dd').format(pickedDate);

      if (isFromDate) {
        startDate = apiFormat;
        setState(() {
          fromDateController.text = formatted;
        });
      } else {
        endDate = apiFormat;
        setState(() {
          toDateController.text = formatted;
        });
      }
    }
  }

  void applyFilters() {
    List<DbReportModel> tempList = List.from(allReportList);

    /// SYMBOL FILTER ONLY
    if (selectedSymbol != "ALL") {
      tempList = tempList.where((e) => e.symbol == selectedSymbol).toList();
    }

    tempList.sort((a, b) => a.symbol.compareTo(b.symbol));

    setState(() {
      filteredReportList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(209, 238, 250, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(33, 52, 72, 1),
        actions: <Widget>[
          Consumer<ValueProvider>(
            builder: (context, auto, child) {
              return TextButton(
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
              );
            },
          ),
        ],
        title: Text('Auditplus Fx', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: double.infinity),
              decoration: BoxDecoration(color: Color.fromRGBO(84, 119, 146, 1)),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 135,
                    height: 35,
                    child: SearchField<String>(
                      focusNode: _menuSymbolFocusNode,
                      suggestions: symbols,
                      suggestionState: Suggestion.hidden,
                      selectedValue: menuSelectedItem,
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
                          borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
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
                        _menuSymbolFocusNode.unfocus();

                        setState(() {
                          menuSelectedItem = item;

                          selectedSymbol = item.value!;
                          menuSelectedValue = item.value!;
                        });

                        applyFilters();
                      },
                      onSubmit: (item) {
                        Provider.of<ValueProvider>(
                          context,
                          listen: false,
                        ).setSelectedItem(SearchFieldListItem(item), context);
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(189, 232, 245, 1)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              dateField(
                                label: 'From Date *',
                                controller: fromDateController,
                                onTap: () {
                                  pickDate(isFromDate: true);
                                },
                              ),
                              dateField(
                                label: 'To Date *',
                                controller: toDateController,
                                onTap: () {
                                  pickDate(isFromDate: false);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(),
                                        borderRadius: BorderRadiusGeometry.circular(5),
                                      ),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                                    ),
                                    onPressed: () async {
                                      final from = startDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

                                      final to = endDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

                                      final res = await getReport(context, "ALL", from, to);

                                      setState(() {
                                        allReportList = res;
                                      });

                                      applyFilters();

                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: Text("Submit", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text("Filter", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    onPressed: () async {
                      final from = startDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

                      final to = endDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
                      reportList = await getReport(context, menuSelectedValue, from, to);
                      await createExcelFile(reportList);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.download, size: 18, color: Colors.white),
                        SizedBox(width: 6),
                        Text("Download", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListView.builder(
                  itemCount: filteredReportList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(189, 232, 245, 1),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: bottomModalWidget(filteredReportList[index]),
                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 3,
                                  children: [
                                    Text(filteredReportList[index].symbol),
                                    typeWidget(filteredReportList[index].actionType),
                                    Text(filteredReportList[index].volume),
                                  ],
                                ),
                                Text(
                                  filteredReportList[index].profit.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: filteredReportList[index].profit > 0
                                        ? Color.fromARGB(255, 24, 105, 255)
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(filteredReportList[index].openPrice.toStringAsFixed(2)),
                                    Icon(Icons.trending_flat),
                                    Text(filteredReportList[index].closePrice.toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Text(DateFormat('yyyy.MM.dd').format(filteredReportList[index].closedAt!)),
                                    Text(DateFormat('hh:mm:ss').format(filteredReportList[index].closedAt!)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget typeWidget(String type) {
  if (type == "DEAL_TYPE_BUY") {
    return Text("buy", style: TextStyle(color: const Color.fromARGB(255, 24, 105, 255)));
  }
  return Text("sell", style: TextStyle(color: Colors.red));
}

Widget dateField({required String label, required TextEditingController controller, required VoidCallback onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      InkWell(
        onTap: onTap,
        child: TextFormField(
          controller: controller,
          enabled: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today, size: 18),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ),
    ],
  );
}

Widget bottomModalWidget(DbReportModel item) {
  return Column(
    spacing: 10,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(spacing: 3, children: [Text(item.symbol), typeWidget(item.actionType), Text(item.volume)]),
          Text(item.positionId, style: TextStyle(color: Color.fromARGB(255, 24, 105, 255))),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(item.openPrice.toStringAsFixed(2)),
                Icon(Icons.trending_flat),
                Text(item.closePrice.toStringAsFixed(2)),
              ],
            ),
            Text(
              item.profit.toStringAsFixed(2),
              style: TextStyle(color: item.profit > 0 ? Color.fromARGB(255, 24, 105, 255) : Colors.red),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Row(
            spacing: 5,
            children: [
              Text(DateFormat('yyyy.MM.dd').format(item.openedAt!)),
              Text(DateFormat('hh:mm:ss').format(item.openedAt!)),
            ],
          ),
          Icon(Icons.trending_flat),
          Row(
            spacing: 5,
            children: [
              Text(DateFormat('yyyy.MM.dd').format(item.closedAt!)),
              Text(DateFormat('hh:mm:ss').format(item.closedAt!)),
            ],
          ),
        ],
      ),
      // Row(children: [Text("Method: ${item.info}", softWrap: true)]),
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [Expanded(child: Text("Description: ${item.description}", softWrap: true, maxLines: 3))],
      // ),
    ],
  );
}
