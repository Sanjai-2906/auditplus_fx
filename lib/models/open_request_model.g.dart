// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenRequestModel _$OpenRequestModelFromJson(Map<String, dynamic> json) =>
    OpenRequestModel(
      actionType: json['actionType'] as String,
      symbol: json['symbol'] as String?,
      method: json['method'] as String?,
      volume: json['volume'] as num,
      takeProfit: json['takeProfit'] as num?,
      reversalPlusPlus: json['reversalPlusPlus'] as bool,
      reversalPlus: json['reversalPlus'] as bool,
      reversal: json['reversal'] as bool,
      signalExit: json['signalExit'] as bool,
      tcChange: json['tcChange'] as bool,
      hyperWave: json['hyperWave'] as bool,
      hyperWaveThreshold: json['hyperWaveThreshold'] as bool,
      moneyFlow: json['moneyFlow'] as bool,
    );

Map<String, dynamic> _$OpenRequestModelToJson(OpenRequestModel instance) =>
    <String, dynamic>{
      'actionType': instance.actionType,
      'symbol': instance.symbol,
      'method': instance.method,
      'volume': instance.volume,
      'takeProfit': instance.takeProfit,
      'reversalPlusPlus': instance.reversalPlusPlus,
      'reversalPlus': instance.reversalPlus,
      'reversal': instance.reversal,
      'signalExit': instance.signalExit,
      'tcChange': instance.tcChange,
      'hyperWave': instance.hyperWave,
      'hyperWaveThreshold': instance.hyperWaveThreshold,
      'moneyFlow': instance.moneyFlow,
    };
