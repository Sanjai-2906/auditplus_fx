import 'package:json_annotation/json_annotation.dart';
part 'current_automation_model.g.dart';

@JsonEnum()
enum ActionType { add, disable, close }

@JsonSerializable()
class CurrentAutomationModel {
  String method;
  String symbol;
  num volume;
  bool isEnabled;
  DateTime? startTime;
  DateTime? endTime;
  ActionType action;

  CurrentAutomationModel({
    required this.method,
    required this.symbol,
    required this.volume,
    required this.action,
    required this.isEnabled,
    this.startTime,
    this.endTime,
  });

  factory CurrentAutomationModel.fromJson(Map<String, dynamic> json) => _$CurrentAutomationModelFromJson(json);

  Map<String, dynamic> toJson() => {
    "method": method,
    "symbol": symbol,
    "volume": volume,
    "isEnabled": isEnabled,
    "action": action.name,
    if (startTime != null && endTime != null)
      "timeRange": {"start": startTime!.toIso8601String(), "end": endTime!.toIso8601String()},
  };

  @override
  String toString() {
    return "CurrentAutomationModel{Method : $method, Symbol : $symbol, Volume : $volume, Action: $action, IsEnabled: $isEnabled, Start Time: $startTime, End Time: $endTime}";
  }
}
