import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/features/home/presentation/screens/manager/comment_cubit/comment_cubit.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/comment_repo/comment_repo_impl.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/posts_profile_list_view.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit(getIt<CommentRepoImpl>()),
      child: const PostsProfileListView(),
    );
  }
}
