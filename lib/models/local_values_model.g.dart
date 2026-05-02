// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_values_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveAutomaticTradeModel _$LiveAutomaticTradeModelFromJson(
  Map<String, dynamic> json,
) => LiveAutomaticTradeModel(
  method: json['method'] as String,
  symbol: json['symbol'] as String,
  volume: json['volume'] as num,
);

Map<String, dynamic> _$LiveAutomaticTradeModelToJson(
  LiveAutomaticTradeModel instance,
) => <String, dynamic>{
  'method': instance.method,
  'symbol': instance.symbol,
  'volume': instance.volume,
};

LocalValuesModel _$LocalValuesModelFromJson(Map<String, dynamic> json) =>
    LocalValuesModel(
      userId: json['userId'] as String,
      lastActiveSymbol: json['lastActiveSymbol'] as String,
      amLastSymbol: json['amLastSymbol'] as String,
      automaticVolume: json['automaticVolume'] as String,
      manualVolume: json['manualVolume'] as String,
      liveAutomaticTrade: (json['liveAutomaticTrade'] as List<dynamic>)
          .map(
            (e) => LiveAutomaticTradeModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$LocalValuesModelToJson(LocalValuesModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'lastActiveSymbol': instance.lastActiveSymbol,
      'amLastSymbol': instance.amLastSymbol,
      'manualVolume': instance.manualVolume,
      'automaticVolume': instance.automaticVolume,
      'liveAutomaticTrade': instance.liveAutomaticTrade,
    };
