import 'package:flutter/material.dart';
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
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  TimeOfDay? startTime;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  TimeOfDay? endTime;
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
      "timeRange": {"start": _timeToJson(startTime!), "end": _timeToJson(endTime!)},
  };

  static TimeOfDay? _timeFromJson(String? time) {
    if (time == null) return null;

    final parts = time.split(":");

    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String? _timeToJson(TimeOfDay? time) {
    if (time == null) return null;

    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:00";
  }

  @override
  String toString() {
    return "CurrentAutomationModel{Method : $method, Symbol : $symbol, Volume : $volume, Action: $action, IsEnabled: $isEnabled, Start Time: $startTime, End Time: $endTime}";
  }
}
