import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/screens/widgets/trip_widget.dart';
import 'package:journijots/features/trip/presentation/screens/trip_places.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TripsViewBody extends StatelessWidget {
  final ScrollController scrollController;

  const TripsViewBody({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state is ProfileSuccess)
            ? (state.profileModel.trips!.isEmpty)
                ? const Center(
                    child: Text('No Trips Added'),
                  )
                : ListView.builder(
                    itemCount: state.profileModel.trips!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0.h, horizontal: 16.0.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripPlacesScreen(
                                        city: state
                                            .profileModel.trips![index].city!,
                                        tripId: state
                                            .profileModel.trips![index].id!,
                                      )),
                            );
                          },
                          child: TripWidget(
                            city: state.profileModel.trips![index].city!,
                            date: state.profileModel.trips![index].startDate!,
                          ),
                        ),
                      );
                    })
            : Skeletonizer(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TripSkeletonizer();
                    }),
              );
      },
    );
  }
}

class TripSkeletonizer extends StatelessWidget {
  const TripSkeletonizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage("assets/images/alex.png"),
                fit: BoxFit.cover,
              )),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        Container(
          decoration: const BoxDecoration(
            color: kprimarycolor,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.12,
        ),
      ],
    );
  }
}
