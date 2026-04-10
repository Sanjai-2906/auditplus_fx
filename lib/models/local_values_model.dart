import 'package:json_annotation/json_annotation.dart';

part 'local_values_model.g.dart';

@JsonSerializable()
class LiveAutomaticTradeModel {
  String method;
  String symbol;
  num volume;

  LiveAutomaticTradeModel({required this.method, required this.symbol, required this.volume});

  factory LiveAutomaticTradeModel.fromJson(Map<String, dynamic> json) => _$LiveAutomaticTradeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveAutomaticTradeModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LiveAutomaticTradeModel && symbol == other.symbol && method == other.method;

  @override
  int get hashCode => symbol.hashCode ^ method.hashCode;

  @override
  String toString() {
    return "LiveAutomaticTradeModel{Method: $method,Symbol: $symbol,Volume: $volume}";
  }
}

@JsonSerializable()
class LocalValuesModel {
  String userId;
  String lastActiveSymbol;
  String amLastSymbol;
  num manualVolume;
  num automaticVolume;
  List<LiveAutomaticTradeModel> liveAutomaticTrade;

  LocalValuesModel({
    required this.userId,
    required this.lastActiveSymbol,
    required this.amLastSymbol,
    required this.automaticVolume,
    required this.manualVolume,
    required this.liveAutomaticTrade,
  });

  factory LocalValuesModel.fromJson(Map<String, dynamic> json) => _$LocalValuesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalValuesModelToJson(this);

  @override
  String toString() {
    return "LocalValuesModel{User Id: $userId,Last Active Symbol: $lastActiveSymbol,Am Last Active Symbol: $amLastSymbol,Manual Volume : $manualVolume,Automatic Volume: $automaticVolume,LiveAutomaticTrade: $liveAutomaticTrade}";
  }
}
