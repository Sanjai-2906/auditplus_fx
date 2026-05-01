// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeHistoryModel _$TradeHistoryModelFromJson(Map<String, dynamic> json) =>
    TradeHistoryModel(
      symbol: json['symbol'] as String,
      profit: json['profit'] as num,
      method: json['method'] as String,
    );

Map<String, dynamic> _$TradeHistoryModelToJson(TradeHistoryModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'profit': instance.profit,
      'method': instance.method,
    };
