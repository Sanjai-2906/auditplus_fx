import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
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
  SearchFieldListItem<String> get allItem => widget.symbols.first;
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

    setState(() {
      menuSelectedItem = widget.symbols.first; // "ALL"
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: SearchField<String>(
                focusNode: _menuSymbolFocusNode,
                suggestions: widget.symbols,
                suggestionState: Suggestion.hidden,
                selectedValue: menuSelectedItem,
                searchInputDecoration: SearchInputDecoration(hintText: 'Symbols', border: OutlineInputBorder()),
                maxSuggestionsInViewPort: 4,
                onSearchTextChanged: (searchText) {
                  if (searchText.isEmpty) {
                    return List<SearchFieldListItem<String>>.from(widget.symbols);
                  }

                  setState(() {
                    menuSelectedItem = allItem;
                    menuSelectedValue = "ALL";
                  });

                  final query = searchText.toUpperCase();
                  return widget.symbols.where((s) {
                    final key = s.searchKey.toUpperCase();
                    final value = (s.value ?? '').toUpperCase();
                    return key.contains(query) || value.contains(query);
                  }).toList();
                },
                onSuggestionTap: (SearchFieldListItem<String> item) {
                  _menuSymbolFocusNode.unfocus();

                  setState(() {
                    menuSelectedItem = item;
                    menuSelectedValue = item.searchKey;
                  });
                },
                onSubmit: (item) {
                  final found = widget.symbols.firstWhere((s) => s.searchKey == item, orElse: () => allItem);

                  setState(() {
                    menuSelectedItem = found;
                    menuSelectedValue = found.searchKey;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            dateField(
              label: 'From Date *',
              controller: fromDateController,
              onTap: () {
                pickDate(isFromDate: true);
              },
            ),
            const SizedBox(height: 10),
            dateField(
              label: 'To Date *',
              controller: toDateController,
              onTap: () {
                pickDate(isFromDate: false);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700], foregroundColor: Colors.white),
              onPressed: () => getReport(context, menuSelectedValue, startDate!, endDate!),
              child: Text('Get Report', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
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
