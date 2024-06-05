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
      final response = await supabaseClient.from("chats").insert({
        "id": id,
        "content": content,
        "isSent": true,
        "isReceived": false,
        "isRead": false,
        "destinatorId": destinator.id,
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

  static Future<List<Chat>> loadChats() async {
    final user = supabaseClient.auth.currentSession!.user;
        
    List<Chat> chats = [];
    try {
      final response = await supabaseClient.from("chats")
          .select()
          .or('destinatorId.eq.${user.id},createdBy.eq.${user.id}');

      final data = response as List<dynamic>;

      for (var item in data) {
        try {
          final destinatorResponse = await supabaseClient
            .from('users').select().eq('id', item['destinatorId']).single();

          User destinator = User.fromJson(destinatorResponse);

          // Optionally load the parent chat if it exists
          Chat? parentChat;
          if (item['parentChatId'] != null) {
            try {
              final parentChatResponse = await supabaseClient.from('chats').select().eq('id', item['parentChatId']).single();

              parentChat = Chat.fromJson(parentChatResponse);
            } catch (e) {
              print('Exception loading parent chat: $e');
            }
          }

          chats.add(Chat._(
            id: item['id'],
            content: item['content'],
            isSent: item['isSent'],
            isReceived: item['isReceived'],
            isRead: item['isRead'],
            destinator: destinator,
            parentChat: parentChat,
          ));
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
      id: json['id'],
      content: json['content'],
      isSent: json['isSent'],
      isReceived: json['isReceived'],
      isRead: json['isRead'],
      destinator: User.fromJson(json['destinator']), // Assuming User.fromJson exists
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
