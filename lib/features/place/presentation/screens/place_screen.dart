import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:journijots/core/api/dio_consumer.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/widgets/custom_appbar_widget.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/place/presentation/manager/place_cubit/place_cubit.dart';
import 'package:journijots/features/place/presentation/screens/widgets/place_info.dart';
import 'package:journijots/features/place/presentation/screens/widgets/place_sekeltonizer.dart';
import 'package:journijots/features/profile/presentation/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:journijots/features/profile/presentation/manager/repose/profile_repo_impl.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({
    super.key,
    this.placeModel,
    this.placeId,
    this.city,
  });
  final PlaceModel? placeModel;
  final int? placeId;
  final String? city;
  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  void initState() {
    if (widget.placeModel == null) {
      context.read<PlaceCubit>().getPlace(widget.placeId!);
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlaceCubit>.value(
          value: context.read<PlaceCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(getIt<ProfileRepoImpl>())
            ..getProfile(
              id: getIt<CacheHelper>().getData(key: ApiKey.id.toString()),
            ),
        ),
      ],
      child: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.0.h),
                      child: (state is PlaceLoading)
                          ? const PlaceSkeletonizer()
                          : PlaceInfo(
                              placeModel: widget.placeModel ??
                                  ((state is PlaceSuccess)
                                      ? state.place
                                      : const PlaceModel(
                                          id: 0,
                                          name: "Loading...",
                                          city: "Loading...",
                                          rating: 0.0,
                                          ratingCount: 0,
                                        )),
                            ),
                    ),
                  ),
                ),
                const CustomAppBarWidget(
                  color: Color(0xff529CE0),
                  titleColor: Colors.white,
                  icon: false,
                  leading: BackButton(
                    color: Colors.white,
                  ),
                  title: "Explore Place",
                ),
              ],
            ),
            floatingActionButton: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess &&
                    state.profileModel.trips != null &&
                    state.profileModel.trips!.isNotEmpty &&
                    state.profileModel.trips!
                        .any((trip) => trip.city == widget.placeModel?.city)) {
                  return SpeedDial(
                    heroTag: "floatingActionButton",
                    icon: Icons.add,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    activeIcon: Icons.close,
                    backgroundColor: const Color(0xff4183BF),
                    children: [
                      SpeedDialChild(
                        child: const Icon(Icons.airplanemode_active),
                        label: "Add to ${widget.placeModel!.city} trip",
                        onTap: () {
                          if (_checkIsAddedToTrip(state)) {
                            return;
                          }
                          getIt<DioConsumer>().post(
                            EndPoint.addPlaceToTrip(
                              placeType: widget.placeModel!.type!,
                            ),
                            data: {
                              "tripId": state.profileModel.trips!
                                  .firstWhere((trip) =>
                                      trip.city == widget.placeModel!.city)
                                  .id,
                              "placeId": widget.placeModel!.id,
                            },
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.green),
                                    SizedBox(width: 8),
                                    Text("Success"),
                                  ],
                                ),
                                content: Text(
                                  "${widget.placeModel?.name ?? "The Place"} has been added to your trip in ${widget.placeModel?.city ?? "this city"}.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
                // Show nothing (or a disabled FAB) while loading or on error
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  bool _checkIsAddedToTrip(ProfileSuccess state) {
    final String placeType = widget.placeModel!.type!;
    bool isAdded = false;
    if (placeType == "hotel" || placeType == "Hotel") {
      isAdded = state.profileModel.trips!.any((trip) =>
          trip.hotels!.any((place) => place.hotelId == widget.placeModel!.id));
    }
    if (placeType == "restaurant" || placeType == "Restaurant") {
      isAdded = state.profileModel.trips!.any((trip) => trip.restaurants!
          .any((place) => place.restaurantId == widget.placeModel!.id));
    }
    if (placeType == "activity" || placeType == "Activity") {
      isAdded = state.profileModel.trips!.any((trip) => trip.activities!
          .any((place) => place.activityId == widget.placeModel!.id));
    }
    if (isAdded) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text("Already Added"),
              ],
            ),
            content: Text(
              "${widget.placeModel!.name} is already added in ${widget.placeModel!.city}.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
    return isAdded;
  }
}
