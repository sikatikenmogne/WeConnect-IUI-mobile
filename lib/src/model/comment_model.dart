
import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Comment extends AuditModel{
  String _id;
  String _content;
  List<User>? _likes;
  Post _postParent;

  Comment({
    required String content,
    List<User>? likes,
    required Post postParent,
  })  : _id = AutogenerateUtil().generateId(),
        _content = content,
        _likes = likes,
        _postParent = postParent,
        super();

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  List<User>? get likes => _likes;
  set likes(List<User>? value) => _likes = value;

  Post get postParent => _postParent;
  set postParent(Post value) => _postParent = value;
}