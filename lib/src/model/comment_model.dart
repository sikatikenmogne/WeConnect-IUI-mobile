import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Comment extends ChangeNotifier {
  String _id;
  User _author;
  String _content;
  List<User> _likes = [];
  Post? _postParent;
  List<Comment> _responses = [];
  Comment? _referedComment;
  DateTime _date; // Added date attribute

  DateTime _createdAt;
  User? _createdBy;
  DateTime _updatedAt;
  User? _updatedBy;

  Comment({
    required User author,
    required String content,
    DateTime? date,
    List<User>? likes,
    Post? postParent,
    Comment? referedComment,
  })  : _id = AutogenerateUtil().generateId(),
        _content = content,
        _date = date ?? _generateRandomDate(),
        _postParent = postParent,
        _author = author,
        _referedComment = referedComment,
        _createdAt = DateTime.now(),
        _updatedAt = DateTime.now(),
        super();

  List<Comment> get responses => _responses;

  void addResponse(Comment comment) {
    comment._referedComment = this;
    _responses.add(comment);
  }

  static DateTime _generateRandomDate() {
    var now = DateTime.now();
    int daysInPast =
        Random().nextInt(365); // Generate a random number of days (up to 365)
    return now.subtract(Duration(days: daysInPast));
  }

  void toggleLike(User userId) {
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    notifyListeners();
  }

  Comment? get referedComment => _referedComment;
  set setReferedComment(Comment comment) => _referedComment = comment;

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  List<User> get likes => _likes;
  set likes(List<User> value) => _likes = value;

  Post? get postParent => _postParent;
  set postParent(Post? value) => _postParent = value;

  User get author => _author;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;

  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) => _createdAt = value;

  User? get createdBy => _createdBy;
  set createdBy(User? value) => _createdBy = value;

  DateTime get updatedAt => _updatedAt;
  set updatedAt(DateTime value) => _updatedAt = value;

  User? get updatedBy => _updatedBy;
  set updatedBy(User? value) => _updatedBy = value;
}
