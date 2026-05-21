import 'package:json_annotation/json_annotation.dart';

part 'db_report_model.g.dart';

@JsonSerializable()
class DbReportModel {
  DateTime? openedAt;
  DateTime? closedAt;
  String symbol;
  String method;
  num openPrice;
  num closePrice;
  num profit;
  String actionType;
  String volume;
  String positionId;
  String info;
  String status;
  String description;

  DbReportModel({
    required this.openedAt,
    required this.closedAt,
    required this.symbol,
    required this.method,
    required this.openPrice,
    required this.closePrice,
    required this.profit,
    required this.actionType,
    required this.info,
    required this.volume,
    required this.positionId,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'openedAt': openedAt,
    'closedAt': closedAt,
    'symbol': symbol,
    'method': method,
    'openPrice': openPrice,
    'closePrice': closePrice,
    'profit': profit,
    'actionType': actionType,
    'volume': volume,
    'info': info,
    'positionId': positionId,
    'status': status,
    'description': description,
  };

  factory DbReportModel.fromJson(Map<String, dynamic> json) => _$DbReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$DbReportModelToJson(this);

  @override
  String toString() {
    return "DbReportModel{Opened Time : $openedAt,Closed Time : $closedAt,Symbol : $symbol,Method : $method,Open Price : $openPrice,Close Price : $closePrice,Profit: $profit,Action Type : $actionType,Volume : $volume,Postion Id : $positionId, Info : $info, Status : $status, Description : $description}";
  }
}
