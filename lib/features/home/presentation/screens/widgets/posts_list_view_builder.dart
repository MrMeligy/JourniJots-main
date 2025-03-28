import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/features/home/presentation/screens/manager/post_cubit/post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/post_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostsListView extends StatefulWidget {
  const PostsListView({super.key});

  @override
  State<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    final postCubit = context.read<PostCubit>();
    final currentState = postCubit.state;

    if (_isLoadingMore) return;

    if (currentState is GetPostsSuccessfully) {
      _isLoadingMore = true;
      _currentPage++;

      // 🔹 حفظ موضع التمرير الحالي قبل تحميل المزيد من البيانات
      double previousScrollOffset = _scrollController.offset;

      postCubit.getPosts(_currentPage, loadMore: true).then((_) {
        _isLoadingMore = false;
        // 🔹 بعد تحميل البيانات، إعادة التمرير إلى الموضع السابق
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(previousScrollOffset);
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is GetPostsSuccessfully) {
          _isLoadingMore = false;
        }
        if (state is GetPostsFailure) {
          _isLoadingMore = false;
        }
      },
      builder: (context, state) {
        if (state is GetPostsSuccessfully) {
          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: state.posts.length + (_isLoadingMore ? 5 : 0),
            itemBuilder: (context, index) {
              if (index < state.posts.length) {
                return PostWidget(post: state.posts[index]);
              } else {
                return const Skeletonizer(
                  enabled: true,
                  child: PostWidget(post: null),
                );
              }
            },
          );
        }
        if (state is GetPostsFailure) {
          return Center(
            child: Text(state.errMessag),
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
