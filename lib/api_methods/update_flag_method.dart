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
  bool tc = true;
  late bool hw;
  late bool hwTh;
  late bool mf;
  late bool tcTt;

  final method = mod.method;
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
    'method': mod.method,
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
