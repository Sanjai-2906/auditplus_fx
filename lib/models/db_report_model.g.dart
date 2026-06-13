// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DbReportModel _$DbReportModelFromJson(Map<String, dynamic> json) =>
    DbReportModel(
      openedAt: json['openedAt'] as String?,
      closedAt: json['closedAt'] as String?,
      symbol: json['symbol'] as String,
      openPrice: json['openPrice'] as num,
      closePrice: json['closePrice'] as num,
      profit: json['profit'] as num,
      swap: json['swap'] as num,
      commission: json['commission'] as num,
      actionType: json['actionType'] as String,
      volume: json['volume'] as String,
      positionId: json['positionId'] as String,
      dealType: json['dealType'] as String,
    );

Map<String, dynamic> _$DbReportModelToJson(DbReportModel instance) =>
    <String, dynamic>{
      'openedAt': instance.openedAt,
      'closedAt': instance.closedAt,
      'symbol': instance.symbol,
      'openPrice': instance.openPrice,
      'closePrice': instance.closePrice,
      'profit': instance.profit,
      'swap': instance.swap,
      'commission': instance.commission,
      'actionType': instance.actionType,
      'volume': instance.volume,
      'positionId': instance.positionId,
      'dealType': instance.dealType,
    };
