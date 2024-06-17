import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

import 'comment_page.dart';

class SocialMediaPost extends StatefulWidget {
  final String postText;
  final String imageUrl;

  final String? postMediaUrl;

  SocialMediaPost(
      {required this.postText,
      required this.imageUrl,
      this.postMediaUrl = null});

  @override
  State<SocialMediaPost> createState() => _SocialMediaPostState();
}

class _SocialMediaPostState extends State<SocialMediaPost> {
  bool isLiked = false;
  int _likeCount = 0;
  int _shareCount = 0;

  final _commentController = TextEditingController();
  final _comments = <String>[];

  void toggleLikeStatus() {
    setState(() {
      if (isLiked) {
        _likeCount--;
      } else {
        _likeCount++;
      }
      isLiked = !isLiked;
    });
  }

  void sharePost() {
    Share.share(widget.postText);
    setState(() {
      _shareCount++;
    });
  }

  void openCommentPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CommentPage()));
  }

  void addComment() {
    setState(() {
      _comments.add(_commentController.text);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor, // change the card color
      elevation: 5, // change the card elevation
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonText(
                      text: 'Username',
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(text: '3 hrs ago'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ExpandableText(
              widget.postText,
              readMoreText: 'show more',
              readLessText: 'show less',
              trim: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color!,
              ),
            ),
            (widget.postMediaUrl != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Expanded(
                        child: Container(
                            color: Colors.red,
                            child: CachedNetworkImage(
                              imageUrl: widget.postMediaUrl!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              width: 350,
                              height: 150,
                              fit: BoxFit.cover,
                            ))),
                  )
                : Container(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                      ),
                      onPressed: toggleLikeStatus,
                    ),
                    CommonText(text: '$_likeCount'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    CommonText(text: '${_comments.length}'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: sharePost,
                    ),
                    CommonText(text: '$_shareCount'),
                  ],
                ),
              ],
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment...',
              ),
              onSubmitted: (_) => addComment(),
            ),
            for (var comment in _comments)
              ListTile(
                title: CommonText(text: comment),
              ),
          ],
        ),
      ),
    );
  }
}
