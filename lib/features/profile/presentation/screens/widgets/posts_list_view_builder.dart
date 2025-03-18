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
    // Create a list of sample posts for demonstration
    final List<String> samplePosts = [
      "Yesterday, I had the chance to explore El Zamalek, one of Cairo's most charming neighborhoods. "
          "Known for its laid-back vibe, lush greenery, and artistic spirit, this is one of the best places to visit in Cairo. "
          "The people are friendly, and the atmosphere is simply amazing.",
      "Visited the Egyptian Museum today. The collection of ancient artifacts is breathtaking. "
          "Spent hours exploring the different galleries and learning about Egypt's rich history.",
      "Had the most delicious koshari for lunch at a local spot. It's definitely a must-try dish when in Cairo!",
    ];

    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: samplePosts.length,
      itemBuilder: (context, index) {
        return PostWidget(
          postContent: samplePosts[index % samplePosts.length],
        );
      },
    );
  }
}
