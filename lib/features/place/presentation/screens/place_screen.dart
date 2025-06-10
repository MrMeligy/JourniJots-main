import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:journijots/core/utils/widgets/custom_appbar_widget.dart';
import 'package:journijots/features/explore/data/place_model/place_model.dart';
import 'package:journijots/features/place/presentation/manager/place_cubit/place_cubit.dart';
import 'package:journijots/features/place/presentation/screens/widgets/place_info.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key, this.placeModel, this.placeId});
  final PlaceModel? placeModel;
  final int? placeId;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  void initState() {
    if (widget.placeModel == null) {
      context.read<PlaceCubit>().getPlace(widget.placeId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: state is PlaceLoading,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 60.0.h), // Adjust this value as needed
                      child: PlaceInfo(
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
          ),
          floatingActionButton: SpeedDial(
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
                child: const Icon(Icons.edit),
                label: 'Edit',
                onTap: () {
                  // Add your edit action here
                },
              ),
              // Add more SpeedDialChild as needed
            ],
          ),
        );
      },
    );
  }
}
