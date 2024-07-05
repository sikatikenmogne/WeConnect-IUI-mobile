import 'dart:math';

import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Comment extends AuditModel {
  String _id;
  User _author;
  String _content;
  List<User>? _likes;
  Post? _postParent;
  List<Comment> _responses = [];
  DateTime _date; // Added date attribute

  Comment({
    required User author,
    required String content,
    DateTime? date,
    List<User>? likes,
    Post? postParent,
  })  : _id = AutogenerateUtil().generateId(),
        _content = content,
        _date = date ?? _generateRandomDate(),
        _likes = likes,
        _postParent = postParent,
        _author = author,
        super();

  List<Comment> get comments => _responses;

  void addResponse(Comment comment) => _responses.add(comment);

  static DateTime _generateRandomDate() {
    var now = DateTime.now();
    int daysInPast =
        Random().nextInt(365); // Generate a random number of days (up to 365)
    return now.subtract(Duration(days: daysInPast));
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  List<User>? get likes => _likes;
  set likes(List<User>? value) => _likes = value;

  Post? get postParent => _postParent;
  set postParent(Post? value) => _postParent = value;

  User get author => _author;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;
}
