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
  bool tc = true;
  late bool hw;
  late bool hwTh;
  late bool mf;
  late bool tcTt;
  reversalPlusPlus = checked.getValue(symbol, method, "${method}ReversalPlusPlusChecked");
  reversalPlus = checked.getValue(symbol, method, "${method}ReversalPlusChecked");
  reversal = checked.getValue(symbol, method, "${method}ReversalChecked");
  signal = checked.getValue(symbol, method, "${method}SignalExitChecked");
  hw = checked.getValue(symbol, method, "${method}HwChecked");
  hwTh = checked.getValue(symbol, method, "${method}HWTHChecked");
  mf = checked.getValue(symbol, method, "${method}MfChecked");
  tcTt = checked.getValue(symbol, method, "${method}TCCROSSEDTTChecked");

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
    'tcCrossedTt': tcTt,
  };

  final dio = Dio();
  await dio.post(
    '$url/update-flags',
    data: data,
    options: Options(headers: {'auth-token': token}),
  );
}
