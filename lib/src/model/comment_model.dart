import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

class Comment extends AuditModel {
  late String _id;
  String _content;
  List<User>? _likes;
  Post? _postParent;

  Comment({
    required String id,
    required String content,
    List<User>? likes,
    Post? postParent,
  })  : _id = id,
        _content = content,
        _likes = likes,
        _postParent = postParent,
        super();

  factory Comment.fromJson(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      content: map['content'] as String,
      likes: (map['likes'] as List<dynamic>?)
          ?.map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList(),
      postParent: map['post_parent'] != null
          ? Post.fromJson(map['post_parent'] as Map<String, dynamic>)
          : null,
    );
  }

  static Future<List<Comment>> load() async {
    List<Comment> commentData = [];
    try {
      final response = await supabaseClient.from("comments").select();

      final data = response as List<dynamic>;
      for (var item in data) {
        commentData.add(Comment.fromJson(item));
      }
    } catch (e) {
      print("Error loading comments: $e");
    }

    return commentData;
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  List<User>? get likes => _likes;
  set likes(List<User>? value) => _likes = value;

  Post? get postParent => _postParent;
  set postParent(Post? value) => _postParent = value;
}
