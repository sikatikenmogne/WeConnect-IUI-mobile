import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart' as UserModel;

import 'social_media_post.dart';

class FeedPage extends StatefulWidget {
  final List<Post> posts; // Make posts non-nullable

  FeedPage({required this.posts}); // Initialize posts in the constructor

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.posts.length, // Directly access length
        itemBuilder: (context, index) {
          var post = widget.posts[index]; // Directly access the post
          // Ensure null checks or provide default values for nullable fields
          return SocialMediaPost(
            postText: post.content ??
                'No content', // Provide a default value or ensure non-null
            imageUrl:
                post.author.profilePicture ?? '', // Handle nullable author
            postMediaUrl: post.media,
            createdAt: post.createdAt,
            author: post.author,
            comments: post.comments,
          ); // Provide a default value or handle nullable createdBy
        },
      ),
    );
  }
}
