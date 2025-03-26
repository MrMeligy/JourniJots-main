import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/features/home/presentation/screens/manager/post_cubit/post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/posts_list_view_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<PostCubit>().getPosts();
    return const PostsListView();
  }
}
