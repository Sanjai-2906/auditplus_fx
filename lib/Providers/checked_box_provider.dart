import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/value_provider.dart';

import '../api_methods/api_methods.dart';

class CheckedBoxProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Map<String, Map<String, bool>> mmValuesPerSymbol = {};
  Map<String, Map<String, bool>> am1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am2ValuesPerSymbol = {};

  static Map<String, bool> _mmEmptyValues() => {
    'LongTcChecked': false,
    'LongTtChecked': false,
    'LongNeoChecked': false,
    'LongM1MfChecked': false,
    'LongM1TrendChecked': false,
    'LongM1ReversalChecked': false,
    'LongConfChecked': false,
    'LongDivergenceChecked': false,
    'LongRevPlusChecked': false,
    'LongCatcherChecked': false,
    'LongM2MfChecked': false,
    'LongM2HwChecked': false,
    'LongM2HwThChecked': false,
    // 'LongM2TrendChecked': false,
    // 'LongM2ReversalChecked': false,
    'LongGretTcChecked': false,
    'LongSigCrTtChecked': false,
    'ShortTcChecked': false,
    'ShortTtChecked': false,
    'ShortNeoChecked': false,
    'ShortM1MfChecked': false,
    'ShortM1TrendChecked': false,
    'ShortM1ReversalChecked': false,
    'ShortConfChecked': false,
    'ShortDivergenceChecked': false,
    'ShortRevChecked': false,
    'ShortCatcherChecked': false,
    'ShortM2MfChecked': false,
    // 'ShortM2TrendChecked': false,
    // 'ShortM2ReversalChecked': false,
    'ShortM2HwChecked': false,
    'ShortM2HwThChecked': false,
    'ShortGretTcChecked': false,
    'ShortSigCrTtChecked': false,
    'MM1ReversalPlusPlusChecked': false,
    'MM1ReversalPlusChecked': false,
    'MM1ReversalChecked': false,
    'MM1SignalExitChecked': false,
    'MM1TcChangeChecked': false,
    'MM1HwChecked': false,
    'MM1MfChecked': false,
    'MM1HWTHChecked': false,
    'MM2ReversalPlusPlusChecked': false,
    'MM2ReversalPlusChecked': false,
    'MM2ReversalChecked': false,
    'MM2SignalExitChecked': false,
    'MM2TcChangeChecked': false,
    'MM2HwChecked': false,
    'MM2MfChecked': false,
    'MM2HWTHChecked': false,
  };

  static Map<String, bool> _am1EmptyValues() => {
    'AM1ReversalPlusPlusChecked': false,
    'AM1ReversalPlusChecked': false,
    'AM1ReversalChecked': false,
    'AM1SignalExitChecked': false,
    'AM1TcChangeChecked': false,
    'AM1HwChecked': false,
    'AM1MfChecked': false,
    'AM1HWTHChecked': false,
  };

  static Map<String, bool> _am2EmptyValues() => {
    'AM2ReversalPlusPlusChecked': false,
    'AM2ReversalPlusChecked': false,
    'AM2ReversalChecked': false,
    'AM2SignalExitChecked': false,
    'AM2TcChangeChecked': false,
    'AM2HwChecked': false,
    'AM2MfChecked': false,
    'AM2HWTHChecked': false,
  };

  //Generic getter
  Map<String, bool> getValues(String method, String symbol) {
    if (method == "MM") {
      return mmValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM1") {
      return am1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM2") {
      return am2ValuesPerSymbol[symbol] ?? {};
    }
    throw Exception("Invalid method");
  }

  bool getValue(String symbol, String method, String field) {
    final map = getValues(method, symbol);
    return map[field] ?? false;
  }

  bool isLongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['LongTcChecked'] ?? false) &&
        (v['LongTtChecked'] ?? false) &&
        (v['LongNeoChecked'] ?? false) &&
        (v['LongConfChecked'] ?? false);
  }

  bool isShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['ShortTcChecked'] ?? false) &&
        (v['ShortTtChecked'] ?? false) &&
        (v['ShortNeoChecked'] ?? false) &&
        (v['ShortConfChecked'] ?? false);
  }

  bool isM1LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return ((isLongAllChecked(symbol) && (v['LongM1MfChecked'] ?? false) && (v['LongM1TrendChecked'] ?? false)) ||
        (isLongAllChecked(symbol)) &&
            !(v['LongM1MfChecked'] ?? false) &&
            (v['LongM1ReversalChecked'] ?? false) &&
            (v['LongM1TrendChecked'] ?? false));
  }

  bool isM1ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return ((isShortAllChecked(symbol) && (v['ShortM1MfChecked'] ?? false) && (v['ShortM1TrendChecked'] ?? false)) ||
        (isShortAllChecked(symbol) &&
            !(v['ShortM1MfChecked'] ?? false) &&
            (v['ShortM1ReversalChecked'] ?? false) &&
            (v['ShortM1TrendChecked'] ?? false)));
  }

  bool isM2LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['LongDivergenceChecked'] ?? false) || (v['LongRevPlusChecked'] ?? false)) &&
        (v['LongCatcherChecked'] ?? false) &&
        ((v['LongM2MfChecked'] ?? false) || (v['LongM2HwChecked'] ?? false) || (v['LongHwThChecked'] ?? false)));
    // &&(v['LongM2TrendChecked'] ?? false))
    // ||
    // (((v['LongDivergenceChecked'] ?? false) || (v['LongRevPlusChecked'] ?? false)) &&
    //     (v['LongCatcherChecked'] ?? false) &&
    //     !(v['LongM2MfChecked'] ?? false));
    // &&(v['LongM2ReversalChecked'] ?? false) &&
    // (v['LongM2TrendChecked'] ?? false));
  }

  bool isM2ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['ShortDivergenceChecked'] ?? false) || (v['ShortRevChecked'] ?? false)) &&
        (v['ShortCatcherChecked'] ?? false) &&
        ((v['ShortM2MfChecked'] ?? false) || (v['ShortM2HwChecked'] ?? false) || (v['ShortM2HwThChecked'] ?? false)));
    // &&(v['ShortM2TrendChecked'] ?? false)) ||
    // (((v['ShortDivergenceChecked'] ?? false) || (v['ShortRevChecked'] ?? false)) &&
    //     (v['ShortCatcherChecked'] ?? false) &&
    //     !(v['ShortM2MfChecked'] ?? false) &&
    //     (v['ShortM2ReversalChecked'] ?? false) &&
    //     (v['ShortM2TrendChecked'] ?? false));
  }

  Future<void> loadFromApi(String symbol, String section) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getSymbolSetting(userId: "1", symbol: symbol, section: section);

      if (section == 'MM') {
        mmValuesPerSymbol[symbol] = {..._mmEmptyValues(), ...result};
      }
      if (section == 'AM1') {
        am1ValuesPerSymbol[symbol] = {..._am1EmptyValues(), ...result};
      }
      if (section == 'AM2') {
        am2ValuesPerSymbol[symbol] = {..._am2EmptyValues(), ...result};
      }
    } catch (e) {
      mmValuesPerSymbol.clear();
      am1ValuesPerSymbol.clear();
      am2ValuesPerSymbol.clear();
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeValue(String symbol, String method, String field, BuildContext context) {
    if (method == "MM1" || method == "MM2" || method == "MM") {
      mmValuesPerSymbol[symbol]![field] = !(mmValuesPerSymbol[symbol]![field] ?? false);

      if (field.startsWith('Long')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Long', 'Short')] = false;
      }
      if (field.startsWith('Short')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Short', 'Long')] = false;
      }
      symbolSetting(
        userId: "1",
        symbol: symbol,
        section: "MM", // MM1 / MM2
        checkedValues: mmValuesPerSymbol[symbol]!,
      );
    }
    if (method == 'AM1') {
      am1ValuesPerSymbol[symbol] ??= _am1EmptyValues();
      am1ValuesPerSymbol[symbol]![field] = !(am1ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am1ValuesPerSymbol[symbol]!);
    }

    if (method == 'AM2') {
      am2ValuesPerSymbol[symbol] ??= _am2EmptyValues();
      am2ValuesPerSymbol[symbol]![field] = !(am2ValuesPerSymbol[symbol]![field] ?? false);

      symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: am2ValuesPerSymbol[symbol]!);
    }
    notifyListeners();
    if (field == 'MM1ReversalPlusPlusChecked' ||
        field == 'MM1ReversalPlusChecked' ||
        field == 'MM1ReversalChecked' ||
        field == 'MM1SignalExitChecked' ||
        field == 'MM1TcChangeChecked' ||
        field == 'MM1HwChecked' ||
        field == 'MM1HWTHChecked' ||
        field == 'MM1MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'MM2ReversalPlusPlusChecked' ||
        field == 'MM2ReversalPlusChecked' ||
        field == 'MM2ReversalChecked' ||
        field == 'MM2SignalExitChecked' ||
        field == 'MM2TcChangeChecked' ||
        field == 'MM2HwChecked' ||
        field == 'MM2HWTHChecked' ||
        field == 'MM2MfChecked') {
      final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'AM1ReversalPlusPlusChecked' ||
        field == 'AM1ReversalPlusChecked' ||
        field == 'AM1ReversalChecked' ||
        field == 'AM1SignalExitChecked' ||
        field == 'AM1TcChangeChecked' ||
        field == 'AM1HwChecked' ||
        field == 'AM1HWTHChecked' ||
        field == 'AM1MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
    } else if (field == 'AM2ReversalPlusPlusChecked' ||
        field == 'AM2ReversalPlusChecked' ||
        field == 'AM2ReversalChecked' ||
        field == 'AM2SignalExitChecked' ||
        field == 'AM2TcChangeChecked' ||
        field == 'AM2HwChecked' ||
        field == 'AM2HWTHChecked' ||
        field == 'AM2MfChecked') {
      final currentSymbol = symbol;
      updateAutoTradeFlags(currentSymbol, method, context);
      // updateTradeFlags(crntMod, context);
    } else {
      return;
    }
  }

  void clearState(String method) {
    if (method == 'MM1' || method == 'MM2' || method == 'MM') {
      mmValuesPerSymbol.clear();
    }
    if (method == 'AM1') {
      am1ValuesPerSymbol.clear();
    }
    if (method == 'AM2') {
      am2ValuesPerSymbol.clear();
    }
    notifyListeners();
  }
}
