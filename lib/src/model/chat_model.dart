import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

class Chat extends AuditModel {
  String _id;
  String _content;
  bool _isSent;
  bool _isReceived;
  bool _isRead;
  User _destinator;
  Chat? _parentChat;

  Chat({
    required String id,
    required String content,
    required bool isSent,
    required bool isReceived,
    required bool isRead,
    required User destinator,
    Chat? parentChat,
    User? createdBy, 
    DateTime? createdAt
  })  : _id = id,
        _content = content,
        _isSent = isSent,
        _isReceived = isReceived,
        _isRead = isRead,
        _destinator = destinator,
        _parentChat = parentChat,
        super(createdAt: createdAt, createdBy: createdBy);
  static Future<Chat> create({
    required String content,
    bool? isSent,
    bool? isReceived,
    bool? isRead,
    required User destinator,
    Chat? parentChat,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newChat = Chat(
      id: id,
      content: content,
      isSent: isSent ?? true,
      isReceived: isReceived ?? false,
      isRead: isRead ?? false,
      destinator: destinator,
      parentChat: parentChat,
    );

    final response = await supabaseClient.from("chats").insert({
      "id": id,
      "content": content,
      "is_sent": isSent,
      "is_received": isReceived,
      "is_read": isRead,
      "destinator_id": destinator.id,
      "parent_chat_id": parentChat?.id,
      "created_by": AuditModel().createdBy
    });

    if (response.error != null) {
      print('Error inserting chat: ${response.error!.message}');
    } else {
      print('Chat inserted successfully');
    }

    return newChat;
  }

  static Future<List<Chat>> load() async {
    final user = await supabaseClient.auth.currentSession!.user;

    try {
      final response = await supabaseClient.from("chat").select()
          .or('destinator_id.eq.${user.id},created_by.eq.${user.id}');

      final data = response as List<dynamic>;
      for (var item in data) {

        chatData.add(Chat.fromJson(item));
      }
    } catch (e) {
      print("Error loading chats: $e");
    }
    return chatData;
  }

  static Chat? getById(String id) {
    for (var chat in chatData) {
      if (chat.id == id) {
        return chat;
      }
    }
    return null;
  }

  factory Chat.fromJson(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as String,
      content: map['content'] as String,
      isSent: map['is_sent'] as bool,
      isReceived: map['is_received'] as bool,
      isRead: map['is_read'] as bool,
      destinator: User.getById(map['destinator_id'] as String)!,
      parentChat: map['parent_chat_id'] != null
          ? Chat.getById(map['parent_chat_id'] as String)
          : null,
      createdBy: User.getById("created_by"),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

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
  set parentChat(Chat? value) => _parentChat;
}
