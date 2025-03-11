import 'package:flutter/material.dart';
import 'package:journijots/features/home/presentation/screens/widgets/post_widget.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemBuilder: (context, index) {
          return const PostWidget(
              postContent:
                  "Yesterday, I had the chance to explore El Zamalek, one of Cairo's most charming neighborhoods. "
                  "Known for its laid-back vibe, lush greenery, and artistic spirit, this is one of the best places to visit in Cairo. "
                  "The people are friendly, and the atmosphere is simply amazing.");
        });
  }
}
