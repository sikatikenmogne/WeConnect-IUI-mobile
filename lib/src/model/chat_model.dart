import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Chat extends AuditModel{
  String _id;
  String _content;
  bool _isSent;
  bool _isReceived;
  bool _isRead;
  User _destinator;
  Chat? _parentChat;
  
  Chat({
    String? id,
    required String content,
    required User destinator,
    bool? isRead,
    Chat? parentChat,
  })  : _id = (id == null) ? AutogenerateUtil().generateId() : id,
        _content = content,
        _isSent = true,
        _isReceived = false,
        _isRead = isRead ?? false,
        _destinator = destinator,
        _parentChat = parentChat, 
        super();

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  bool get isSent => _isSent;
  set isSent(bool value) => _isSent = value;

  bool get isReceived => _isReceived;
  set isReceived(bool value) => _isReceived = value;

  bool get isRead => _isRead;
  set isRead(bool value) => _isRead = value;

  User get destinator => _destinator;
  set destinator(User value) => _destinator = value;

  Chat? get parentChat => _parentChat;
  set parentChat(Chat? value) => _parentChat = value;
}