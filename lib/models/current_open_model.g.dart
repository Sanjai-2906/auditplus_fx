// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_open_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentOpenModel _$CurrentOpenModelFromJson(Map<String, dynamic> json) =>
    CurrentOpenModel(
      symbol: json['symbol'] as String,
      method: json['method'] as String,
      actionType: json['actionType'] as String,
      reversalPlusPlus: json['reversalPlusPlus'] as bool,
      reversalPlus: json['reversalPlus'] as bool,
      reversal: json['reversal'] as bool,
      signalExit: json['signalExit'] as bool,
      tcChange: json['tcChange'] as bool,
      hyperWave: json['hyperWave'] as bool,
      hyperWaveThreshold: json['hyperWaveThreshold'] as bool,
      moneyFlow: json['moneyFlow'] as bool,
    );

Map<String, dynamic> _$CurrentOpenModelToJson(CurrentOpenModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'method': instance.method,
      'actionType': instance.actionType,
      'reversalPlusPlus': instance.reversalPlusPlus,
      'reversalPlus': instance.reversalPlus,
      'reversal': instance.reversal,
      'signalExit': instance.signalExit,
      'tcChange': instance.tcChange,
      'hyperWave': instance.hyperWave,
      'hyperWaveThreshold': instance.hyperWaveThreshold,
      'moneyFlow': instance.moneyFlow,
    };
