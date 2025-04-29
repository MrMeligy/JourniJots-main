import 'package:flutter/material.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/actions/data/presentation/screens/widgets/add_post_text_feild.dart';
import 'package:journijots/features/actions/data/presentation/screens/widgets/post_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      // You can proceed to submit the post
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        centerTitle: true,
        foregroundColor: kprimarycolor,
        shadowColor: Colors.black,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  AddPostTextField(
                    postController: _postController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const PostButton(
                        text: "Add Images +",
                        iconData: Icons.image,
                      ),
                      PostButton(
                        text: "Post Your Journy",
                        iconData: Icons.send,
                        onTap: _submitPost,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
