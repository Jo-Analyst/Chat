// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const UserImagePicker({
    required this.onImagePick,
    super.key,
  });

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        )
      ],
    );
  }
}
