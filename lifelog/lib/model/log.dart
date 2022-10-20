import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable()
class Log {
  String id;
  String title;
  String context;
  DateTime datetime;

  Log(
      {required this.id,
      required this.title,
      required this.context,
      required this.datetime});

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);
}
