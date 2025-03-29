import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/post_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostsProfileListView extends StatefulWidget {
  const PostsProfileListView({super.key});

  @override
  State<PostsProfileListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsProfileListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return (state.profileModel.posts != null)
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: state.profileModel.posts!.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      post: state.profileModel.posts![index],
                      profileModel: state.profileModel,
                    );
                  },
                )
              : const Center(child: Text("There is No Posts"));
        }
        if (state is ProfileFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        }
        return Skeletonizer(
          enabled: true,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const PostWidget(post: null);
            },
          ),
        );
      },
    );
  }
}
