import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/providers.dart';
import 'contants.dart';

Future<void> updateAutoTradeFlags(String symbol, String method, BuildContext context) async {
  final token = Provider.of<MytokenProvider>(context, listen: false).token;
  final checked = Provider.of<CheckedBoxProvider>(context, listen: false);

  late bool reversalPlusPlus;
  late bool reversalPlus;
  late bool reversal;
  late bool signal;
  late bool tc;
  late bool hw;
  late bool hwTh;
  late bool mf;
  if (method == 'AM1') {
    // reversalPlusPlus = checked.getAutoValue(symbol, method, 'AM1ReversalPlusPlusChecked');
    reversalPlusPlus = checked.getValue(symbol, method, 'AM1ReversalPlusPlusChecked');
    // reversalPlus = checked.getAutoValue(symbol, method, 'AM1ReversalPlusChecked');
    reversalPlus = checked.getValue(symbol, method, 'AM1ReversalPlusChecked');
    // reversal = checked.getAutoValue(symbol, method, 'AM1ReversalChecked');
    reversal = checked.getValue(symbol, method, 'AM1ReversalChecked');
    // signal = checked.getAutoValue(symbol, method, 'AM1SignalExitChecked');
    signal = checked.getValue(symbol, method, 'AM1SignalExitChecked');
    // tc = checked.getAutoValue(symbol, method, 'AM1TcChangeChecked');
    tc = checked.getValue(symbol, method, 'AM1TcChangeChecked');
    // hw = checked.getAutoValue(symbol, method, 'AM1HwChecked');
    hw = checked.getValue(symbol, method, 'AM1HwChecked');
    // hwTh = checked.getAutoValue(symbol, method, 'AM1HWTHChecked');
    hwTh = checked.getValue(symbol, method, 'AM1HWTHChecked');
    // mf = checked.getAutoValue(symbol, method, 'AM1MfChecked');
    mf = checked.getValue(symbol, method, 'AM1MfChecked');
  } else if (method == 'AM2') {
    // reversalPlusPlus = checked.getAutoValue(symbol, method, 'AM2ReversalPlusPlusChecked');
    reversalPlusPlus = checked.getValue(symbol, method, 'AM2ReversalPlusPlusChecked');
    // reversalPlus = checked.getAutoValue(symbol, method, 'AM2ReversalPlusChecked');
    reversalPlus = checked.getValue(symbol, method, 'AM2ReversalPlusChecked');
    // reversal = checked.getAutoValue(symbol, method, 'AM2ReversalChecked');
    reversal = checked.getValue(symbol, method, 'AM2ReversalChecked');
    // signal = checked.getAutoValue(symbol, method, 'AM2SignalExitChecked');
    signal = checked.getValue(symbol, method, 'AM2SignalExitChecked');
    // tc = checked.getAutoValue(symbol, method, 'AM2TcChangeChecked');
    tc = checked.getValue(symbol, method, 'AM2TcChangeChecked');
    // hw = checked.getAutoValue(symbol, method, 'AM2HwChecked');
    hw = checked.getValue(symbol, method, 'AM2HwChecked');
    // hwTh = checked.getAutoValue(symbol, method, 'AM2HWTHChecked');
    hwTh = checked.getValue(symbol, method, 'AM2HWTHChecked');
    // mf = checked.getAutoValue(symbol, method, 'AM2MfChecked');
    mf = checked.getValue(symbol, method, 'AM2MfChecked');
  }
  final data = {
    'symbol': symbol,
    'method': method,
    'reversalPlusPlus': reversalPlusPlus,
    'reversalPlus': reversalPlus,
    'reversal': reversal,
    'signalExit': signal,
    'tcChange': tc,
    'hyperWave': hw,
    'hyperWaveThreshold': hwTh,
    'moneyFlow': mf,
  };
  print(data);

  final dio = Dio();
  await dio.post(
    '$url/update-flags',
    data: data,
    options: Options(headers: {'auth-token': token}),
  );
}
