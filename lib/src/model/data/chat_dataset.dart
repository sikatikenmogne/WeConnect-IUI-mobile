// import 'package:we_connect_iui_mobile/src/model/chat_model.dart';
// import 'package:we_connect_iui_mobile/src/model/data/user_dataset.dart';
// import 'package:we_connect_iui_mobile/src/model/user_model.dart';
// import 'package:we_connect_iui_mobile/src/model/role_model.dart';
// import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

// final User defaultUser = User(
//   id: "0",
//   firstname: 'Default',
//   lastname: 'User',
//   email: 'default.user@example.com',
//   role: Role.learner,
// );

// Map<String, Chat> chatDataSet = {};

// Future<void> loadChatsFromSupabase() async {
//   final response = await supabaseClient.from('chats').select().execute();

//   if (response.error != null) {
//     print('Error loading chats: ${response.error!.message}');
//     return;
//   }

//   for (var chatData in response.data) {
//     final chat = Chat(
//       id: chatData['id'],
//       content: chatData['content'],
//       destinator: userDataSet[chatData['destinator_id']] ?? defaultUser,
//       isRead: chatData['is_read'],
//       parentChat: chatData['parent_chat_id'] != null ? chatDataSet[chatData['parent_chat_id']] : null,
//     );
//     chatDataSet[chat.id] = chat;
//   }
// }