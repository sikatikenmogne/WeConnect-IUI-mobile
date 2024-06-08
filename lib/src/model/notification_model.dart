import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/calendar_model.dart';
import 'package:we_connect_iui_mobile/src/model/chat_model.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';

class Notification extends AuditModel{
  bool _isRead;
  Chat? _chat;
  Post? _post;
  Calendar? _calendar;
  Comment? _comment;

  Notification({
    Chat? chat,
    Post? post,
    Calendar? calendar,
    Comment? comment,
    required DateTime createdAt,
    required User createdBy,
    required DateTime updatedAt,
    required User updatedBy,
  })  : _isRead = false,
        _chat = chat,
        _post = post,
        _calendar = calendar,
        _comment = comment,
        super();

  bool get isRead => _isRead;
  set isRead(bool value) => _isRead = value;

  Chat? get chat => _chat;
  set chat(Chat? value) => _chat = value;

  Post? get post => _post;
  set post(Post? value) => _post = value;

  Calendar? get calendar => _calendar;
  set calendar(Calendar? value) => _calendar = value;

  Comment? get comment => _comment;
  set comment(Comment? value) => _comment = value;
}