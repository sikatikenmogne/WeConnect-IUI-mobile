import 'dart:math';

import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Post extends AuditModel {
  String _id;
  User _author;
  String _content;
  String? _media;
  List<User>? _likes;
  List<Comment>? _comments;
  DateTime _date;

  Post({
    required User author,
    required String content,
    String? media,
    DateTime? date,
    List<User>? likes,
    List<Comment>? comments,
  })  : _id = AutogenerateUtil().generateId(),
        _author = author,
        _content = content,
        _media = media,
        _date = date ?? _generateRandomDate(),
        _likes = likes ?? [],
        _comments = comments ?? [],
        super();

  void addComment(Comment comment) {
    comment.postParent = this;
    comments.add(comment);
  }

  static DateTime _generateRandomDate() {
    var now = DateTime.now();
    int daysInPast = Random().nextInt(365); // Generate a random number of days (up to 365)
    return now.subtract(Duration(days: daysInPast));
  }

  String get id => _id;
  set id(String value) => _id = value;

  User get author => _author;

  String get content => _content;
  set content(String value) => _content = value;

  String? get media => _media;
  set media(String? value) => _media = value;

  List<User> get likes => _likes ?? [];
  set likes(List<User> value) => _likes = value;

  List<Comment> get comments => _comments ?? [];
  set comments(List<Comment> value) => _comments = value;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;
}
