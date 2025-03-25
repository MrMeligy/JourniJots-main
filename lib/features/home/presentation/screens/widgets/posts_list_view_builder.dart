import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/features/home/presentation/screens/manager/post_cubit/post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/post_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is GetPostsLoading) {}
      },
      builder: (context, state) {
        if (state is GetPostsSuccessfully) {
          return ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return PostWidget(
                  post: state.posts[index],
                );
              });
        }
        if (state is GetPostsFailure) {
          return Center(
            child: Text(state.errMessag),
          );
        }
        return Skeletonizer(
          enabled: true,
          child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: 5, // عدد العناصر الوهمية
              itemBuilder: (context, index) {
                return const PostWidget(
                  post: null, // سيتحول تلقائيًا إلى skeleton
                );
              }),
        );
      },
    );
  }
}
