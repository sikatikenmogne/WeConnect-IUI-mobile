import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/enum/event_type_enum.dart';

class Calendar extends AuditModel{
  String _title;
  EventTypeEnum _eventType;
  DateTime _startDate;
  DateTime _stopDate;
  String _room;
  String _instructor;
  String? _comment;

  Calendar({
    required String title,
    required EventTypeEnum eventType,
    required DateTime startDate,
    required DateTime stopDate,
    required String room,
    required String instructor,
    required String comment,
  })  : _title = title,
        _eventType = eventType,
        _startDate = startDate,
        _stopDate = stopDate,
        _room = room,
        _instructor = instructor,
        _comment = comment,
        super();

  String get title => _title;
  set title(String value) => _title = value;

  EventTypeEnum get eventType => _eventType;
  set eventType(EventTypeEnum value) => _eventType = value;

  DateTime get startDate => _startDate;
  set startDate(DateTime value) => _startDate = value;

  DateTime get stopDate => _stopDate;
  set stopDate(DateTime value) => _stopDate = value;

  String get room => _room;
  set room(String value) => _room = value;

  String get instructor => _instructor;
  set instructor(String value) => _instructor = value;

  String? get comment => _comment;
  set comment(String? value) => _comment = value;
}