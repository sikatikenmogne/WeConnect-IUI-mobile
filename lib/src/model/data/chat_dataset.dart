import 'package:we_connect_iui_mobile/src/model/chat_model.dart';
import 'package:we_connect_iui_mobile/src/model/data/user_dataset.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';

final User defaultUser = User(
  id: "0",
  firstname: 'Default',
  lastname: 'User',
  email: 'default.user@example.com',
  role: Role.learner,
);

final Map<String, Chat> chatDataSet = {
  "1": Chat(
    content: "Hello John, I wanted to check in and see if you received the documents I sent over last week. Please let me know if you have any questions.",
    destinator: userDataSet["1"] ?? defaultUser,
  ),
  "2": Chat(
    content: "Hi Jane, I'm doing well. Just working on a few projects that are keeping me busy. How about you?",
    destinator: userDataSet["2"] ?? defaultUser,
  ),
  "3": Chat(
    content: "Alice, it's been a while since we last caught up. I hope everything is going well with you. Let's plan to meet up sometime soon.",
    destinator: userDataSet["3"] ?? defaultUser,
  ),
  "4": Chat(
    content: "John, are you available for a meeting this afternoon to discuss the new project requirements? It's quite urgent.",
    destinator: userDataSet["1"] ?? defaultUser,
  ),
  "5": Chat(
    content: "Yes, I'll be there. I'll bring the latest updates on the project so we can review them together.",
    destinator: userDataSet["2"] ?? defaultUser,
  ),
  "6": Chat(
    content: "Great to hear! I look forward to catching up and going over the details with you.",
    destinator: userDataSet["3"] ?? defaultUser,
  ),
  "7": Chat(
    content: "What are you up to these days? It's been a busy few months, and I'd love to hear what you've been working on.",
    destinator: userDataSet["2"] ?? defaultUser,
  ),
  "8": Chat(
    content: "I've been working on a new project that involves a lot of research and development. It's challenging but very rewarding.",
    destinator: userDataSet["2"] ?? defaultUser,
  ),
  "9": Chat(
    content: "That sounds interesting! I'd love to hear more about it when we get a chance to catch up.",
    destinator: userDataSet["2"] ?? defaultUser,
  ),
  "10": Chat(
    content: "That sounds interesting! I'd love to hear more about it when we get a chance to catch up.",
    destinator: userDataSet["1"] ?? defaultUser,
  )
};

