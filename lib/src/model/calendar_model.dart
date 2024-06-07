import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/model/enum/event_type_enum.dart'; // Assuming supabaseClient is defined in main.dart

class Calendar extends AuditModel {
  String _id;
  String _title;
  EventTypeEnum _eventType;
  DateTime _startDate;
  DateTime _stopDate;
  String _room;
  String _instructor;
  String? _comment;

  Calendar({
    required String id,
    required String title,
    required EventTypeEnum eventType,
    required DateTime startDate,
    required DateTime stopDate,
    required String room,
    required String instructor,
    String? comment,
  })  : _id = id,
        _title = title,
        _eventType = eventType,
        _startDate = startDate,
        _stopDate = stopDate,
        _room = room,
        _instructor = instructor,
        _comment = comment,
        super();

  factory Calendar.fromJson(Map<String, dynamic> map) {
    return Calendar(
      id: map['id'] as String,
      title: map['title'] as String,
      eventType: _mapStringToEventTypeEnum(map['event_type'] as String),
      startDate: DateTime.parse(map['start_date'] as String),
      stopDate: DateTime.parse(map['stop_date'] as String),
      room: map['room'] as String,
      instructor: map['instructor'] as String,
      comment: map['comment'] as String?,
    );
  }

  static EventTypeEnum _mapStringToEventTypeEnum(String eventType) {
    switch (eventType) {
      case 'class':
        return EventTypeEnum.CLASS;
      case 'test':
        return EventTypeEnum.TEST;
      default:
        throw ArgumentError('Unknown event type: $eventType');
    }
  }

  static Future<List<Calendar>> load() async {
    try {
      final response = await supabaseClient.from("calendar").select();

      final data = response as List<dynamic>;
      for (var item in data) {
        calendarData.add(Calendar.fromJson(item));
      }
    } catch (e) {
      print("Error loading calendar events: $e");
    }

    return calendarData;
  }


  String get id => _id;
  set id(String value) => _id = value;

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
