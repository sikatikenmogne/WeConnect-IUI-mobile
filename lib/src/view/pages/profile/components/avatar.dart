import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'profile_text.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    super.key,
    required this.imageUrl,
    required this.onUpload,
    this.editMode = true,
    this.data,
  });

  final String? imageUrl;

  final void Function(String) onUpload;
  final bool editMode;
  final Map<String, String>? data;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.imageUrl;
    return Column(
      children: [
        if (imageUrl == null || imageUrl.isEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: CommonText(
                  text: AppLocalizations.of(context)!.noImage,
                  fontFamily: AppFonts.FontFamily_RedHatDisplay,
                  color: AppColor.color3,
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        else
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        widget.editMode == true
            ? TextButton(
                onPressed: _isLoading ? null : _upload,
                child: CommonText(
                  text: AppLocalizations.of(context)!.changePicture,
                  fontFamily: AppFonts.FontFamily_RedHatDisplay,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    (widget.data != null && widget.data!['username'] != null)
                        ? ProfileText(widget.data!['username']!)
                        : ProfileText(''),
                    (widget.data != null && widget.data!['promotion'] != null)
                        ? ProfileText(widget.data!['promotion']!,
                            color: AppColor.tertiary)
                        : ProfileText(''),
                  ],
                ),
              ),
      ],
    );
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    try {
      final imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
      );
      // rest of your code...

      if (imageFile == null) {
        return;
      }
      setState(() => _isLoading = true);

      try {
        final bytes = await imageFile.readAsBytes();
        final fileExt = imageFile.path.split('.').last;
        final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
        final filePath = fileName;
        await supabaseClient.storage.from('avatars').uploadBinary(
              filePath,
              bytes,
              fileOptions: FileOptions(contentType: imageFile.mimeType),
            );
        final imageUrlResponse = await supabaseClient.storage
            .from('avatars')
            .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
        widget.onUpload(imageUrlResponse);
      } on StorageException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CommonText(
                  text: error.message,
                  fontFamily: AppFonts.FontFamily_RedHatDisplay),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Unexpected error occurred'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }

      setState(() => _isLoading = false);
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
