import 'package:auditplus_fx/pages/report_screen.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:searchfield/searchfield.dart';
// import 'package:auditplus_fx/Providers/value_provider.dart';
// import '../api_methods/api_methods.dart';
import '../models/models.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<ActiveSymbolModel> liveSymbols = [];
  List<TradeHistoryModel> tradeHistory = [];
  String? startDate;
  String? endDate;

  Map<String, List<TradeHistoryModel>> groupTradeHistory() {
    Map<String, List<TradeHistoryModel>> grouped = {};

    for (var item in tradeHistory) {
      if (!grouped.containsKey(item.symbol)) {
        grouped[item.symbol] = [];
      }
      grouped[item.symbol]!.add(item);
    }

    return grouped;
  }

  Map<String, List<ActiveSymbolModel>> groupLiveSymbols() {
    Map<String, List<ActiveSymbolModel>> grouped = {};

    for (var item in liveSymbols) {
      if (!grouped.containsKey(item.symbol)) {
        grouped[item.symbol] = [];
      }
      grouped[item.symbol]!.add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.0,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.only(top: 10),
            child: Text('Auditplus Fx', style: TextStyle(color: Colors.black, fontSize: 24)),
          ),
        ),

        // ExpansionTile(
        //   onExpansionChanged: (value) async {
        //     if (!value) return;
        //     final data = await fetchTradeHistory();
        //     if (!mounted) return;
        //     setState(() {
        //       tradeHistory = data;
        //     });
        //   },
        //   leading: const Icon(Icons.history),
        //   title: const Text('Today History'),
        //   children: [
        //     ...groupTradeHistory().entries.map((entry) {
        //       final symbol = entry.key;
        //       final methods = entry.value;
        //       num totalProfit = methods.fold(0, (sum, item) => sum + item.profit);

        //       return ExpansionTile(
        //         title: Text(symbol),
        //         trailing: Text(
        //           totalProfit.toStringAsFixed(5),
        //           style: TextStyle(color: totalProfit > 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
        //         ),
        //         children: methods.map((m) {
        //           return ListTile(
        //             title: Text(m.method),
        //             trailing: Text(
        //               m.profit.toStringAsFixed(6),
        //               style: TextStyle(color: m.profit > 0 ? Colors.green : Colors.red),
        //             ),
        //           );
        //         }).toList(),
        //       );
        //     }),
        //   ],
        // ),
        // ExpansionTile(
        //   onExpansionChanged: (value) async {
        //     if (!value) return;
        //     final data = await fetchLiveSymbols();
        //     if (!mounted) return;
        //     setState(() {
        //       liveSymbols = data;
        //     });
        //   },
        //   leading: const Icon(Icons.check_circle, color: Colors.green),
        //   title: const Text('Live Symbol'),
        //   children: [
        //     ...groupLiveSymbols().entries.map((entry) {
        //       final symbol = entry.key;
        //       final methods = entry.value;

        //       num totalProfit = methods.fold(0, (sum, item) => sum + item.profit);

        //       return ExpansionTile(
        //         title: Text(symbol),
        //         trailing: Text(
        //           totalProfit.toStringAsFixed(6),
        //           overflow: TextOverflow.ellipsis,
        //           style: TextStyle(color: totalProfit > 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
        //         ),
        //         children: methods.map((m) {
        //           return ListTile(
        //             title: Text(m.method),
        //             trailing: Text(
        //               m.profit.toStringAsFixed(6),
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(color: m.profit > 0 ? Colors.green : Colors.red),
        //             ),
        //             onTap: () {
        //               SearchFieldListItem<String> val = SearchFieldListItem<String>(m.symbol, value: m.symbol);
        //               Provider.of<ValueProvider>(context, listen: false).setSelectedItem(val, context);
        //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${m.symbol} clicked')));
        //               Navigator.pop(context);
        //             },
        //           );
        //         }).toList(),
        //       );
        //     }),
        //   ],
        // ),
        ListTile(
          title: Text("Report"),
          leading: Icon(Icons.table_view),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen())),
        ),
      ],
    );
  }
}
