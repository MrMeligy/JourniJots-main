import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:journijots/bottom_nanv_bar.dart';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';
import 'package:journijots/features/trip/presentation/managers/add_trip_cubit/add_trip_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  bool _tripLoading = false;
  @override
  Widget build(BuildContext context) {
    String? city, date;
    return BlocListener<AddTripCubit, AddTripState>(
      listener: (context, state) {
        if (state is AddTripLoading) {
          setState(() {
            _tripLoading = true;
          });
        }
        if (state is AddTripSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBarPage(
                initialPageIndex: 3,
                initialTapIndex: 1,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Plan A New Trip!",
          color: Color(0xff529CE0),
          titleColor: Colors.white,
          leading: BackButton(
            color: Colors.white,
          ),
          icon: false,
        ),
        body: ModalProgressHUD(
          inAsyncCall: _tripLoading,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Description text
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Get ready for your next journey – map it out, customize your route, and share it with friends!',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Destination input
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your destination',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropDownTextField(
                          textFieldDecoration: const InputDecoration(
                            hintText: "Select City",
                            contentPadding: EdgeInsets.all(8),
                          ),
                          onChanged: (value) {
                            if (value is DropDownValueModel) {
                              city = value.value;
                            }
                          },
                          dropDownList: const [
                            DropDownValueModel(name: "Cairo", value: "Cairo"),
                            DropDownValueModel(name: "Giza", value: "Giza"),
                            DropDownValueModel(
                                name: "Alexandria", value: "Alexandria"),
                            DropDownValueModel(name: "Dahab", value: "Dahab"),
                            DropDownValueModel(name: "Taba", value: "Taba"),
                            DropDownValueModel(name: "Luxor", value: "Luxor"),
                            DropDownValueModel(name: "Aswan", value: "Aswan"),
                            DropDownValueModel(
                                name: "Sharm Elsheikh",
                                value: "Sharm Elsheikh"),
                            DropDownValueModel(
                                name: "Hurghada", value: "Hurghada"),
                            DropDownValueModel(
                                name: "Alamein", value: "Alamein"),
                            DropDownValueModel(
                                name: "Port Said", value: "Port Said"),
                            DropDownValueModel(name: "Suez", value: "Suez"),
                            DropDownValueModel(
                                name: "Marsa Alam", value: "Marsa Alam"),
                            DropDownValueModel(name: "Fayoum", value: "Fayoum"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Date inputs
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      // Start Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trip Date',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SfDateRangePicker(
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs args) {
                                  final DateTime selectedDate = args.value;
                                  date = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w),
                      // End Date
                    ],
                  ),
                ),

                // Spacer - using Expanded to push buttons to bottom

                // Add Trip button - UPDATED with wider width
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w), // Reduced padding from 60.w to 20.w
                  child: ElevatedButton(
                    onPressed: () {
                      // Add trip functionality would go here
                      if (city != null && date != null) {
                        context
                            .read<AddTripCubit>()
                            .addTrip(city: city!, date: date!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64B5F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Add Trip',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
