import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/main.dart';

class Event extends AuditModel {
  String _id;
  String _title;
  String _eventType;
  DateTime _dateFrom;
  DateTime _dateTo;
  String? _room;
  String? _instructor;

  Event({
    required String id,
    required String title,
    required String eventType,
    required DateTime dateFrom,
    required DateTime dateTo,
    String? room,
    String? instructor,
  })  : _id = id,
        _title = title,
        _eventType = eventType,
        _dateFrom = dateFrom,
        _dateTo = dateTo,
        _room = room,
        _instructor = instructor,
        super();

  factory Event.fromJson(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      eventType: map['event_type'] as String,
      dateFrom: DateTime.parse(map['date_from'] as String),
      dateTo: DateTime.parse(map['date_to'] as String),
      room: map['room'] as String?,
      instructor: map['instructor'] as String?,
    );
  }

  static Future<List<Event>> load() async {
    try {
      final response = await supabaseClient.from("events").select();

      final data = response as List<dynamic>;
      for (var item in data) {
        eventData.add(Event.fromJson(item));
      }
    } catch (e) {
      print("Error loading events: $e");
    }

    return eventData;
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get title => _title;
  set title(String value) => _title = value;

  String get eventType => _eventType;
  set eventType(String value) => _eventType = value;

  DateTime get dateFrom => _dateFrom;
  set dateFrom(DateTime value) => _dateFrom = value;

  DateTime get dateTo => _dateTo;
  set dateTo(DateTime value) => _dateTo = value;

  String? get room => _room;
  set room(String? value) => _room = value;

  String? get instructor => _instructor;
  set instructor(String? value) => _instructor = value;
}