import 'package:flutter/material.dart';

class AddPostTextField extends StatelessWidget {
  const AddPostTextField({
    super.key,
    required this.postController,
  });
  final TextEditingController postController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: postController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
        ),
        hintText: "Share Your Experience",
      ),
      maxLines: 10,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Post content can't be empty";
        }
        return null;
      },
    );
  }
}
