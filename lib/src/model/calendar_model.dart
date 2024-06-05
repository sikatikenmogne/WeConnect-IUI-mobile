import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/enum/event_type_enum.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Calendar extends AuditModel {
  String _id;
  String _title;
  EventTypeEnum _eventType;
  DateTime _startDate;
  DateTime _stopDate;
  String _room;
  String _instructor;
  String? _comment;

  Calendar._({
    required String id,
    required String title,
    required EventTypeEnum eventType,
    required DateTime startDate,
    required DateTime stopDate,
    required String room,
    required String instructor,
    required String comment,
  })  : _id = id,
        _title = title,
        _eventType = eventType,
        _startDate = startDate,
        _stopDate = stopDate,
        _room = room,
        _instructor = instructor,
        _comment = comment,
        super();

  static Future<Calendar> create({
    required String title,
    required EventTypeEnum eventType,
    required DateTime startDate,
    required DateTime stopDate,
    required String room,
    required String instructor,
    required String comment,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newCalendar = Calendar._(
      id: id,
      title: title,
      eventType: eventType,
      startDate: startDate,
      stopDate: stopDate,
      room: room,
      instructor: instructor,
      comment: comment,
    );

    final response = await supabaseClient.from("calendars").insert({
      "id": id,
      "title": title,
      "eventType": eventType.toString(), // Convert enum to string
      "startDate": startDate.toIso8601String(),
      "stopDate": stopDate.toIso8601String(),
      "room": room,
      "instructor": instructor,
      "comment": comment,
    });

    if (response.error != null) {
      print('Error inserting calendar event: ${response.error!.message}');
    } else {
      print('Calendar event inserted successfully');
    }

    return newCalendar;
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
