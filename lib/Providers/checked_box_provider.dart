import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auditplus_fx/Providers/value_provider.dart';

import '../api_methods/api_methods.dart';
// import '../models/models.dart';

class CheckedBoxProvider extends ChangeNotifier {
  String? _currentSymbol;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  // Map<String, bool> _values = _emptyValues();
  // ignore: prefer_final_fields
  Map<String, bool> _mmValues = _mmEmptyValues();
  // ignore: prefer_final_fields
  Map<String, bool> _am1Values = _am1EmptyValues();
  // ignore: prefer_final_fields
  Map<String, bool> _am2Values = _am2EmptyValues();

  // static Map<String, bool> _emptyValues() => {
  // 'LongTcChecked': false,
  //   'LongTtChecked': false,
  //   'LongNeoChecked': false,
  //   // 'LongHwoChecked': false,
  //   'LongM1MfChecked': false,
  //   'LongM1TrendChecked': false,
  //   'LongM1ReversalChecked': false,
  //   'LongConfChecked': false,
  //   'LongDivergenceChecked': false,
  //   'LongRevChecked': false,
  //   'LongCatcherChecked': false,
  //   // 'LongOscChecked': false,
  //   'LongM2MfChecked': false,
  //   'LongM2TrendChecked': false,
  //   'LongM2ReversalChecked': false,
  //   'LongGretTcChecked': false,
  //   'LongSigCrTtChecked': false,
  //   'ShortTcChecked': false,
  //   'ShortTtChecked': false,
  //   'ShortNeoChecked': false,
  //   // 'ShortHwoChecked': false,
  //   'ShortM1MfChecked': false,
  //   'ShortM1TrendChecked': false,
  //   'ShortM1ReversalChecked': false,
  //   'ShortConfChecked': false,
  //   'ShortDivergenceChecked': false,
  //   'ShortRevChecked': false,
  //   'ShortCatcherChecked': false,
  //   // 'ShortOscChecked': false,
  //   'ShortM2MfChecked': false,
  //   'ShortM2TrendChecked': false,
  //   'ShortM2ReversalChecked': false,
  //   'ShortGretTcChecked': false,
  //   'ShortSigCrTtChecked': false,
  //   'MM1ReversalPlusPlusChecked': false,
  //   'MM1ReversalPlusChecked': false,
  //   'MM1ReversalChecked': false,
  //   'MM1SignalExitChecked': false,
  //   'MM1TcChangeChecked': false,
  //   'MM1HwChecked': false,
  //   'MM1MfChecked': false,
  //   'MM1HWTHChecked': false,
  //   'AM1ReversalPlusPlusChecked': false,
  //   'AM1ReversalPlusChecked': false,
  //   'AM1ReversalChecked': false,
  //   'AM1SignalExitChecked': false,
  //   'AM1TcChangeChecked': false,
  //   'AM1HwChecked': false,
  //   'AM1MfChecked': false,
  //   'AM1HWTHChecked': false,
  //   'MM2ReversalPlusPlusChecked': false,
  //   'MM2ReversalPlusChecked': false,
  //   'MM2ReversalChecked': false,
  //   'MM2SignalExitChecked': false,
  //   'MM2TcChangeChecked': false,
  //   'MM2HwChecked': false,
  //   'MM2MfChecked': false,
  //   'MM2HWTHChecked': false,
  //   'AM2ReversalPlusPlusChecked': false,
  //   'AM2ReversalPlusChecked': false,
  //   'AM2ReversalChecked': false,
  //   'AM2SignalExitChecked': false,
  //   'AM2TcChangeChecked': false,
  //   'AM2HwChecked': false,
  //   'AM2MfChecked': false,
  //   'AM2HWTHChecked': false,
  //Auto Booking & Closing
  // 'AM1Checked': false,
  // 'AM2Checked': false,
  // 'AMChecked': false,
  // }
  static Map<String, bool> _mmEmptyValues() => {
    'LongTcChecked': false,
    'LongTtChecked': false,
    'LongNeoChecked': false,
    // 'LongHwoChecked': false,
    'LongM1MfChecked': false,
    'LongM1TrendChecked': false,
    'LongM1ReversalChecked': false,
    'LongConfChecked': false,
    'LongDivergenceChecked': false,
    'LongRevChecked': false,
    'LongCatcherChecked': false,
    // 'LongOscChecked': false,
    'LongM2MfChecked': false,
    'LongM2TrendChecked': false,
    'LongM2ReversalChecked': false,
    'LongGretTcChecked': false,
    'LongSigCrTtChecked': false,
    'ShortTcChecked': false,
    'ShortTtChecked': false,
    'ShortNeoChecked': false,
    // 'ShortHwoChecked': false,
    'ShortM1MfChecked': false,
    'ShortM1TrendChecked': false,
    'ShortM1ReversalChecked': false,
    'ShortConfChecked': false,
    'ShortDivergenceChecked': false,
    'ShortRevChecked': false,
    'ShortCatcherChecked': false,
    // 'ShortOscChecked': false,
    'ShortM2MfChecked': false,
    'ShortM2TrendChecked': false,
    'ShortM2ReversalChecked': false,
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
    //Auto Booking & Closing
    // 'AM1Checked': false,
    // 'AM2Checked': false,
    // 'AMChecked': false,
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

  bool get isLongTcChecked => _mmValues['LongTcChecked']!;
  bool get isLongTtChecked => _mmValues['LongTtChecked']!;
  bool get isLongNeoChecked => _mmValues['LongNeoChecked']!;
  // bool get isLongHwoChecked => _mmValues['LongHwoChecked']!;
  bool get isLongM1MfChecked => _mmValues['LongM1MfChecked']!;
  bool get isLongM1TrendChecked => _mmValues['LongM1TrendChecked']!;
  bool get isLongM1ReversalChecked => _mmValues['LongM1ReversalChecked']!;
  bool get isLongConfChecked => _mmValues['LongConfChecked']!;
  bool get isLongDivergenceChecked => _mmValues['LongDivergenceChecked']!;
  bool get isLongRevChecked => _mmValues['LongRevChecked']!;
  bool get isLongCatcherChecked => _mmValues['LongCatcherChecked']!;
  // bool get isLongOscChecked => _mmValues['LongOscChecked']!;
  bool get isLongM2MfChecked => _mmValues['LongM2MfChecked']!;
  bool get isLongM2TrendChecked => _mmValues['LongM2TrendChecked']!;
  bool get isLongM2ReversalChecked => _mmValues['LongM2ReversalChecked']!;
  bool get isLongGretTcChecked => _mmValues['LongGretTcChecked']!;
  bool get isLongSigCrTtChecked => _mmValues['LongSigCrTtChecked']!;

  bool get isShortTcChecked => _mmValues['ShortTcChecked']!;
  bool get isShortTtChecked => _mmValues['ShortTtChecked']!;
  bool get isShortNeoChecked => _mmValues['ShortNeoChecked']!;
  // bool get isShortHwoChecked => _mmValues['ShortHwoChecked']!;
  bool get isShortM1MfChecked => _mmValues['ShortM1MfChecked']!;
  bool get isShortM1TrendChecked => _mmValues['ShortM1TrendChecked']!;
  bool get isShortM1ReversalChecked => _mmValues['ShortM1ReversalChecked']!;
  bool get isShortConfChecked => _mmValues['ShortConfChecked']!;
  bool get isShortDivergenceChecked => _mmValues['ShortDivergenceChecked']!;
  bool get isShortRevChecked => _mmValues['ShortRevChecked']!;
  bool get isShortCatcherChecked => _mmValues['ShortCatcherChecked']!;
  // bool get isShortOscChecked => _mmValues['ShortOscChecked']!;
  bool get isShortM2MfChecked => _mmValues['ShortM2MfChecked']!;
  bool get isShortM2TrendChecked => _mmValues['ShortM2TrendChecked']!;
  bool get isShortM2ReversalChecked => _mmValues['ShortM2ReversalChecked']!;
  bool get isShortGretTcChecked => _mmValues['ShortGretTcChecked']!;
  bool get isShortSigCrTtChecked => _mmValues['ShortSigCrTtChecked']!;

  bool get isMM1ReversalPlusPlusChecked => _mmValues['MM1ReversalPlusPlusChecked']!;
  bool get isMM1ReversalPlusChecked => _mmValues['MM1ReversalPlusChecked']!;
  bool get isMM1ReversalChecked => _mmValues['MM1ReversalChecked']!;
  bool get isMM1SignalExitChecked => _mmValues['MM1SignalExitChecked']!;
  bool get isMM1TcChangeChecked => _mmValues['MM1TcChangeChecked']!;
  bool get isMM1HwChecked => _mmValues['MM1HwChecked']!;
  bool get isMM1MfChecked => _mmValues['MM1MfChecked']!;
  bool get isMM1HWTHChecked => _mmValues['MM1HWTHChecked']!;
  bool get isMM2ReversalPlusPlusChecked => _mmValues['MM2ReversalPlusPlusChecked']!;
  bool get isMM2ReversalPlusChecked => _mmValues['MM2ReversalPlusChecked']!;
  bool get isMM2ReversalChecked => _mmValues['MM2ReversalChecked']!;
  bool get isMM2SignalExitChecked => _mmValues['MM2SignalExitChecked']!;
  bool get isMM2TcChangeChecked => _mmValues['MM2TcChangeChecked']!;
  bool get isMM2HwChecked => _mmValues['MM2HwChecked']!;
  bool get isMM2MfChecked => _mmValues['MM2MfChecked']!;
  bool get isMM2HWTHChecked => _mmValues['MM2HWTHChecked']!;

  //Automatic values
  bool get isAM1ReversalPlusPlusChecked => _am1Values['AM1ReversalPlusPlusChecked']!;
  bool get isAM1ReversalPlusChecked => _am1Values['AM1ReversalPlusChecked']!;
  bool get isAM1ReversalChecked => _am1Values['AM1ReversalChecked']!;
  bool get isAM1SignalExitChecked => _am1Values['AM1SignalExitChecked']!;
  bool get isAM1TcChangeChecked => _am1Values['AM1TcChangeChecked']!;
  bool get isAM1HwChecked => _am1Values['AM1HwChecked']!;
  bool get isAM1MfChecked => _am1Values['AM1MfChecked']!;
  bool get isAM1HWTHChecked => _am1Values['AM1HWTHChecked']!;
  bool get isAM2ReversalPlusPlusChecked => _am2Values['AM2ReversalPlusPlusChecked']!;
  bool get isAM2ReversalPlusChecked => _am2Values['AM2ReversalPlusChecked']!;
  bool get isAM2ReversalChecked => _am2Values['AM2ReversalChecked']!;
  bool get isAM2SignalExitChecked => _am2Values['AM2SignalExitChecked']!;
  bool get isAM2TcChangeChecked => _am2Values['AM2TcChangeChecked']!;
  bool get isAM2HwChecked => _am2Values['AM2HwChecked']!;
  bool get isAM2MfChecked => _am2Values['AM2MfChecked']!;
  bool get isAM2HWTHChecked => _am2Values['AM2HWTHChecked']!;

  //Auto Booking & Closing
  // bool get isAM1Checked => _values['AM1Checked']!;
  // bool get isAM2Checked => _values['AM2Checked']!;
  // bool get isAM1Checked => _values['AM1Checked']!;
  // bool get isAMChecked => _values['AMChecked']!;

  bool get isLongAllChecked => isLongTcChecked && isLongTtChecked && isLongNeoChecked && isLongConfChecked;

  bool get isShortAllChecked => isShortTcChecked && isShortTtChecked && isShortNeoChecked && isShortConfChecked;

  bool get isM1LongAllChecked =>
      (isLongAllChecked && isLongM1MfChecked && isLongM1TrendChecked) ||
      (isLongAllChecked && !isLongM1MfChecked && isLongM1ReversalChecked && isLongM1TrendChecked);

  bool get isM1ShortAllChecked =>
      (isShortAllChecked && isShortM1MfChecked && isShortM1TrendChecked) ||
      (isShortAllChecked && !isShortM1MfChecked && isShortM1ReversalChecked && isShortM1TrendChecked);

  bool get isM2LongAllChecked =>
      // (isLongDivergenceChecked || isLongRevChecked) && isLongCatcherChecked && isLongOscChecked;
      ((isLongDivergenceChecked || isLongRevChecked) &&
          isLongCatcherChecked &&
          isLongM2MfChecked &&
          isLongM2TrendChecked) ||
      ((isLongDivergenceChecked || isLongRevChecked) &&
          isLongCatcherChecked &&
          !isLongM2MfChecked &&
          isLongM2ReversalChecked &&
          isLongM2TrendChecked);

  bool get isM2ShortAllChecked =>
      ((isShortDivergenceChecked || isShortRevChecked) &&
          isShortCatcherChecked &&
          isShortM2MfChecked &&
          isShortM2TrendChecked) ||
      ((isShortDivergenceChecked || isShortRevChecked) &&
          isShortCatcherChecked &&
          !isShortM2MfChecked &&
          isShortM2TrendChecked &&
          isShortM2ReversalChecked);

  // Future<void> loadForSymbol(String symbol) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   _currentSymbol = symbol;
  //   final prefs = await SharedPreferences.getInstance();
  //   final data = prefs.getString('checkbox_state:$symbol');
  //   if (data == null) {
  //     _values = _emptyValues();
  //   } else {
  //     final decoded = Map<String, dynamic>.from(jsonDecode(data));
  //     _values = decoded.map((k, v) => MapEntry(k, v as bool));
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }
  // Future<void> loadForM3Values(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? data = prefs.getString('AutomateCurrentOpening');
  //   if (data != null) {
  //     final Map<String, dynamic> am1Decoded = jsonDecode(data);
  //     if (!context.mounted) return;
  //     final prov = Provider.of<ValueProvider>(context, listen: false);
  //     prov.lastAMOpen = CurrentAutomationModel.fromJson(am1Decoded);
  //     prov.amSelectedValue = prov.lastAMOpen!.symbol;
  //     prov.amSelectedItem = SearchFieldListItem(
  //       prov.amSelectedValue!,
  //       item: prov.amSelectedValue,
  //     );
  //     prov.am1VolumeController.text = prov.lastAMOpen!.volume.toString();
  //     // _values['AM1Checked'] = prov.lastAMOpen!.isChecked;
  //     _values['AM1Checked'] = prov.lastAMOpen!.isEnabled;
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }
  Future<void> loadFromApi(String symbol, String section) async {
    _isLoading = true;
    notifyListeners();

    _currentSymbol = symbol;

    try {
      final result = await getSymbolSetting(userId: "1", symbol: symbol, section: section);

      // ✅ Then apply API values
      // result.forEach((key, value) {
      //   _values[key] = value;
      // });

      if (section == 'MM') {
        // ✅ Then apply API values
        result.forEach((key, value) {
          _mmValues[key] = value;
        });
      }
      if (section == 'AM1') {
        // ✅ Then apply API values
        result.forEach((key, value) {
          _am1Values[key] = value;
        });
      }
      if (section == 'AM2') {
        // ✅ Then apply API values
        result.forEach((key, value) {
          _am2Values[key] = value;
        });
      }
    } catch (e) {
      // _values = _emptyValues();
      _mmValues = _mmEmptyValues();
      _am1Values = _am1EmptyValues();
      _am2Values = _am2EmptyValues();
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeValue(String? action, String method, String field, BuildContext context) {
    // _values[field] = !(_values[field] ?? false);

    // if (field.startsWith('Long')) {
    //   _values[field.replaceFirst('Long', 'Short')] = false;
    // }
    // if (field.startsWith('Short')) {
    //   _values[field.replaceFirst('Short', 'Long')] = false;
    // }
    if (method == "MM") {
      _mmValues[field] = !(_mmValues[field] ?? false);

      if (field.startsWith('Long')) {
        _mmValues[field.replaceFirst('Long', 'Short')] = false;
      }
      if (field.startsWith('Short')) {
        _mmValues[field.replaceFirst('Short', 'Long')] = false;
      }
    }
    if (method == 'AM1') {
      _am1Values[field] = _am1Values[field]!;
    }
    if (method == 'AM2') {
      _am2Values[field] = _am2Values[field]!;
    }
    // if (method == 'AM2') {
    //   _values[field] = _values[field]!;
    // }
    if (_currentSymbol == null) return;
    if (method == 'MM') {
      symbolSetting(
        userId: "1",
        symbol: _currentSymbol!,
        section: method, // MM1 / MM2
        checkedValues: _mmValues,
      );
    }
    if (method == 'AM1') {
      symbolSetting(
        userId: "1",
        symbol: _currentSymbol!,
        section: method, // AM1
        checkedValues: _am1Values,
      );
    }
    if (method == 'AM2') {
      symbolSetting(
        userId: "1",
        symbol: _currentSymbol!,
        section: method, // AM2
        checkedValues: _am2Values,
      );
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
      // final symbol = Provider.of<ValueProvider>(context, listen: false).selectedValue;
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
      // final symbol = Provider.of<ValueProvider>(context, listen: false).selectedValue;
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
      // final symbol = Provider.of<ValueProvider>(context, listen: false).selectedValue;
      final symbol = Provider.of<ValueProvider>(context, listen: false).amSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else if (field == 'AM2ReversalPlusPlusChecked' ||
        field == 'AM2ReversalPlusChecked' ||
        field == 'AM2ReversalChecked' ||
        field == 'AM2SignalExitChecked' ||
        field == 'AM2TcChangeChecked' ||
        field == 'AM2HwChecked' ||
        field == 'AM2HWTHChecked' ||
        field == 'AM2MfChecked') {
      // final symbol = Provider.of<ValueProvider>(context, listen: false).selectedValue;
      final symbol = Provider.of<ValueProvider>(context, listen: false).amSelectedValue;
      final crnt = Provider.of<ValueProvider>(context, listen: false).currentOpening;
      var crntMod = crnt.firstWhere((el) => el.symbol == symbol && el.method == method);
      updateTradeFlags(crntMod, context);
    } else {
      return;
    }
  }

  void clearState(String method) {
    if (method == 'MM1' || method == 'MM2') {
      _mmValues = _mmEmptyValues();
    }
    if (method == 'AM1') {
      _am1Values = _am1EmptyValues();
    }
    if (method == 'AM2') {
      _am2Values = _am2EmptyValues();
    }
    _currentSymbol = null;
    notifyListeners();
  }
}
