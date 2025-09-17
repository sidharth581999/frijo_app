import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFeedsScreen extends StatelessWidget {
  AddFeedsScreen({super.key});

  final ValueNotifier<File?> videoFile = ValueNotifier<File?>(null);
  final ValueNotifier<File?> thumbnailFile = ValueNotifier<File?>(null);

  final ImagePicker picker = ImagePicker();

  /// Pick video
  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile.value = File(pickedFile.path);
    }
  }

  /// Pick image (thumbnail)
  Future<void> pickThumbnail() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      thumbnailFile.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "Add Feeds",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.red, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                // TODO: upload video + thumbnail + description
              },
              child: const Text(
                "Share Post",
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Video Upload Box
            ValueListenableBuilder<File?>(
              valueListenable: videoFile,
              builder: (context, file, _) {
                return GestureDetector(
                  onTap: pickVideo,
                  child: _uploadBox(
                    child: file == null
                        ? _uploadContent(
                            Icons.video_library_outlined,
                            "Select a video from Gallery",
                          )
                        : const Icon(Icons.check_circle,
                            color: Colors.green, size: 40),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            /// Thumbnail Upload Box
            ValueListenableBuilder<File?>(
              valueListenable: thumbnailFile,
              builder: (context, file, _) {
                return GestureDetector(
                  onTap: pickThumbnail,
                  child: _uploadBox(
                    child: file == null
                        ? _uploadContent(
                            Icons.image_outlined, "Add a Thumbnail")
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(file,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            /// Description
            const Text(
              "Add Description",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Write something about your post...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Divider(color: Colors.white24, height: 32),

            /// Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Categories This Project",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "View All",
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _chip("Physics"),
                _chip("Artificial Intelligence"),
                _chip("Mathematics"),
                _chip("Chemistry"),
                _chip("Micro Biology"),
                _chip("Lorem ipsum dolor sit gre"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Upload box
  Widget _uploadBox({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Center(child: child),
    );
  }

  /// Upload content (icon + text)
  Widget _uploadContent(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white54, size: 36),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  /// Category chip
  static Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}
