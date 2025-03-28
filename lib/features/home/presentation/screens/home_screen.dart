import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/home/presentation/screens/manager/post_cubit/post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/manager/repos/post_repo/post_repo_impl.dart';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';
import 'package:journijots/features/home/presentation/screens/widgets/home_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscaffoldcolor,
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => PostCubit(getIt<PostRepoImpl>())..getPosts(1),
        child: const HomeViewBody(),
      ),
    );
  }
}
