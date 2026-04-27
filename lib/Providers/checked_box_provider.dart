// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/value_provider.dart';

import '../api_methods/api_methods.dart';

class CheckedBoxProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Map<String, Map<String, bool>> mmValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm2ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm3ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm4ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am2ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am3ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am4ValuesPerSymbol = {};

  static Map<String, bool> _mmEmptyValues() => {
    'LongTcChecked': false,
    'LongTtChecked': false,
    'LongNeoChecked': false,
    'LongSignalChecked': false,
    'LongSignalExitChecked': false,
    'LongMfChecked': false,
    'LongHwChecked': false,
    'LongReversalChecked': false,
    'LongReversalPlusChecked': false,
    'LongDivergenceChecked': false,
    'ShortTcChecked': false,
    'ShortTtChecked': false,
    'ShortNeoChecked': false,
    'ShortSignalChecked': false,
    'ShortSignalExitChecked': false,
    'ShortMfChecked': false,
    'ShortHwChecked': false,
    'ShortReversalChecked': false,
    'ShortReversalPlusChecked': false,
    'ShortDivergenceChecked': false,
  };

  static Map<String, bool> _mm1EmptyValues() => {
    'MM1ReversalPlusPlusChecked': false,
    'MM1ReversalPlusChecked': false,
    'MM1ReversalChecked': false,
    'MM1SignalExitChecked': false,
    // 'MM1TcChangeChecked': false,
    'MM1TcChangeChecked': true,
    'MM1HwChecked': false,
    'MM1MfChecked': false,
    'MM1HWTHChecked': false,
    'MM1TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _mm2EmptyValues() => {
    'MM2ReversalPlusPlusChecked': false,
    'MM2ReversalPlusChecked': false,
    'MM2ReversalChecked': false,
    'MM2SignalExitChecked': false,
    // 'MM2TcChangeChecked': false,
    'MM2TcChangeChecked': true,
    'MM2HwChecked': false,
    'MM2MfChecked': false,
    'MM2HWTHChecked': false,
    'MM3TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _mm3EmptyValues() => {
    'MM3ReversalPlusPlusChecked': false,
    'MM3ReversalPlusChecked': false,
    'MM3ReversalChecked': false,
    'MM3SignalExitChecked': false,
    // 'MM3TcChangeChecked': false,
    'MM3TcChangeChecked': true,
    'MM3HwChecked': false,
    'MM3MfChecked': false,
    'MM3HWTHChecked': false,
    'MM3TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _mm4EmptyValues() => {
    'MM4ReversalPlusPlusChecked': false,
    'MM4ReversalPlusChecked': false,
    'MM4ReversalChecked': false,
    'MM4SignalExitChecked': false,
    // 'MM4TcChangeChecked': false,
    'MM4TcChangeChecked': true,
    'MM4HwChecked': false,
    'MM4MfChecked': false,
    'MM4HWTHChecked': false,
    'MM4TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _am1EmptyValues() => {
    'AM1ReversalPlusPlusChecked': false,
    'AM1ReversalPlusChecked': false,
    'AM1ReversalChecked': false,
    'AM1SignalExitChecked': false,
    // 'AM1TcChangeChecked': false,
    'AM1TcChangeChecked': true,
    'AM1HwChecked': false,
    'AM1MfChecked': false,
    'AM1HWTHChecked': false,
    'AM1TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _am2EmptyValues() => {
    'AM2ReversalPlusPlusChecked': false,
    'AM2ReversalPlusChecked': false,
    'AM2ReversalChecked': false,
    'AM2SignalExitChecked': false,
    // 'AM2TcChangeChecked': false,
    'AM2TcChangeChecked': true,
    'AM2HwChecked': false,
    'AM2MfChecked': false,
    'AM2HWTHChecked': false,
    'AM2TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _am3EmptyValues() => {
    'AM3ReversalPlusPlusChecked': false,
    'AM3ReversalPlusChecked': false,
    'AM3ReversalChecked': false,
    'AM3SignalExitChecked': false,
    // 'AM3TcChangeChecked': false,
    'AM3TcChangeChecked': true,
    'AM3HwChecked': false,
    'AM3MfChecked': false,
    'AM3HWTHChecked': false,
    'AM3TCCROSSEDTTChecked': false,
  };

  static Map<String, bool> _am4EmptyValues() => {
    'AM4ReversalPlusPlusChecked': false,
    'AM4ReversalPlusChecked': false,
    'AM4ReversalChecked': false,
    'AM4SignalExitChecked': false,
    // 'AM4TcChangeChecked': false,
    'AM4TcChangeChecked': true,
    'AM4HwChecked': false,
    'AM4MfChecked': false,
    'AM4HWTHChecked': false,
    'AM4TCCROSSEDTTChecked': false,
  };

  //Generic getter
  Map<String, bool> getValues(String method, String symbol) {
    if (method == "MM") {
      return mmValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM1") {
      return mm1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM2") {
      return mm2ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM3") {
      return mm3ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM4") {
      return mm4ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM1") {
      return am1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM2") {
      return am2ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM3") {
      return am3ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM4") {
      return am4ValuesPerSymbol[symbol] ?? {};
    }
    throw Exception("Invalid method");
  }

  bool getValue(String symbol, String method, String field) {
    final map = getValues(method, symbol);
    if (method == "AM4" && field == "AM4MfChecked") {
      return true;
    }
    if (method == "AM4" && field == "AM4HwChecked") {
      return true;
    }
    return map[field] ?? false;
  }

  bool isLongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['LongTcChecked'] ?? false) && (v['LongTtChecked'] ?? false) && (v['LongNeoChecked'] ?? false);
  }

  bool isShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (v['ShortTcChecked'] ?? false) && (v['ShortTtChecked'] ?? false) && (v['ShortNeoChecked'] ?? false);
  }

  bool isM1LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);

    return (isLongAllChecked(symbol) && (v['LongMfChecked'] ?? false) && (v['LongSignalChecked'] ?? false));
  }

  bool isM1ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) && (v['ShortMfChecked'] ?? false) && (v['ShortSignalChecked'] ?? false));
  }

  bool isM2LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isLongAllChecked(symbol) &&
        (v['ShortMfChecked'] ?? false) &&
        (v['LongSignalChecked'] ?? false) &&
        ((v['LongReversalChecked'] ?? false) || (v['LongReversalPlusChecked'] ?? false)));
  }

  bool isM2ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) &&
        (v['LongMfChecked'] ?? false) &&
        (v['ShortSignalChecked'] ?? false) &&
        ((v['ShortReversalChecked'] ?? false) || (v['ShortReversalPlusChecked'] ?? false)));
  }

  bool isM3LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isLongAllChecked(symbol) && (v['ShortSignalExitChecked'] ?? false));
  }

  bool isM3ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (isShortAllChecked(symbol) && (v['LongSignalExitChecked'] ?? false));
  }

  bool isM4LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['LongReversalPlusChecked'] ?? false) || (v['LongDivergenceChecked'] ?? false)) &&
        (v['LongTcChecked'] ?? false) &&
        ((v['LongMfChecked'] ?? false) || (v['LongHwChecked'] ?? false)));
  }

  bool isM4ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (((v['ShortReversalPlusChecked'] ?? false) || (v['ShortDivergenceChecked'] ?? false)) &&
        (v['ShortTcChecked'] ?? false) &&
        ((v['ShortMfChecked'] ?? false) || (v['ShortHwChecked'] ?? false)));
  }

  Future<void> loadAll(String symbol) async {
    _isLoading = true;
    notifyListeners();

    try {
      final mm = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM');
      final mm1 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM1');
      final mm2 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM2');
      final mm3 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM3');
      final mm4 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM4');
      final am1 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM1');
      final am2 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM2');
      final am3 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM3');
      final am4 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM4');

      mmValuesPerSymbol[symbol] = {..._mmEmptyValues(), ...mm};
      mm1ValuesPerSymbol[symbol] = {..._mm1EmptyValues(), ...mm1};
      mm2ValuesPerSymbol[symbol] = {..._mm2EmptyValues(), ...mm2};
      mm3ValuesPerSymbol[symbol] = {..._mm3EmptyValues(), ...mm3};
      mm4ValuesPerSymbol[symbol] = {..._mm4EmptyValues(), ...mm4};
      am1ValuesPerSymbol[symbol] = {..._am1EmptyValues(), ...am1};
      am2ValuesPerSymbol[symbol] = {..._am2EmptyValues(), ...am2};
      am3ValuesPerSymbol[symbol] = {..._am3EmptyValues(), ...am3};
      am4ValuesPerSymbol[symbol] = {..._am4EmptyValues(), ...am4};
    } catch (e) {
      mmValuesPerSymbol.clear();
      am1ValuesPerSymbol.clear();
      am2ValuesPerSymbol.clear();
      am3ValuesPerSymbol.clear();
      am4ValuesPerSymbol.clear();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeValue(String symbol, String method, String field, BuildContext context) async {
    if (method == "MM") {
      mmValuesPerSymbol[symbol]![field] = !(mmValuesPerSymbol[symbol]![field] ?? false);

      if (field.startsWith('Long')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Long', 'Short')] = false;
      }
      if (field.startsWith('Short')) {
        mmValuesPerSymbol[symbol]![field.replaceFirst('Short', 'Long')] = false;
      }
    }
    if (method == 'MM1') {
      mm1ValuesPerSymbol[symbol] ??= _mm1EmptyValues();
      mm1ValuesPerSymbol[symbol]![field] = !(mm1ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM2') {
      mm2ValuesPerSymbol[symbol] ??= _mm2EmptyValues();
      mm2ValuesPerSymbol[symbol]![field] = !(mm2ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM3') {
      mm3ValuesPerSymbol[symbol] ??= _mm3EmptyValues();
      mm3ValuesPerSymbol[symbol]![field] = !(mm3ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM4') {
      mm4ValuesPerSymbol[symbol] ??= _mm4EmptyValues();
      mm4ValuesPerSymbol[symbol]![field] = !(mm4ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM1') {
      am1ValuesPerSymbol[symbol] ??= _am1EmptyValues();
      am1ValuesPerSymbol[symbol]![field] = !(am1ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM2') {
      am2ValuesPerSymbol[symbol] ??= _am2EmptyValues();
      am2ValuesPerSymbol[symbol]![field] = !(am2ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM3') {
      am3ValuesPerSymbol[symbol] ??= _am3EmptyValues();
      am3ValuesPerSymbol[symbol]![field] = !(am3ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM4') {
      am4ValuesPerSymbol[symbol] ??= _am4EmptyValues();
      am4ValuesPerSymbol[symbol]![field] = !(am4ValuesPerSymbol[symbol]![field] ?? false);
    }

    notifyListeners();

    await symbolSetting(userId: "1", symbol: symbol, section: method, checkedValues: _getMap(method, symbol));

    if (method.startsWith("MM")) {
      _updateMMTrade(method, context);
    } else if (method.startsWith("AM")) {
      await updateAutoTradeFlags(symbol, method, context);
    }
  }

  Map<String, bool> _getMap(String method, String symbol) {
    switch (method) {
      case 'MM':
        return mmValuesPerSymbol[symbol]!;
      case 'MM1':
        return mm1ValuesPerSymbol[symbol]!;
      case 'MM2':
        return mm2ValuesPerSymbol[symbol]!;
      case 'MM3':
        return mm3ValuesPerSymbol[symbol]!;
      case 'MM4':
        return mm4ValuesPerSymbol[symbol]!;
      case 'AM1':
        return am1ValuesPerSymbol[symbol]!;
      case 'AM2':
        return am2ValuesPerSymbol[symbol]!;
      case 'AM3':
        return am3ValuesPerSymbol[symbol]!;
      case 'AM4':
        return am4ValuesPerSymbol[symbol]!;
      default:
        return {};
    }
  }

  Future<void> _updateMMTrade(String method, BuildContext context) async {
    final symbol = Provider.of<ValueProvider>(context, listen: false).manualSelectedValue;
    final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;

    final match = crnt.where((el) => el.symbol == symbol && el.method == method);

    if (match.isEmpty) return;

    await updateTradeFlags(match.first, context);
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
