import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb

import '../../components/app_header.dart';
import '../../components/header_text.dart';
// Import any other packages you might need, such as image_picker for picking images

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _postController = TextEditingController();
  File? _image; // Variable to hold the selected image
  File? _video; // Variable to hold the selected video
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added line

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    // Dispose other controllers if any
    super.dispose();
  }

  void _submitPost() {
    // Implement the logic to submit the post
    // This might involve validating the input and calling an API to save the post
    Navigator.pop(context); // Go back to the previous page after submitting
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppHeader(
          title: HeaderText(
            "Add Post",
            fontSize: 25,
          ),
          leading: null,
          height: screenHeight,
          width: screenWidth),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey, // You need to define this key in your state class
              child: TextFormField(
                controller: _postController,
                decoration: InputDecoration(hintText: 'Enter your post here'),
                maxLines: null, // Allow multiple lines
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null; // Return null if the input is valid
                },
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.displayMedium!.color!,
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: _pickImage,
                child: Text(
                  (_image == null) ? 'Pick Image' : 'Update Image',
                ),
              ),
            ),

            if (_image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350, // Largeur maximale
                  height: 250, // Hauteur maximale
                  child: ClipRect(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: kIsWeb
                          ? Image.network(_image!
                              .path) // Utiliser Image.network pour le web
                          : Image.file(
                              _image!), // Utiliser Image.file pour non-web
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Ajoute des bords arrondis au cadre
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ), // Use Image.file for non-web
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.send), // Add an icon
                label: Text('Submit Post'),
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0), // Padding
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
