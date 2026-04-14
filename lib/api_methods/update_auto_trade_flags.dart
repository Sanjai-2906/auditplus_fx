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
    reversalPlusPlus = checked.getValue(symbol, method, 'AM1ReversalPlusPlusChecked');
    reversalPlus = checked.getValue(symbol, method, 'AM1ReversalPlusChecked');
    reversal = checked.getValue(symbol, method, 'AM1ReversalChecked');
    signal = checked.getValue(symbol, method, 'AM1SignalExitChecked');
    tc = checked.getValue(symbol, method, 'AM1TcChangeChecked');
    hw = checked.getValue(symbol, method, 'AM1HwChecked');
    hwTh = checked.getValue(symbol, method, 'AM1HWTHChecked');
    mf = checked.getValue(symbol, method, 'AM1MfChecked');
  } else if (method == 'AM2') {
    reversalPlusPlus = checked.getValue(symbol, method, 'AM2ReversalPlusPlusChecked');
    reversalPlus = checked.getValue(symbol, method, 'AM2ReversalPlusChecked');
    reversal = checked.getValue(symbol, method, 'AM2ReversalChecked');
    signal = checked.getValue(symbol, method, 'AM2SignalExitChecked');
    tc = checked.getValue(symbol, method, 'AM2TcChangeChecked');
    hw = checked.getValue(symbol, method, 'AM2HwChecked');
    hwTh = checked.getValue(symbol, method, 'AM2HWTHChecked');
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

  final dio = Dio();
  await dio.post(
    '$url/update-flags',
    data: data,
    options: Options(headers: {'auth-token': token}),
  );
}
