import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

class Post extends AuditModel {
  String _id;
  String _content;
  String? _media;
  List<User>? _likes;
  List<Comment>? _comments;

  Post._({
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

  static Future<Post> create({
    required String content,
    String? media,
    List<User>? likes,
    List<Comment>? comments,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newPost = Post._(
      id: id,
      content: content,
      media: media,
      likes: likes ?? [],
      comments: comments ?? [],
    );

    final response = await supabaseClient.from("posts").insert({
      "id": id,
      "content": content,
      "media": media,
      "likes": likes?.map((user) => user.id).toList(),
      "comments": comments?.map((comment) => comment.id).toList(),
    });

    if (response.error != null) {
      print('Error inserting post: ${response.error!.message}');
    } else {
      print('Post inserted successfully');
    }

    return newPost;
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get content => _content;
  set content(String value) => _content = value;

  String? get media => _media;
  set media(String? value) => _media = value;

  List<User> get likes => _likes ?? [];
  set likes(List<User> value) => _likes = value;

  List<Comment> get comments => _comments ?? [];
  set comments(List<Comment> value) => _comments = value;
}
