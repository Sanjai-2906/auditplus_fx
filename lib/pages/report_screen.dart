import 'package:auditplus_fx/models/models.dart';
import 'package:auditplus_fx/pages/home_screen.dart';
import 'package:auditplus_fx/utils/create_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../Providers/providers.dart';
import '../api_methods/api_methods.dart';

enum ReportSortType {
  none,
  profitAsc,
  profitDesc,
  typeAsc,
  typeDesc,
  volumeAsc,
  volumeDesc,
  openTimeAsc,
  openTimeDesc,
  closeTimeAsc,
  closeTimeDesc,
}

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

  ReportSortType currentSort = ReportSortType.none;

  int expandedIndex = -1;
  bool isLoading = true;

  String selectedSymbol = "ALL";
  @override
  void initState() {
    super.initState();

    _menuSymbolFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp(context);
    });
  }

  @override
  void dispose() {
    _menuSymbolFocusNode.dispose();
    super.dispose();
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

      isLoading = false;
    });
  }

  Future<void> pickDate({required bool isFromDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
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

  void applySymbolFilters() {
    List<DbReportModel> tempList = List.from(allReportList);

    if (selectedSymbol != "ALL") {
      tempList = tempList.where((e) => e.symbol == selectedSymbol).toList();
    }

    tempList.sort((a, b) => a.symbol.compareTo(b.symbol));

    setState(() {
      filteredReportList = tempList;
      expandedIndex = -1;
    });
  }

  void applySort(ReportSortType sortType) {
    currentSort = sortType;

    List<DbReportModel> tempList = List.from(allReportList);

    switch (sortType) {
      case ReportSortType.profitAsc:
        tempList.sort((a, b) => a.profit.compareTo(b.profit));
        break;

      case ReportSortType.profitDesc:
        tempList.sort((a, b) => b.profit.compareTo(a.profit));
        break;

      case ReportSortType.typeAsc:
        tempList.sort((a, b) {
          return a.actionType.compareTo(b.actionType);
        });
        break;

      case ReportSortType.typeDesc:
        tempList.sort((a, b) {
          return b.actionType.compareTo(a.actionType);
        });
        break;

      case ReportSortType.volumeAsc:
        tempList.sort((a, b) => num.parse(a.volume).compareTo(num.parse(b.volume)));
        break;

      case ReportSortType.volumeDesc:
        tempList.sort((a, b) => num.parse(b.volume).compareTo(num.parse(a.volume)));
        break;

      case ReportSortType.openTimeAsc:
        tempList.sort((a, b) => DateTime.parse(a.openedAt ?? '').compareTo(DateTime.parse(b.openedAt!)));
        break;

      case ReportSortType.openTimeDesc:
        tempList.sort((a, b) => DateTime.parse(b.openedAt ?? '').compareTo(DateTime.parse(a.openedAt!)));
        break;

      case ReportSortType.closeTimeAsc:
        tempList.sort((a, b) => DateTime.parse(a.closedAt ?? '').compareTo(DateTime.parse(b.closedAt ?? '')));
        break;

      case ReportSortType.closeTimeDesc:
        tempList.sort((a, b) => DateTime.parse(b.closedAt ?? '').compareTo(DateTime.parse(a.closedAt ?? '')));
        break;

      case ReportSortType.none:
        tempList = allReportList;
        break;
    }

    setState(() {
      filteredReportList = tempList;
    });
  }

  double get totalProfit {
    return filteredReportList.where((e) => e.dealType == "TRADE").fold(0.0, (sum, item) => sum + item.profit);
  }

  double get totalSwap {
    return filteredReportList.where((e) => e.dealType == "TRADE").fold(0.0, (sum, item) => sum + item.swap);
  }

  double get totalCommission {
    return filteredReportList.where((e) => e.dealType == "TRADE").fold(0.0, (sum, item) => sum + item.commission);
  }

  double get totalDeposit {
    return filteredReportList.where((e) => e.dealType == "DEPOSIT").fold(0.0, (sum, item) => sum + item.profit);
  }

  double get totalWithdraw {
    return filteredReportList.where((e) => e.dealType == "WITHDRAW").fold(0.0, (sum, item) => sum + item.profit.abs());
  }

  double get totalBalance {
    return totalDeposit + totalProfit + totalSwap + totalCommission - totalWithdraw;
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
                  onPressed: () {
                    auto.setAutomaticEnable();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text('AUTO', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        ],
        title: Text('Auditplus Fx', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
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

                              // applyFilters();
                              applySymbolFilters();
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

                                            // applyFilters();
                                            applySymbolFilters();

                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
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
                            elevation: 0,
                            minimumSize: Size.zero,
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
                          child: Icon(Icons.download, size: 22, color: Colors.white),
                        ),
                        MenuAnchor(
                          builder: (context, controller, child) {
                            return IconButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadiusGeometry.circular(10),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Color.fromRGBO(33, 52, 72, 1),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                              ),
                              icon: const Icon(Icons.filter_alt),
                              onPressed: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                            );
                          },
                          menuChildren: [
                            MenuItemButton(
                              onPressed: () {
                                applySort(ReportSortType.none);
                              },
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [Text('None', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))],
                                ),
                              ),
                            ),
                            MenuItemButton(
                              onPressed: () {
                                if (currentSort == ReportSortType.profitAsc) {
                                  applySort(ReportSortType.profitDesc);
                                } else {
                                  applySort(ReportSortType.profitAsc);
                                }
                              },
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Profit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    if (currentSort == ReportSortType.profitAsc ||
                                        currentSort == ReportSortType.profitDesc)
                                      ImageIcon(
                                        currentSort == ReportSortType.profitAsc
                                            ? AssetImage('assets/ascending.png')
                                            : AssetImage('assets/descending.png'),
                                        size: 20,
                                      ),
                                    // Icon(
                                    //   currentSort == ReportSortType.profitAsc ? Icons.north : Icons.south,
                                    //   size: 20,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            MenuItemButton(
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    if (currentSort == ReportSortType.typeAsc || currentSort == ReportSortType.typeDesc)
                                      ImageIcon(
                                        currentSort == ReportSortType.typeAsc
                                            ? AssetImage('assets/ascending.png')
                                            : AssetImage('assets/descending.png'),
                                        size: 20,
                                      ),
                                    // Icon(currentSort == ReportSortType.typeAsc ? Icons.north : Icons.south, size: 20),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (currentSort == ReportSortType.typeAsc) {
                                  applySort(ReportSortType.typeDesc);
                                } else {
                                  applySort(ReportSortType.typeAsc);
                                }
                              },
                            ),
                            MenuItemButton(
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Volume', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    if (currentSort == ReportSortType.volumeAsc ||
                                        currentSort == ReportSortType.volumeDesc)
                                      ImageIcon(
                                        currentSort == ReportSortType.volumeAsc
                                            ? AssetImage('assets/ascending.png')
                                            : AssetImage('assets/descending.png'),
                                        size: 20,
                                      ),
                                    // Icon(
                                    //   currentSort == ReportSortType.volumeAsc ? Icons.north : Icons.south,
                                    //   size: 20,
                                    // ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (currentSort == ReportSortType.volumeAsc) {
                                  applySort(ReportSortType.volumeDesc);
                                } else {
                                  applySort(ReportSortType.volumeAsc);
                                }
                              },
                            ),
                            MenuItemButton(
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Open Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    if (currentSort == ReportSortType.openTimeAsc ||
                                        currentSort == ReportSortType.openTimeDesc)
                                      ImageIcon(
                                        currentSort == ReportSortType.openTimeAsc
                                            ? AssetImage('assets/ascending.png')
                                            : AssetImage('assets/descending.png'),
                                        size: 20,
                                      ),
                                    // Icon(
                                    //   currentSort == ReportSortType.openTimeAsc ? Icons.north : Icons.south,
                                    //   size: 20,
                                    // ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (currentSort == ReportSortType.openTimeAsc) {
                                  applySort(ReportSortType.openTimeDesc);
                                } else {
                                  applySort(ReportSortType.openTimeAsc);
                                }
                              },
                            ),
                            MenuItemButton(
                              child: SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Close Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    if (currentSort == ReportSortType.closeTimeAsc ||
                                        currentSort == ReportSortType.closeTimeDesc)
                                      ImageIcon(
                                        currentSort == ReportSortType.closeTimeAsc
                                            ? AssetImage('assets/ascending.png')
                                            : AssetImage('assets/descending.png'),
                                        size: 20,
                                      ),
                                    // Icon(
                                    //   currentSort == ReportSortType.closeTimeAsc ? Icons.north : Icons.south,
                                    //   size: 20,
                                    // ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (currentSort == ReportSortType.closeTimeAsc) {
                                  applySort(ReportSortType.closeTimeDesc);
                                } else {
                                  applySort(ReportSortType.closeTimeAsc);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.shade800)),
                            ),
                            child: Column(
                              children: [
                                buildSummaryRow("Profit", totalProfit),
                                buildSummaryRow("Swap", totalSwap),
                                buildSummaryRow("Commission", totalCommission),
                                buildSummaryRow("Deposit", totalDeposit),
                                // buildSummaryRow("Withdraw", totalWithdraw),
                                buildSummaryRow("Balance", totalBalance),
                              ],
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredReportList.length,
                              itemBuilder: (context, index) {
                                final item = filteredReportList[index];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      expandedIndex = expandedIndex == index ? -1 : index;
                                    });
                                  },

                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),

                                    decoration: BoxDecoration(
                                      color: expandedIndex == index
                                          ? const Color.fromRGBO(220, 240, 250, 1)
                                          : Colors.transparent,

                                      border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// TOP ROW
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  item.dealType == "TRADE" ? item.symbol : item.dealType,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(width: 5),

                                                if (item.dealType == "TRADE") ...[
                                                  typeWidget(item.actionType),

                                                  const SizedBox(width: 5),

                                                  Text(item.volume, style: const TextStyle(color: Colors.black)),
                                                ],
                                              ],
                                            ),

                                            Text(
                                              DateFormat('dd.MM.yyyy HH:mm:ss').format(DateTime.parse(item.closedAt!)),
                                              // item.closedAt!,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 5),

                                        /// PRICE ROW
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(item.openPrice.toStringAsFixed(2)),

                                                const Icon(Icons.arrow_right_alt),

                                                Text(item.closePrice.toStringAsFixed(2)),
                                              ],
                                            ),

                                            Text(
                                              item.profit.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: item.profit >= 0 ? Colors.blue : Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// EXPANDED DETAILS
                                        if (expandedIndex == index) ...[
                                          const SizedBox(height: 12),

                                          Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "#${item.positionId}",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Open- "),
                                                          Text(
                                                            DateFormat(
                                                              'dd.MM.yyyy HH:mm:ss',
                                                            ).format(DateTime.parse(item.openedAt!)),
                                                            // item.openedAt!,
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Swap- "),
                                                          Text(
                                                            item.swap.toString(),
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Commission- "),
                                                          Text(
                                                            item.commission.toString(),
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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

Widget buildSummaryRow(String title, double value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title:", style: const TextStyle(color: Colors.black, fontSize: 16)),

        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget buildExtraRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),

        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
