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

  Chat._({
    required String id,
    required String content,
    required bool isSent,
    required bool isReceived,
    required bool isRead,
    required User destinator,
    Chat? parentChat,
  })  : _id = id,
        _content = content,
        _isSent = isSent,
        _isReceived = isReceived,
        _isRead = isRead,
        _destinator = destinator,
        _parentChat = parentChat,
        super();

  static Future<Chat> create({
    required String content,
    required User destinator,
    bool isRead = false,
    Chat? parentChat,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newChat = Chat._(
      id: id,
      content: content,
      isSent: true,
      isReceived: false,
      isRead: isRead,
      destinator: destinator,
      parentChat: parentChat,
    );

    try {
      final response = await supabaseClient.from("chat").insert({
        "id": id,
        "content": content,
        "is_sent": true,
        "is_received": false,
        "is_read": isRead,
        "destinator_id": destinator.id,
        "created_by": AuditModel().createdBy,
        "parent_chat_id": parentChat?.id,
      });

      if (response.error != null) {
        print('Error inserting chat: ${response.error!.message}');
      } else {
        print('Chat inserted successfully');
      }
    } catch (e) {
      print('Exception inserting chat: $e');
    }

    return newChat;
  }

  static Future<List<Chat>> load() async {
    final user = await supabaseClient.auth.currentSession!.user;
        
    List<Chat> chats = [];
    try {
      final response = await supabaseClient.from("chat")
          .select()
          .or('destinator_id.eq.${user.id},created_by.eq.${user.id}');

      final data = response as List<dynamic>;

      for (var item in data) {
        try {
          final destinatorResponse = await supabaseClient
            .from('users').select().eq('id', item['destinator_id']).single();
            

          // User destinator = User.fromJson(destinatorResponse);
          print("==============================================");
          print("data: $destinatorResponse");
          print("==============================================");
          print("destinator: ${await User.fromMap(destinatorResponse) }");
          print("==============================================");
          print("==============================================");

          // Optionally load the parent chat if it exists
          // Chat? parentChat;
          // if (item['parentChatId'] != null) {
          //   try {
          //     final parentChatResponse = await supabaseClient.from('chat').select().eq('id', item['parent_chat_id']).single();

          //     parentChat = Chat.fromJson(parentChatResponse);
          //   } catch (e) {
          //     print('Exception loading parent chat: $e');
          //   }
          // }

          // chats.add(Chat._(
          //   id: item['id'],
          //   content: item['content'],
          //   isSent: item['is_ent'],
          //   isReceived: item['is_received'],
          //   isRead: item['is_read'],
          //   destinator: destinator,
          //   parentChat: parentChat,
          // ));
        } catch (e) {
          print('Exception loading destinator user: $e');
        }
      }
    } catch (e) {
      print('Exception loading chats: $e');
    }

    return chats;
  }


  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat._(
      id: json['id'] as String,
      content: json['content'] as String,
      isSent: json['is_sent'] as bool,
      isReceived: json['isReceived'] as bool,
      isRead: json['isRead'] as bool,
      destinator: User.fromJson(json['destinator']), 
      parentChat: json['parentChat'] != null ? Chat.fromJson(json['parentChat']) : null,
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
