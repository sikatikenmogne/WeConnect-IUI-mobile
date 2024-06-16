import 'package:flutter/material.dart';

import 'social_media_post.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SocialMediaPost(
              postText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              imageUrl:
                  'https://yojnxscjecnlltwblvrn.supabase.co/storage/v1/object/public/post_images/Image_placeholder.svg.png?t=2024-06-07T19%3A20%3A51.928Z',
              postMediaUrl:
                  'https://yojnxscjecnlltwblvrn.supabase.co/storage/v1/object/public/post_images/Image_placeholder.svg.png?t=2024-06-07T19%3A20%3A51.928Z');
        },
      ),
    );
  }
}
