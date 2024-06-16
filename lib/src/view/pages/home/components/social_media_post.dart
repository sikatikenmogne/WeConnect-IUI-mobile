import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:share_plus/share_plus.dart';

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
      color: Colors.grey[200], // change the card color
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
                    Text(
                      'Username',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('3 hrs ago'),
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
            ),
            (widget.postMediaUrl != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(widget.postMediaUrl!,
                        fit: BoxFit.contain),
                  )
                : Container(),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                  onPressed: toggleLikeStatus,
                ),
                Text('$_likeCount'),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                Text('${_comments.length}'),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: sharePost,
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
                title: Text(comment),
              ),
          ],
        ),
      ),
    );
  }
}
