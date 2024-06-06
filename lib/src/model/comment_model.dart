import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';
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
    required Post? postParent,
  }) : 
        _id= id,
        _content = content,
        _likes = likes,
        _postParent = postParent,
        super();
  // Comment._({
  //   required String id,
  //   required String content,
  //   List<User>? likes,
  //   required Post postParent,
  // })  : _id = id,
  //       _content = content,
  //       _likes = likes,
  //       _postParent = postParent,
  //       super();

  // static Future<Comment> create({
  //   required String content,
  //   List<User>? likes,
  //   required Post postParent,
  // }) async {
  //   final id = AutogenerateUtil().generateId();
  //   final newComment = Comment._(
  //     id: id,
  //     content: content,
  //     likes: likes,
  //     postParent: postParent,
  //   );

  //   try {
  //     final response = await supabaseClient.from("comments").insert({
  //       "id": id,
  //       "content": content,
  //       "postParentId": postParent.id,
  //       "likes": likes?.map((user) => user.id).toList(),
  //     });

  //     if (response.error != null) {
  //       print('Error inserting comment: ${response.error!.message}');
  //     } else {
  //       print('Comment inserted successfully');
  //     }
  //   } catch (e) {
  //     print('Exception inserting comment: $e');
  //   }

  //   return newComment;
  // }
  // factory Comment.fromJson(Map<String, dynamic> json, Post postParent) {
  //   return Comment._(
  //     id: json['id'],
  //     content: json['content'],
  //     likes: json['likes'] != null
  //       ? (json['likes'] as List).map((like) => User.fromJson(like)).toList()
  //       : null,
  //     postParent: postParent,
  //   );
  // }


  static Future<List<Comment>> load() async {
      try {
        // Post.load();
        final data = await supabaseClient
            .from("comment")
            .select();

        List<Comment> comments = data
            .map((commentData) =>  Comment.fromMap(commentData))
            .toList();
        print("Comments: $comments");
        commentData = comments;
        return comments;
            } catch (e) {
        print('Exception loading comments: $e');
        return [];
      }
  }

  static Comment? getById(String id) {
    if(commentData != null) {
      for (var comment in commentData!) {
        if (comment.id == id) {
          return comment;
        }
      }
    }
  }

  // static Future<Comment?> getById(String id) async {
  //   try {
  //     final data = await supabaseClient
  //        .from("comment")
  //        .select()
  //        .eq("id", id)
  //        .single();
  //   } catch (e) {
  //     print('Exception loading comment: $e');
  //     return null;
  //   }
  // }

  static Comment fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      content: map['content'] as String,
      likes: map['likes'] as List<User>?,
      postParent: Post.getById(map['postParent'] as String)
    );
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
