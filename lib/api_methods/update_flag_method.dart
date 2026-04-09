import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/providers.dart';
import '../models/models.dart';
import 'contants.dart';

Future<void> updateTradeFlags(CurrentOpenModel mod, BuildContext context) async {
  final token = Provider.of<MytokenProvider>(context, listen: false).token;
  // final symbol = Provider.of<ValueProvider>(context, listen: false).selectedValue;
  final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;

  if (symbol == null) return;

  final checked = Provider.of<CheckedBoxProvider>(context, listen: false);
  final valueProv = Provider.of<ValueProvider>(context, listen: false);

  final openTrade = valueProv.getOpenBySymbol(symbol);
  if (openTrade == null) return;

  late bool reversalPlusPlus;
  late bool reversalPlus;
  late bool reversal;
  late bool signal;
  late bool tc;
  late bool hw;
  late bool hwTh;
  late bool mf;

  if (mod.method == 'MM1') {
    // reversalPlusPlus = checked.isMM1ReversalPlusPlusChecked;
    reversalPlusPlus = checked.getValue(symbol, "MM", "MM1ReversalPlusPlusChecked");
    // reversalPlus = checked.isMM1ReversalPlusChecked;
    reversalPlus = checked.getValue(symbol, "MM", "MM1ReversalPlusChecked");
    // reversal = checked.isMM1ReversalChecked;
    reversal = checked.getValue(symbol, "MM", "MM1ReversalChecked");
    // signal = checked.isMM1SignalExitChecked;
    signal = checked.getValue(symbol, "MM", "MM1SignalExitChecked");
    // tc = checked.isMM1TcChangeChecked;
    tc = checked.getValue(symbol, "MM", "MM1TcChangeChecked");
    // hw = checked.isMM1HwChecked;
    hw = checked.getValue(symbol, "MM", "MM1HwChecked");
    // hwTh = checked.isMM1HWTHChecked;
    hwTh = checked.getValue(symbol, "MM", "MM1HWTHChecked");
    // mf = checked.isMM1MfChecked;
    mf = checked.getValue(symbol, "MM", "MM1MfChecked");
  } else if (mod.method == 'MM2') {
    // reversalPlusPlus = checked.isMM2ReversalPlusPlusChecked;
    reversalPlusPlus = checked.getValue(symbol, "MM", "MM2ReversalPlusPlusChecked");
    // reversalPlus = checked.isMM2ReversalPlusChecked;
    reversalPlus = checked.getValue(symbol, "MM", "MM2ReversalPlusChecked");
    // reversal = checked.isMM2ReversalChecked;
    reversal = checked.getValue(symbol, "MM", "MM2ReversalChecked");
    // signal = checked.isMM2SignalExitChecked;
    signal = checked.getValue(symbol, "MM", "MM2SignalExitChecked");
    // tc = checked.isMM2TcChangeChecked;
    tc = checked.getValue(symbol, "MM", "MM2TcChangeChecked");
    // hw = checked.isMM2HwChecked;
    hw = checked.getValue(symbol, "MM", "MM2HwChecked");
    // hwTh = checked.isMM2HWTHChecked;
    hwTh = checked.getValue(symbol, "MM", "MM2HWTHChecked");
    // mf = checked.isMM2MfChecked;
    mf = checked.getValue(symbol, "MM", "MM2MfChecked");
  }

  final data = {
    'symbol': symbol,
    'method': mod.method,
    'reversalPlusPlus': reversalPlusPlus,
    'reversalPlus': reversalPlus,
    'reversal': reversal,
    'signalExit': signal,
    'tcChange': tc,
    'hyperWave': hw,
    'hyperWaveThreshold': hwTh,
    'moneyFlow': mf,
  };

  final dio = Dio(
    BaseOptions(connectTimeout: const Duration(seconds: 60), receiveTimeout: const Duration(seconds: 60)),
  );
  await dio.post(
    '$url/update-flags',
    data: data,
    options: Options(headers: {'auth-token': token}),
  );

  // update local cache
  valueProv.updateFlags(symbol, reversalPlusPlus, reversalPlus, reversal, signal, tc, hw, hwTh);
}
