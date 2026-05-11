// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_automation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAutomationModel _$CurrentAutomationModelFromJson(Map<String, dynamic> json) => CurrentAutomationModel(
  method: json['method'] as String,
  symbol: json['symbol'] as String,
  volume: json['volume'] as num,
  action: $enumDecode(_$ActionTypeEnumMap, json['action']),
  isEnabled: json['isEnabled'] as bool,
  startTime: json['startTime'] == null ? null : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$CurrentAutomationModelToJson(CurrentAutomationModel instance) => <String, dynamic>{
  'method': instance.method,
  'symbol': instance.symbol,
  'volume': instance.volume,
  'isEnabled': instance.isEnabled,
  'startTime': instance.startTime?.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'action': _$ActionTypeEnumMap[instance.action]!,
};

const _$ActionTypeEnumMap = {ActionType.add: 'add', ActionType.disable: 'disable', ActionType.close: 'close'};
