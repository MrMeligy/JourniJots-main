import 'package:flutter/material.dart';
import 'package:journijots/features/home/presentation/screens/widgets/posts_list_view_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return PostsListView(scrollController: _scrollController);
  }
}
