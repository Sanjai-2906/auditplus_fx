import 'package:json_annotation/json_annotation.dart';

part 'open_request_model.g.dart';

@JsonSerializable()
class OpenRequestModel {
  String actionType;
  String? symbol;
  String? method;
  num volume;
  num? takeProfit;
  bool reversalPlusPlus;
  bool reversalPlus;
  bool reversal;
  bool signalExit;
  bool tcChange;
  bool hyperWave;
  bool hyperWaveThreshold;
  bool moneyFlow;

  OpenRequestModel({
    required this.actionType,
    required this.symbol,
    required this.method,
    required this.volume,
    this.takeProfit,
    required this.reversalPlusPlus,
    required this.reversalPlus,
    required this.reversal,
    required this.signalExit,
    required this.tcChange,
    required this.hyperWave,
    required this.hyperWaveThreshold,
    required this.moneyFlow,
  });

  factory OpenRequestModel.fromJson(Map<String, dynamic> json) => _$OpenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpenRequestModelToJson(this);

  @override
  String toString() {
    return "OpenRequestModel{Action type: $actionType,Symbol : $symbol,Volume: $volume,Take profit: $takeProfit,Reversal Plus Plus: $reversalPlusPlus,,Reversal Plus: $reversalPlus,Reversal: $reversal,Signal Exit: $signalExit,Tc Change: $tcChange,Hyper Wave: $hyperWave,Hyper Wave Threshold: $hyperWaveThreshold,Money Flow: $moneyFlow}";
  }
}
