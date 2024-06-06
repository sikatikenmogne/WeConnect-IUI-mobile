import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/routes/routes.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/custom_bubble.dart';

import '../../../model/chat_model.dart' as ChatModel;

class ChatPage extends StatefulWidget{
  final String userId;
  const ChatPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late User _currentUser;
  late User otherUser;
  List<types.Message> _messages = [];


  void _loadMessages() async {
  try {
    await ChatModel.Chat.load();
    setState(() {
      _messages = chatData
          .where((chat) => chat.destinator.id == widget.userId || chat.createdBy == User.getById(widget.userId))
          .map((chat) => types.TextMessage(
                author: types.User(id: chat.destinator.id),
                createdAt: chat.createdAt.millisecondsSinceEpoch,
                id: chat.id,
                text: chat.content,
              ))
          .toList();

      _messages = _messages.reversed.toList();
    });
  } catch (e) {
    print('Error loading messages: $e');
  }
}

  void _sendMessage(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: types.User(id: _currentUser.id),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: AutogenerateUtil().generateId(),
      text: message.text
    );

    setState(() => _messages.insert(_messages.length, textMessage));

    // persist data
    try {
    await ChatModel.Chat.create(
      content: message.text,
      destinator: otherUser,
    );
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _currentUser = currentUser!;
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
      body: Chat(        
        messages: _messages, 
        onSendPressed: _sendMessage, 
        user: types.User(id: _currentUser.id),
        bubbleBuilder: _bubbleBuilder        
      ),
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  }) {
    final isCurrentUser = message.author.id == _currentUser.id;
    final color = isCurrentUser ? AppColor.header : AppColor.color2;

    return Container(
      margin: EdgeInsets.only(
        bottom: nextMessageInGroup ? 2 : 5,
        left: isCurrentUser ? 30 : 0,
        right: isCurrentUser ? 0 : 30,
      ),
      child: CustomBubble(
        createdAt: DateTime.fromMillisecondsSinceEpoch(message.createdAt ?? 0),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 15),
        child: Builder(
          builder: (context) {
            return Text(
              message is types.TextMessage ? message.text : ''
            );
          },
        ),
      ),
        color: color,
        isCurrentUser: isCurrentUser,
      ),
    );
  }

}