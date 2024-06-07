import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

class Post extends AuditModel {
  String _id;
  String _content;
  String? _media;
  List<User>? _likes;
  List<Comment>? _comments;

  Post({
    required String id,
    required String content,
    String? media,
    List<User>? likes,
    List<Comment>? comments,
  })  : _id = id,
        _content = content,
        _media = media,
        _likes = likes,
        _comments = comments,
        super();

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      content: map['content'] as String,
      media: map['media'] as String?,
      likes: (map['likes'] as List<dynamic>?)
          ?.map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList(),
      comments: (map['comments'] as List<dynamic>?)
          ?.map((item) => Comment.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  static Future<List<Post>> load() async {
    try {
      final response = await supabaseClient.from("posts").select();

      final data = response as List<dynamic>;
      for (var item in data) {
        postData.add(Post.fromJson(item));
      }
    } catch (e) {
      print("Error loading posts: $e");
    }

    return postData;
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  String? get media => _media;
  set media(String? value) => _media = value;

  List<User>? get likes => _likes;
  set likes(List<User>? value) => _likes = value;

  List<Comment>? get comments => _comments;
  set comments(List<Comment>? value) => _comments = value;
}
