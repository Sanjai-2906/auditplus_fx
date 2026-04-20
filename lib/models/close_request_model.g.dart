// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseRequestModel _$CloseRequestModelFromJson(Map<String, dynamic> json) =>
    CloseRequestModel(
      actionType: json['actionType'] as String,
      symbol: json['symbol'] as String?,
      method: json['method'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CloseRequestModelToJson(CloseRequestModel instance) =>
    <String, dynamic>{
      'actionType': instance.actionType,
      'symbol': instance.symbol,
      'method': instance.method,
      'description': instance.description,
    };
