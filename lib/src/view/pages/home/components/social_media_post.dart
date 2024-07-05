import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart' as UserModel;
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

import 'comment_page.dart';

class SocialMediaPost extends StatefulWidget {
  final String postText;
  final String imageUrl;
  final DateTime createdAt;
  final UserModel.User author;
  final String? postMediaUrl;

  final List<Comment>? comments;
  SocialMediaPost(
      {required this.postText,
      required this.imageUrl,
      required this.createdAt,
      required this.author,
      this.postMediaUrl = null,
      this.comments});

  @override
  State<SocialMediaPost> createState() => _SocialMediaPostState();
}

class _SocialMediaPostState extends State<SocialMediaPost> {
  bool isLiked = false;
  int _likeCount = 0;
  int _shareCount = 0;
  bool _isCommentSectionVisible = false;

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
      widget.comments?.add(Comment(
          author: UserModel.User.createDefaultUser(),
          content: _commentController.text));
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
                  backgroundImage:
                      NetworkImage(widget.author.profilePicture ?? ''),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonText(
                      text: widget.author.firstname ?? 'Username',
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(text: _timeSince(widget.createdAt)),
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
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                      ),
                      CommonText(text: '$_likeCount'),
                    ],
                  ),
                  onTap: toggleLikeStatus,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.comment),
                      CommonText(text: '${widget.comments!.length}'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _isCommentSectionVisible = !_isCommentSectionVisible;
                    });
                  },
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      CommonText(text: '$_shareCount')
                    ],
                  ),
                  onTap: sharePost,
                ),
              ],
            ),
            Visibility(
              visible: _isCommentSectionVisible,
              child: Column(
                children: [
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment...',
                    ),
                    onSubmitted: (_) => addComment(),
                  ),
                  if (widget.comments != null)
                    for (var comment in widget.comments!)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                comment.author.profilePicture ?? ''),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CommonText(
                                text: comment.author.firstname ?? 'Username',
                                alignment: TextAlign.left,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              CommonText(
                                text: comment.content,
                                alignment: TextAlign.left,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                    child: CommonText(
                                        text: _timeSince(comment.createdAt)),
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isLiked
                                              ? Colors.red
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                        ),
                                        CommonText(text: '$_likeCount'),
                                      ],
                                    ),
                                    onTap: toggleLikeStatus,
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.reply,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary, // Use a theme color
                                        ),
                                        CommonText(text: '1'),
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeSince(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays >= 1) {
      return '${difference.inDays} d';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} h';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} m';
    } else {
      return 'Just now';
    }
  }

  Row newMethod(String comment, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            CommonText(
              text: 'Username',
              alignment: TextAlign.left,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            CommonText(
              text: comment,
              alignment: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: CommonText(text: '3 h'),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked
                            ? Colors.red
                            : Theme.of(context).colorScheme.secondary,
                      ),
                      CommonText(text: '$_likeCount'),
                    ],
                  ),
                  onTap: toggleLikeStatus,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary, // Use a theme color
                      ),
                      CommonText(text: '1'),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
