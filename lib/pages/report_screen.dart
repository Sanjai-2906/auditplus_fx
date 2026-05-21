import 'package:auditplus_fx/models/models.dart';
import 'package:auditplus_fx/utils/create_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';

class ReportScreen extends StatefulWidget {
  final List<SearchFieldListItem<String>> symbols;
  const ReportScreen({required this.symbols, super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? startDate;
  String? endDate;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  SearchFieldListItem<String>? menuSelectedItem;
  late FocusNode _menuSymbolFocusNode;
  String menuSelectedValue = "ALL";
  SearchFieldListItem<String>? get allItem => widget.symbols.isNotEmpty ? widget.symbols.first : null; // report List
  List<DbReportModel> reportList = [];
  @override
  void initState() {
    super.initState();

    _menuSymbolFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp(context);
    });
  }

  Future<void> _initializeApp(BuildContext context) async {
    final now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    print("Formatted Date: $formattedDate");
    final res = await getReport(context, "ALL", formattedDate, formattedDate);
    reportList = res;

    setState(() {
      if (widget.symbols.isNotEmpty) {
        menuSelectedItem = widget.symbols.first;
      }
      menuSelectedValue = "ALL";
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
          '${pickedDate.day.toString().padLeft(2, '0')}-'
          '${pickedDate.month.toString().padLeft(2, '0')}-'
          '${pickedDate.year}';

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
                  Consumer<ValueProvider>(
                    builder: (context, drop, child) {
                      return SizedBox(
                        width: 135,
                        height: 35,
                        child: SearchField<String>(
                          focusNode: _menuSymbolFocusNode,
                          suggestions: widget.symbols,
                          suggestionState: Suggestion.hidden,
                          selectedValue: widget.symbols.contains(drop.manualSelectedItem)
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
                              borderSide: const BorderSide(color: Color.fromRGBO(33, 52, 72, 1), width: 1.5),
                            ),
                          ),
                          maxSuggestionsInViewPort: 6,
                          onSearchTextChanged: (searchText) {
                            if (searchText.isEmpty) {
                              return List<SearchFieldListItem<String>>.from(widget.symbols);
                            }

                            final query = searchText.toUpperCase();
                            return widget.symbols.where((s) {
                              final key = s.searchKey.toUpperCase();
                              final value = (s.value ?? '').toUpperCase();
                              return key.contains(query) || value.contains(query);
                            }).toList();
                          },
                          onSuggestionTap: (SearchFieldListItem<String> item) {
                            _menuSymbolFocusNode.unfocus();

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
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.95,
                decoration: BoxDecoration(border: BoxBorder.all(width: 0.5, color: Colors.blue)),
                child: ListView.builder(
                  itemCount: reportList.length,
                  itemBuilder: (context, index) {
                    // return ListTile(title: Text(reportList[index].symbol));
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 3,
                              children: [
                                Text(reportList[index].symbol),
                                Text(typeConveter(reportList[index].actionType)),
                                Text(reportList[index].volume),
                              ],
                            ),
                            Text(reportList[index].profit.toStringAsFixed(2)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(reportList[index].openPrice.toStringAsFixed(2)),
                                Icon(Icons.trending_flat),
                                Text(reportList[index].closePrice.toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Text(
                                  "${reportList[index].closedAt!.year}: ${reportList[index].closedAt!.month}: ${reportList[index].closedAt!.day}",
                                ),
                                Text(
                                  "${reportList[index].closedAt!.hour}: ${reportList[index].closedAt!.minute}: ${reportList[index].closedAt!.second}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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

String typeConveter(String type) {
  if (type == "ORDER_TYPE_BUY") {
    return "buy";
  }
  return "sell";
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
