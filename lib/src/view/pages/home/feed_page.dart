import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart' as UserModel;
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/home/add_post_page.dart';

import 'components/social_media_post.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                50)), // Instantiate a concrete subtype of ShapeBorder
        onPressed: () {
          // Implement the action to navigate to the post creation page or show a post creation dialog
          Navigator.pushNamed(
            context,
            AppRoutes.addPost,
          ).then((_) {
            // Optionally, refresh the feed after adding a post
            // You might need to implement a method to refresh the feed
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 50,
        ),
        tooltip: 'Create Post',
      ),
    );
  }
}
