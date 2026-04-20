import 'dart:convert';

import 'package:auditplus_fx/api_methods/local_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import 'providers.dart';

//Screen Selection
enum Method { method1, method2, method3, method4, method9 }

class ValueProvider extends ChangeNotifier {
  //Screen Changes
  Method manualScreenView = Method.method1;
  Method autoScreenView = Method.method1;

  //new section start
  bool isM1Checked = false;
  bool isM2Checked = false;
  bool isM3Checked = false;
  bool isM4Checked = false;
  void enableMethod(String method) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (method == "MM1") {
      isM1Checked = !isM1Checked;
      await prefs.setBool('M1Checked', isM1Checked);
    } else if (method == "MM2") {
      isM2Checked = !isM2Checked;
      await prefs.setBool('M2Checked', isM2Checked);
    } else if (method == "MM3") {
      isM3Checked = !isM3Checked;
      await prefs.setBool('M3Checked', isM3Checked);
    } else if (method == "MM4") {
      isM4Checked = !isM4Checked;
      await prefs.setBool('M4Checked', isM4Checked);
    }
    notifyListeners();
  }

  Future<void> _loadMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isM1Checked = prefs.getBool('M1Checked') ?? false;
    isM2Checked = prefs.getBool('M2Checked') ?? false;
    isM3Checked = prefs.getBool('M3Checked') ?? false;
    isM4Checked = prefs.getBool('M4Checked') ?? false;
  }

  //new section end
  String? manualSelectedValue;
  String? amSelectedValue;
  bool isAutomaticSectionEnabled = false;
  SearchFieldListItem<String>? manualSelectedItem;
  SearchFieldListItem<String>? amSelectedItem;
  num manualVolume = 0.01;
  num amVolume = 0.01;
  final TextEditingController manualVolumeController = TextEditingController();
  final TextEditingController amVolumeController = TextEditingController();

  bool _isLoading = true;
  Set<CurrentOpenModel> currentOpening = {};
  SearchFieldListItem<String>? lastActiveSymbol;
  CurrentAutomationModel? lastAMOpen;
  bool get isLoading => _isLoading;

  Map<String, LiveAutomaticTradeModel> liveAutomaticTradeM1 = {};
  Map<String, LiveAutomaticTradeModel> liveAutomaticTradeM2 = {};
  Map<String, LiveAutomaticTradeModel> liveAutomaticTradeM3 = {};
  Map<String, LiveAutomaticTradeModel> liveAutomaticTradeM4 = {};
  Map<String, LiveAutomaticTradeModel> liveAutomaticTradeM9 = {};

  ValueProvider(BuildContext context) {
    _loadMethod();
    _loadInitial(context);
  }

  @override
  void dispose() {
    manualVolumeController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial(BuildContext context) async {
    final response = await getLocalValues();
    manualVolume = response.manualVolume;
    manualVolumeController.text = manualVolume.toString();
    amVolume = response.automaticVolume;
    amVolumeController.text = amVolume.toStringAsFixed(2);
    final lastSymbol = response.lastActiveSymbol;
    final amLastSymbol = response.amLastSymbol;
    var liveAmData = response.liveAutomaticTrade;
    for (var item in liveAmData) {
      if (item.method == 'AM1') {
        liveAutomaticTradeM1[item.symbol] = item;
      } else if (item.method == 'AM2') {
        liveAutomaticTradeM2[item.symbol] = item;
      } else if (item.method == 'AM3') {
        liveAutomaticTradeM3[item.symbol] = item;
      } else if (item.method == 'AM4') {
        liveAutomaticTradeM4[item.symbol] = item;
      } else if (item.method == 'AM9') {
        liveAutomaticTradeM9[item.symbol] = item;
      }
    }
    if (lastSymbol.isNotEmpty) {
      manualSelectedValue = lastSymbol;
      manualSelectedItem = SearchFieldListItem<String>(lastSymbol, item: lastSymbol);

      Future.microtask(() {
        if (!context.mounted) return;

        final checkboxProvider = Provider.of<CheckedBoxProvider>(context, listen: false);

        checkboxProvider.loadAll(lastSymbol);
      });
    }
    if (amLastSymbol.isNotEmpty) {
      amSelectedValue = amLastSymbol;
      amSelectedItem = SearchFieldListItem<String>(amLastSymbol, item: amLastSymbol);

      Future.microtask(() {
        if (!context.mounted) return;

        final checkboxProvider = Provider.of<CheckedBoxProvider>(context, listen: false);

        checkboxProvider.loadAll(amLastSymbol);
      });
    }

    _isLoading = false;

    notifyListeners();
  }

  void setAutomaticEnable() {
    isAutomaticSectionEnabled = !isAutomaticSectionEnabled;
    notifyListeners();
  }

  void setManualVolume(double newVolume) async {
    manualVolume = newVolume;
    manualVolumeController.text = newVolume.toString();

    final data = LocalValuesModel(
      userId: "1",
      lastActiveSymbol: manualSelectedValue ?? "",
      amLastSymbol: amSelectedValue ?? "",
      automaticVolume: amVolume,
      manualVolume: manualVolume,
      liveAutomaticTrade: [
        ...liveAutomaticTradeM1.values,
        ...liveAutomaticTradeM2.values,
        ...liveAutomaticTradeM3.values,
        ...liveAutomaticTradeM4.values,
        ...liveAutomaticTradeM9.values,
      ],
    );
    await setLocalValues(data);
    notifyListeners();
  }

  void setAMVolume(String method, double newVolume) async {
    amVolume = newVolume;
    amVolumeController.text = newVolume.toStringAsFixed(2);

    final data = LocalValuesModel(
      userId: "1",
      lastActiveSymbol: manualSelectedValue ?? "",
      amLastSymbol: amSelectedValue ?? "",
      automaticVolume: amVolume,
      manualVolume: manualVolume,
      liveAutomaticTrade: [
        ...liveAutomaticTradeM1.values,
        ...liveAutomaticTradeM2.values,
        ...liveAutomaticTradeM3.values,
        ...liveAutomaticTradeM4.values,
        ...liveAutomaticTradeM9.values,
      ],
    );
    await setLocalValues(data);
    notifyListeners();
  }

  void clearSelectedValue() {
    manualSelectedValue = null;
    manualSelectedItem = null;
    notifyListeners();
  }

  void amClearSelectedValue() {
    amSelectedValue = null;
    amSelectedItem = null;
    notifyListeners();
  }

  //Change Screen
  void changeMethodScreen(String screen, Method selection) {
    if (screen == 'MM') {
      manualScreenView = selection;
    } else if (screen == 'AM') {
      autoScreenView = selection;
    }
    notifyListeners();
  }

  void setSelectedItem(SearchFieldListItem<String> item, BuildContext context) async {
    manualSelectedItem = item;
    manualSelectedValue = item.searchKey;

    final data = LocalValuesModel(
      userId: "1",
      lastActiveSymbol: manualSelectedValue ?? "",
      amLastSymbol: amSelectedValue ?? "",
      automaticVolume: amVolume,
      manualVolume: manualVolume,
      liveAutomaticTrade: [
        ...liveAutomaticTradeM1.values,
        ...liveAutomaticTradeM2.values,
        ...liveAutomaticTradeM3.values,
        ...liveAutomaticTradeM4.values,
        ...liveAutomaticTradeM9.values,
      ],
    );
    await setLocalValues(data);
    notifyListeners();
  }

  void setAMSelectedItem(SearchFieldListItem<String> item, BuildContext context) async {
    amSelectedItem = item;
    amSelectedValue = item.searchKey;

    final data = LocalValuesModel(
      userId: "1",
      lastActiveSymbol: manualSelectedValue ?? "",
      amLastSymbol: amSelectedValue ?? "",
      automaticVolume: amVolume,
      manualVolume: manualVolume,
      liveAutomaticTrade: [
        ...liveAutomaticTradeM1.values,
        ...liveAutomaticTradeM2.values,
        ...liveAutomaticTradeM3.values,
        ...liveAutomaticTradeM4.values,
        ...liveAutomaticTradeM9.values,
      ],
    );
    await setLocalValues(data);

    notifyListeners();
  }

  void addCurrentOpen(CurrentOpenModel symb) async {
    currentOpening.add(symb);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(currentOpening.map((e) => e.toJson()).toList());
    await prefs.setString('currentOpening', encoded);
  }

  Future<void> clearCurrentOpenBySymbol(String symbol) async {
    currentOpening.removeWhere((e) => e.symbol == symbol);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(currentOpening.map((e) => e.toJson()).toList());
    await prefs.setString('currentOpening', encoded);
  }

  CurrentOpenModel? getOpenBySymbol(String symbol) {
    try {
      return currentOpening.firstWhere((e) => e.symbol == symbol);
    } catch (_) {
      return null;
    }
  }

  void updateFlags(String symbol, bool rpp, bool rp, bool r, bool s, bool t, bool hw, bool hwTh) {
    final open = getOpenBySymbol(symbol);
    if (open != null) {
      open.reversalPlusPlus = rpp;
      open.reversalPlus = rp;
      open.reversal = r;
      open.signalExit = s;
      open.tcChange = t;
      open.hyperWave = hw;
      open.hyperWaveThreshold = hwTh;
      notifyListeners();
    }
  }

  void removeLiveTrade(String symbol, String method) {
    if (method == 'AM1') {
      liveAutomaticTradeM1.remove(symbol);
    } else if (method == 'AM2') {
      liveAutomaticTradeM2.remove(symbol);
    } else if (method == 'AM3') {
      liveAutomaticTradeM3.remove(symbol);
    } else if (method == 'AM4') {
      liveAutomaticTradeM4.remove(symbol);
    } else if (method == 'AM9') {
      liveAutomaticTradeM9.remove(symbol);
    }
    notifyListeners();
  }

  void addLiveTrade(CurrentAutomationModel mod) {
    if (mod.method == 'AM1') {
      liveAutomaticTradeM1[mod.symbol] = LiveAutomaticTradeModel(
        method: mod.method,
        symbol: mod.symbol,
        volume: mod.volume,
      );
    } else if (mod.method == 'AM2') {
      liveAutomaticTradeM2[mod.symbol] = LiveAutomaticTradeModel(
        method: mod.method,
        symbol: mod.symbol,
        volume: mod.volume,
      );
    } else if (mod.method == 'AM3') {
      liveAutomaticTradeM3[mod.symbol] = LiveAutomaticTradeModel(
        method: mod.method,
        symbol: mod.symbol,
        volume: mod.volume,
      );
    } else if (mod.method == 'AM4') {
      liveAutomaticTradeM4[mod.symbol] = LiveAutomaticTradeModel(
        method: mod.method,
        symbol: mod.symbol,
        volume: mod.volume,
      );
    } else if (mod.method == 'AM9') {
      liveAutomaticTradeM9[mod.symbol] = LiveAutomaticTradeModel(
        method: mod.method,
        symbol: mod.symbol,
        volume: mod.volume,
      );
    }

    notifyListeners();
  }
}
