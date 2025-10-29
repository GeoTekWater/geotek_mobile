// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// Future<PlatformFile?> getImageFromGallery() async {
//   final ImagePicker picker = ImagePicker();

//   // Show image source selection dialog
//   final XFile? pickedFile = await picker.pickImage(
//     source: ImageSource.gallery, // You can change to gallery or camera
//     imageQuality: 15, // Similar to compression quality
//     maxWidth: 1024, // Optional: limit image width
//     maxHeight: 1024, // Optional: limit image height
//   );

//   if (pickedFile == null) {
//     return null;
//   }

//   debugPrint("[IMAGE-PATH] :: ${pickedFile.path}");
//   debugPrint("[IMAGE-SIZE] :: ${File(pickedFile.path).lengthSync()}");

//   // Optional: additional compression if needed
//   final Directory appDocDir = await getApplicationDocumentsDirectory();
//   final String targetPath = '${appDocDir.path}/${pickedFile.name}';

//   final compressedFile = await FlutterImageCompress.compressAndGetFile(
//     pickedFile.path,
//     targetPath,
//     quality: 15,
//   );

//   if (compressedFile == null) {
//     return null;
//   }

//   File newImage = File(compressedFile.path);

//   PlatformFile platformFile = PlatformFile(
//     name: "avatar",
//     path: newImage.path,
//     size: newImage.lengthSync(),
//   );

//   debugPrint("[COMPRESSED-IMAGE-SIZE] :: ${platformFile.size}");

//   return platformFile;
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Picks an image from camera or gallery, compresses it, and returns a PlatformFile.
Future<PlatformFile?> pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  // Show bottom sheet to select camera or gallery
  final ImageSource? source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (BuildContext ctx) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      );
    },
  );

  if (source == null) return null; // user cancelled

  // Pick the image
  final XFile? pickedFile = await picker.pickImage(
    source: source,
    imageQuality: 15, // compress quality (0–100)
    maxWidth: 1024,
    maxHeight: 1024,
  );

  if (pickedFile == null) return null;

  debugPrint("[IMAGE-PATH] :: ${pickedFile.path}");
  debugPrint("[ORIGINAL-SIZE] :: ${File(pickedFile.path).lengthSync()} bytes");

  // Compress further
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String targetPath = '${appDocDir.path}/${pickedFile.name}';

  final XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
    pickedFile.path,
    targetPath,
    quality: 15,
  );

  if (compressedFile == null) return null;

  final PlatformFile platformFile = PlatformFile(
    name: pickedFile.name,
    path: compressedFile.path,
    size: await compressedFile.length(),
  );

  debugPrint("[COMPRESSED-SIZE] :: ${platformFile.size} bytes");

  return platformFile;
}
