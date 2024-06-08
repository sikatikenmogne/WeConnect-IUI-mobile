import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Your comment',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              child: Text('Post comment'),
              onPressed: () {
                // Handle posting the comment here
              },
            ),
          ],
        ),
      ),
    );
  }
}
