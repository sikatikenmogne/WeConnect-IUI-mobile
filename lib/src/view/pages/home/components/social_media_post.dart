import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:provider/provider.dart';
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
                  if (widget.comments != null && widget.comments!.isNotEmpty)
                    Column(
                      children: widget.comments!.map((comment) {
                        return ChangeNotifierProvider(
                          create: (context) => comment,
                          child: CommentWidget(
                              key: ValueKey(comment.id), comment: comment),
                        );
                      }).toList(),
                    )
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
}

// Extracted widget for a single comment
class CommentWidget extends StatefulWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _isVisible = false;

  final TextEditingController _responseController =
      TextEditingController(); // Step 1

  @override
  void dispose() {
    _responseController
        .dispose(); // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  void addResponse() {
    setState(() {
      widget.comment.responses.add(Comment(
          author: UserModel.User.createDefaultUser(),
          content: _responseController.text));
      print("Response submitted: ${_responseController.text}");
      _responseController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Comment>(builder: (context, comment, child) {
      return Padding(
        padding:
            EdgeInsets.only(left: comment.referedComment == null ? 0.0 : 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(comment.author.profilePicture ?? ''),
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
                    CommentActions(
                      comment: comment,
                      onReplyPressed: () {
                        setState(() {
                          _isVisible =
                              !_isVisible; // Change l'état de visibilité
                        });
                      },
                    ), // Extracted widget for actions
                  ],
                )
              ],
            ),
            Visibility(
                visible: _isVisible,
                child: Column(children: [
                  for (var response in comment.responses)
                    ResponseWidget(response: response),
                  TextField(
                    controller: _responseController,
                    decoration:
                        InputDecoration(hintText: "Write a response..."),
                    onSubmitted: (_) => addResponse,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle the submission of the response
                  //     // For example, you might want to add the response to the comment.responses list
                  //     // and clear the text field
                  //     setState(() {
                  //       comment.responses.add(Comment(
                  //           author: UserModel.User.createDefaultUser(),
                  //           content: _responseController.text));
                  //       print(
                  //           "Response submitted: ${_responseController.text}");
                  //       _responseController.clear();
                  //     });
                  //   },
                  //   child: Text('Submit'),
                  // ),
                ]))
          ],
        ),
      );
    });
  }
}

class ResponseWidget extends StatefulWidget {
  final Comment response;

  const ResponseWidget({Key? key, required this.response}) : super(key: key);

  @override
  State<ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.response.referedComment == null ? 0.0 : 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(widget.response.author.profilePicture ?? ''),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CommonText(
                text: widget.response.author.firstname ?? 'Username',
                alignment: TextAlign.left,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              CommonText(
                text: widget.response.content,
                alignment: TextAlign.left,
              ),
              CommentActions(
                comment: widget.response,
                onReplyPressed: () {
                  setState(() {
                    _isVisible = !_isVisible; // Change l'état de visibilité
                  });
                },
              ), // Extracted widget for actions
            ],
          )
        ],
      ),
    );
  }
}

// Extracted widget for comment actions (like, reply)
class CommentActions extends StatefulWidget {
  final Comment comment;
  final VoidCallback onReplyPressed;

  const CommentActions(
      {Key? key, required this.comment, required this.onReplyPressed})
      : super(key: key);

  @override
  _CommentActionsState createState() => _CommentActionsState();
}

class _CommentActionsState extends State<CommentActions> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
          child: CommonText(text: _timeSince(widget.comment.createdAt)),
        ),
        InkWell(
          child: Row(
            children: [
              Icon(
                widget.comment.likes.any(
                        (user) => user.id == UserModel.User.getCurrentUser().id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.comment.likes.any(
                        (user) => user.id == UserModel.User.getCurrentUser().id)
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
              ),
              CommonText(text: '${widget.comment.likes.length}'),
            ],
          ),
          onTap: () => _toggleLike(widget.comment),
        ),
        InkWell(
          child: Row(
            children: [
              Icon(Icons.reply, color: Theme.of(context).colorScheme.secondary),
              CommonText(
                  text:
                      '${widget.comment.responses.length}'), // Assuming '1' is a placeholder
            ],
          ),
          onTap: widget.onReplyPressed,
        ),
      ],
    );
  }

  void _toggleLike(Comment comment) {
    setState(() {
      if (comment.likes
          .any((user) => user.id == UserModel.User.getCurrentUser().id)) {
        comment.likes.removeWhere(
            (user) => user.id == UserModel.User.getCurrentUser().id);
      } else {
        comment.likes.add(UserModel.User.getCurrentUser());
      }
    });
  }
}
