import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<PlatformFile?> getImageFromGallery() async {
  final ImagePicker picker = ImagePicker();

  // Show image source selection dialog
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.gallery, // You can change to gallery or camera
    imageQuality: 15, // Similar to compression quality
    maxWidth: 1024, // Optional: limit image width
    maxHeight: 1024, // Optional: limit image height
  );

  if (pickedFile == null) {
    return null;
  }

  debugPrint("[IMAGE-PATH] :: ${pickedFile.path}");
  debugPrint("[IMAGE-SIZE] :: ${File(pickedFile.path).lengthSync()}");

  // Optional: additional compression if needed
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String targetPath = '${appDocDir.path}/${pickedFile.name}';

  final compressedFile = await FlutterImageCompress.compressAndGetFile(
    pickedFile.path,
    targetPath,
    quality: 15,
  );

  if (compressedFile == null) {
    return null;
  }

  File newImage = File(compressedFile.path);

  PlatformFile platformFile = PlatformFile(
    name: "avatar",
    path: newImage.path,
    size: newImage.lengthSync(),
  );

  debugPrint("[COMPRESSED-IMAGE-SIZE] :: ${platformFile.size}");

  return platformFile;
}
