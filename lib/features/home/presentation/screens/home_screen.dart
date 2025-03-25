import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/home/presentation/screens/manager/post_cubit/post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo_impl.dart';
import 'package:journijots/features/home/presentation/screens/widgets/add_post_button.dart';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';
import 'package:journijots/features/home/presentation/screens/widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 0) {
      // maximum top
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
    if (_scrollController.position.pixels > _lastOffset && _isVisible) {
      // Scrolling down
      setState(() {
        _isVisible = false;
      });
    } else if (_scrollController.position.pixels < _lastOffset && !_isVisible) {
      // Scrolling up
      setState(() {
        _isVisible = true;
      });
    }
    _lastOffset = _scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscaffoldcolor,
      floatingActionButton: AddPostButton(isVisible: _isVisible),
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => PostCubit(getIt<PostRepoImpl>()),
        child: HomeViewBody(
          scrollController: _scrollController,
        ),
      ),
    );
  }
}
