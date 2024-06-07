import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/routes/routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/custom_bubble.dart';

import '../../../model/chat_model.dart' as ChatModel;

class ChatPage extends StatefulWidget{
  final String userId;
  const ChatPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late User otherUser;
  List<ChatModel.Chat> _chats = [];


  void _loadMessages() async {
    try {
      await ChatModel.Chat.load();
      setState(() {
        _chats = chatData
            .where((chat) => chat.destinator.id == widget.userId || chat.createdBy!.id == widget.userId)
            .toList();
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  void _sendMessage(String message, Chat? parentChat) async {
    final ChatModel.Chat _chat = ChatModel.Chat(
      content: message,
      destinator: otherUser,
    ); 

    setState(() => chatData.add(_chat));

    // persist data
    try {
      await ChatModel.Chat.create(
        content: message,
        destinator: otherUser
      );
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserAndSettings();
    otherUser = User.getById(widget.userId)!;
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 20,
        shadowColor: Colors.black,
        titleSpacing: -width*.02,
        backgroundColor: AppColor.color2,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.black),
            onPressed: () => Navigator.pushNamed(context, Routes.chatHome)),
        ),
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: height/width*12,
              backgroundImage: otherUser.profilePicture != null
                ? AssetImage(otherUser.profilePicture!,)
                : null,
              child: otherUser.profilePicture == null
                ? Icon(Icons.contact_emergency)
                : null,
            ),
            Text(
              " ${otherUser.firstname} ${otherUser.firstname} ",
              style: TextStyle(color: AppColor.black, fontSize: 20),
            ),
            Text(
              (otherUser.promotion == null) ? "" : "(${otherUser.promotion})",
              style: TextStyle(color: AppColor.tertiary, fontSize: 20),
            ),
          ],
        ),
        actions: [Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.1),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: AppColor.black,),
                onPressed: () {}
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: AppColor.black,),
                onPressed: () {}
              ),
            ],
          ))],
      ),
      body: ListView.builder(
        reverse: true, // Reverse the order of the list
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final message = _chats[index];
          final nextMessageInGroup = index < _chats.length - 1 &&
              _chats[index + 1].createdBy?.id == message.createdBy?.id;
      
          return _bubbleBuilder(
            chat: message,
            child: Text(
              message.content,
              style: TextStyle(color: Colors.black), // Customize text style as needed
            ),
            nextMessageInGroup: nextMessageInGroup,
          );
        },
      )

    );
  }

  Widget _bubbleBuilder({
    required ChatModel.Chat chat,
    required Widget child,
    required bool nextMessageInGroup,
  }) {
    final isCurrentUser = chat.createdBy!.id == currentUser!.id;
    final color = isCurrentUser ? AppColor.header : AppColor.color2;

    return Container(
      margin: EdgeInsets.only(
        bottom: nextMessageInGroup ? 2 : 5,
        left: isCurrentUser ? 30 : 0,
        right: isCurrentUser ? 0 : 30,
      ),
      child: CustomBubble(
        createdAt: chat.createdAt,
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 15),
          child: child,
        ),
        color: color,
        isCurrentUser: isCurrentUser,
      ),
    );
  }

}