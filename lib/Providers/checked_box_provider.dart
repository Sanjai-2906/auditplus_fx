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
  Map<String, Map<String, bool>> mm5ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm6ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm7ValuesPerSymbol = {};
  Map<String, Map<String, bool>> mm8ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am1ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am2ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am3ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am4ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am5ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am6ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am7ValuesPerSymbol = {};
  Map<String, Map<String, bool>> am8ValuesPerSymbol = {};

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
    'LongTcCrossTtChecked': false,
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
    'ShortTcCrossTtChecked': false,
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
    'MM1TtChecked': false,
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
    'MM2TCCROSSEDTTChecked': false,
    'MM2TtChecked': false,
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
    'MM3TtChecked': false,
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
    'MM4TtChecked': false,
  };

  static Map<String, bool> _mm5EmptyValues() => {
    'MM5ReversalPlusPlusChecked': false,
    'MM5ReversalPlusChecked': false,
    'MM5ReversalChecked': false,
    'MM5SignalExitChecked': false,
    // 'MM5TcChangeChecked': false,
    'MM5TcChangeChecked': true,
    'MM5HwChecked': false,
    'MM5MfChecked': false,
    'MM5HWTHChecked': false,
    'MM5TCCROSSEDTTChecked': false,
    'MM5TtChecked': false,
  };

  static Map<String, bool> _mm6EmptyValues() => {
    'MM6ReversalPlusPlusChecked': false,
    'MM6ReversalPlusChecked': false,
    'MM6ReversalChecked': false,
    'MM6SignalExitChecked': false,
    // 'MM6TcChangeChecked': false,
    'MM6TcChangeChecked': true,
    'MM6HwChecked': false,
    'MM6MfChecked': false,
    'MM6HWTHChecked': false,
    'MM6TCCROSSEDTTChecked': false,
    'MM6TtChecked': false,
  };

  static Map<String, bool> _mm7EmptyValues() => {
    'MM7ReversalPlusPlusChecked': false,
    'MM7ReversalPlusChecked': false,
    'MM7ReversalChecked': false,
    'MM7SignalExitChecked': false,
    // 'MM7TcChangeChecked': false,
    'MM7TcChangeChecked': true,
    'MM7HwChecked': false,
    'MM7MfChecked': false,
    'MM7HWTHChecked': false,
    'MM7TCCROSSEDTTChecked': false,
    'MM7TtChecked': false,
  };

  static Map<String, bool> _mm8EmptyValues() => {
    'MM8ReversalPlusPlusChecked': false,
    'MM8ReversalPlusChecked': false,
    'MM8ReversalChecked': false,
    'MM8SignalExitChecked': false,
    'MM8TcChangeChecked': false,
    'MM8HwChecked': false,
    'MM8MfChecked': false,
    'MM8HWTHChecked': false,
    'MM8TCCROSSEDTTChecked': false,
    // 'MM8TtChecked': false,
    'MM8TtChecked': true,
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
    'AM1TtChecked': false,
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
    'AM2TtChecked': false,
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
    'AM3TtChecked': false,
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
    'AM4TtChecked': false,
  };

  static Map<String, bool> _am5EmptyValues() => {
    'AM5ReversalPlusPlusChecked': false,
    'AM5ReversalPlusChecked': false,
    'AM5ReversalChecked': false,
    'AM5SignalExitChecked': false,
    // 'AM5TcChangeChecked': false,
    'AM5TcChangeChecked': true,
    'AM5HwChecked': false,
    'AM5MfChecked': false,
    'AM5HWTHChecked': false,
    'AM5TCCROSSEDTTChecked': false,
    'AM5TtChecked': false,
  };
  static Map<String, bool> _am6EmptyValues() => {
    'AM6ReversalPlusPlusChecked': false,
    'AM6ReversalPlusChecked': false,
    'AM6ReversalChecked': false,
    'AM6SignalExitChecked': false,
    // 'AM6TcChangeChecked': false,
    'AM6TcChangeChecked': true,
    'AM6HwChecked': false,
    'AM6MfChecked': false,
    'AM6HWTHChecked': false,
    'AM6TCCROSSEDTTChecked': false,
    'AM6TtChecked': false,
  };
  static Map<String, bool> _am7EmptyValues() => {
    'AM7ReversalPlusPlusChecked': false,
    'AM7ReversalPlusChecked': false,
    'AM7ReversalChecked': false,
    'AM7SignalExitChecked': false,
    // 'AM7TcChangeChecked': false,
    'AM7TcChangeChecked': true,
    'AM7HwChecked': false,
    'AM7MfChecked': false,
    'AM7HWTHChecked': false,
    'AM7TCCROSSEDTTChecked': false,
    'AM7TtChecked': false,
  };
  static Map<String, bool> _am8EmptyValues() => {
    'AM8ReversalPlusPlusChecked': false,
    'AM8ReversalPlusChecked': false,
    'AM8ReversalChecked': false,
    'AM8SignalExitChecked': false,
    'AM8TcChangeChecked': false,
    'AM8HwChecked': false,
    'AM8MfChecked': false,
    'AM8HWTHChecked': false,
    'AM8TCCROSSEDTTChecked': false,
    // 'AM8TtChecked': false,
    'AM8TtChecked': true,
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
    } else if (method == "MM5") {
      return mm5ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM6") {
      return mm6ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM7") {
      return mm7ValuesPerSymbol[symbol] ?? {};
    } else if (method == "MM8") {
      return mm8ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM1") {
      return am1ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM2") {
      return am2ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM3") {
      return am3ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM4") {
      return am4ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM5") {
      return am5ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM6") {
      return am6ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM7") {
      return am7ValuesPerSymbol[symbol] ?? {};
    } else if (method == "AM8") {
      return am8ValuesPerSymbol[symbol] ?? {};
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
    if (method == "AM5" && field == "AM5MfChecked") {
      return true;
    }
    if (method == "AM5" && field == "AM5HwChecked") {
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

    return ((isLongAllChecked(symbol) &&
            (v['LongMfChecked'] ?? false) &&
            (v['LongTcCrossTtChecked'] ?? false) &&
            (v['LongSignalChecked'] ?? false)) ||
        isLongAllChecked(symbol) &&
            (v['LongMfChecked'] ?? false) &&
            !(v['LongTcCrossTtChecked'] ?? false) &&
            ((v['LongReversalChecked'] ?? false) || (v['LongReversalPlusChecked'] ?? false)) &&
            (v['LongSignalChecked'] ?? false));
  }

  bool isM1ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return ((isShortAllChecked(symbol) &&
            (v['ShortMfChecked'] ?? false) &&
            (v['ShortTcCrossTtChecked'] ?? false) &&
            (v['ShortSignalChecked'] ?? false)) ||
        isShortAllChecked(symbol) &&
            (v['ShortMfChecked'] ?? false) &&
            !(v['ShortTcCrossTtChecked'] ?? false) &&
            ((v['ShortReversalChecked'] ?? false) || (v['ShortReversalPlusChecked'] ?? false)) &&
            (v['ShortSignalChecked'] ?? false));
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
    return ((v['ShortSignalExitChecked'] ?? false) &&
        (v['LongTcChecked'] ?? false) &&
        (v['LongSignalChecked'] ?? false));
  }

  bool isM4ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return ((v['LongSignalExitChecked'] ?? false)) &&
        (v['ShortTcChecked'] ?? false) &&
        (v['ShortSignalChecked'] ?? false);
  }

  bool isM5LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return ((v['LongReversalPlusChecked'] ?? false) || (v['LongDivergenceChecked'] ?? false)) &&
        (v['LongTcChecked'] ?? false) &&
        (v['LongSignalChecked'] ?? false);
  }

  bool isM5ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return ((v['ShortReversalPlusChecked'] ?? false) || (v['ShortDivergenceChecked'] ?? false)) &&
        (v['ShortTcChecked'] ?? false) &&
        (v['ShortSignalChecked'] ?? false);
  }

  bool isM6LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['LongTcChecked'] ?? false) &&
        (v['LongTtChecked'] ?? false) &&
        ((v['LongReversalPlusChecked'] ?? false) || (v['LongReversalChecked'] ?? false));
  }

  bool isM6ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['ShortTcChecked'] ?? false) &&
        (v['ShortTtChecked'] ?? false) &&
        ((v['ShortReversalPlusChecked'] ?? false) || (v['ShortReversalChecked'] ?? false));
  }

  bool isM7LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['LongTcChecked'] ?? false) &&
        (v['LongTtChecked'] ?? false) &&
        ((v['LongReversalPlusChecked'] ?? false) || (v['LongReversalChecked'] ?? false));
  }

  bool isM7ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['ShortTcChecked'] ?? false) &&
        (v['ShortTtChecked'] ?? false) &&
        ((v['ShortReversalPlusChecked'] ?? false) || (v['ShortReversalChecked'] ?? false));
  }

  bool isM8LongAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['ShortTcChecked'] ?? false) &&
        (v['LongTtChecked'] ?? false) &&
        ((v['LongReversalPlusChecked'] ?? false) || (v['LongReversalChecked'] ?? false)) &&
        (v['LongSignalExitChecked'] ?? false);
  }

  bool isM8ShortAllChecked(String symbol) {
    final v = getValues("MM", symbol);
    return (v['LongTcChecked'] ?? false) &&
        (v['ShortTtChecked'] ?? false) &&
        ((v['ShortReversalPlusChecked'] ?? false) || (v['ShortReversalChecked'] ?? false)) &&
        (v['ShortSignalExitChecked'] ?? false);
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
      final mm5 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM5');
      final mm6 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM6');
      final mm7 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM7');
      final mm8 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'MM8');
      final am1 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM1');
      final am2 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM2');
      final am3 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM3');
      final am4 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM4');
      final am5 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM5');
      final am6 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM6');
      final am7 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM7');
      final am8 = await getSymbolSetting(userId: "1", symbol: symbol, section: 'AM8');

      mmValuesPerSymbol[symbol] = {..._mmEmptyValues(), ...mm};
      mm1ValuesPerSymbol[symbol] = {..._mm1EmptyValues(), ...mm1};
      mm2ValuesPerSymbol[symbol] = {..._mm2EmptyValues(), ...mm2};
      mm3ValuesPerSymbol[symbol] = {..._mm3EmptyValues(), ...mm3};
      mm4ValuesPerSymbol[symbol] = {..._mm4EmptyValues(), ...mm4};
      mm5ValuesPerSymbol[symbol] = {..._mm5EmptyValues(), ...mm5};
      mm6ValuesPerSymbol[symbol] = {..._mm6EmptyValues(), ...mm6};
      mm7ValuesPerSymbol[symbol] = {..._mm7EmptyValues(), ...mm7};
      mm8ValuesPerSymbol[symbol] = {..._mm8EmptyValues(), ...mm8};
      am1ValuesPerSymbol[symbol] = {..._am1EmptyValues(), ...am1};
      am2ValuesPerSymbol[symbol] = {..._am2EmptyValues(), ...am2};
      am3ValuesPerSymbol[symbol] = {..._am3EmptyValues(), ...am3};
      am4ValuesPerSymbol[symbol] = {..._am4EmptyValues(), ...am4};
      am5ValuesPerSymbol[symbol] = {..._am5EmptyValues(), ...am5};
      am6ValuesPerSymbol[symbol] = {..._am6EmptyValues(), ...am6};
      am7ValuesPerSymbol[symbol] = {..._am7EmptyValues(), ...am7};
      am8ValuesPerSymbol[symbol] = {..._am8EmptyValues(), ...am8};
    } catch (e) {
      mmValuesPerSymbol.clear();
      am1ValuesPerSymbol.clear();
      am2ValuesPerSymbol.clear();
      am3ValuesPerSymbol.clear();
      am4ValuesPerSymbol.clear();
      am5ValuesPerSymbol.clear();
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
    } else if (method == 'MM5') {
      mm5ValuesPerSymbol[symbol] ??= _mm5EmptyValues();
      mm5ValuesPerSymbol[symbol]![field] = !(mm5ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM6') {
      mm6ValuesPerSymbol[symbol] ??= _mm6EmptyValues();
      mm6ValuesPerSymbol[symbol]![field] = !(mm6ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM7') {
      mm7ValuesPerSymbol[symbol] ??= _mm7EmptyValues();
      mm7ValuesPerSymbol[symbol]![field] = !(mm7ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'MM8') {
      mm8ValuesPerSymbol[symbol] ??= _mm8EmptyValues();
      mm8ValuesPerSymbol[symbol]![field] = !(mm8ValuesPerSymbol[symbol]![field] ?? false);
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
    } else if (method == 'AM5') {
      am5ValuesPerSymbol[symbol] ??= _am5EmptyValues();
      am5ValuesPerSymbol[symbol]![field] = !(am5ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM6') {
      am6ValuesPerSymbol[symbol] ??= _am6EmptyValues();
      am6ValuesPerSymbol[symbol]![field] = !(am6ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM7') {
      am7ValuesPerSymbol[symbol] ??= _am7EmptyValues();
      am7ValuesPerSymbol[symbol]![field] = !(am7ValuesPerSymbol[symbol]![field] ?? false);
    } else if (method == 'AM8') {
      am8ValuesPerSymbol[symbol] ??= _am8EmptyValues();
      am8ValuesPerSymbol[symbol]![field] = !(am8ValuesPerSymbol[symbol]![field] ?? false);
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
      case 'MM5':
        return mm5ValuesPerSymbol[symbol]!;
      case 'MM6':
        return mm6ValuesPerSymbol[symbol]!;
      case 'MM7':
        return mm7ValuesPerSymbol[symbol]!;
      case 'MM8':
        return mm8ValuesPerSymbol[symbol]!;
      case 'AM1':
        return am1ValuesPerSymbol[symbol]!;
      case 'AM2':
        return am2ValuesPerSymbol[symbol]!;
      case 'AM3':
        return am3ValuesPerSymbol[symbol]!;
      case 'AM4':
        return am4ValuesPerSymbol[symbol]!;
      case 'AM5':
        return am5ValuesPerSymbol[symbol]!;
      case 'AM6':
        return am6ValuesPerSymbol[symbol]!;
      case 'AM7':
        return am7ValuesPerSymbol[symbol]!;
      case 'AM8':
        return am8ValuesPerSymbol[symbol]!;
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

  // void clearState(String method) {
  //   if (method == 'MM1' || method == 'MM2' || method == 'MM') {
  //     mmValuesPerSymbol.clear();
  //   }
  //   if (method == 'AM1') {
  //     am1ValuesPerSymbol.clear();
  //   }
  //   if (method == 'AM2') {
  //     am2ValuesPerSymbol.clear();
  //   }
  //   notifyListeners();
  // }
}
