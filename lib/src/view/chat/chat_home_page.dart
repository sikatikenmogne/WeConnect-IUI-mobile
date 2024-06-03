import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/model/chat_model.dart';
import 'package:we_connect_iui_mobile/src/model/data/chat_dataset.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);
  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  late Map<String, List<Chat>> groupedChatsByUsername;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    groupChatsByUsername();
  }

  void groupChatsByUsername() {
    groupedChatsByUsername = {};
    for (var chat in chatDataSet.values) {
      String username = '${chat.destinator.firstname} ${chat.destinator.lastname}';
      if (!groupedChatsByUsername.containsKey(username)) {
        groupedChatsByUsername[username] = [];
      }
      groupedChatsByUsername[username]!.add(chat);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (dateTime.isAfter(today)) {
      return DateFormat.Hm().format(dateTime);
    } else {
      return DateFormat.Md().format(dateTime);
    }
  }

  void navigateToChat(String userId) {
    Navigator.pushNamed(context, '/chat/chat_message', arguments: userId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        // titleSpacing: ,
        backgroundColor: AppColor.header,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04),
          child: IconButton(
            icon: Icon(Icons.menu, color: AppColor.black, size: height/width*25),
            onPressed: () {},
          ),
        ),
        title: Text("Chats", style: TextStyle(color: AppColor.black),),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.04),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.search, color: AppColor.black,),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: AppColor.black,),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groupedChatsByUsername.length,
        itemBuilder: (context, index) {
          String username = groupedChatsByUsername.keys.elementAt(index);
          List<Chat> chats = groupedChatsByUsername[username]!;
          Chat lastChat = chats.last;

          int unreadCount = chats.where((msg) => !msg.isRead).length;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: width * .008),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: width * .06),
              onTap: () {
                navigateToChat(lastChat.destinator.id);
              },
              tileColor: AppColor.inputText.withOpacity(.2),
              leading: CircleAvatar(
                backgroundImage: lastChat.destinator.profilePicture != null
                  ? AssetImage(lastChat.destinator.profilePicture!)
                  : null,
                child: lastChat.destinator.profilePicture == null
                  ? Icon(Icons.contact_emergency)
                  : null,
              ),
              title: Text(
                username,
                style: const TextStyle(fontSize: 18, color: AppColor.black),
              ),
              subtitle: Text(
                lastChat.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: AppColor.tertiary, fontSize: 12),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatDateTime(lastChat.createdAt),
                    style: TextStyle(color: AppColor.tertiary, fontSize: 12),
                  ),
                  if (unreadCount > 0)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColor.header,
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
