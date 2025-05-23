import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/utils/constants.dart';

class InterestCategoryButton extends StatelessWidget {
  final String interest;

  const InterestCategoryButton({
    super.key,
    required this.interest,
  });

  Map<String, String>? getInterestData() {
    for (var item in interests) {
      if (item["values"].contains(interest)) {
        return {"title": item["title"], "icon": item["icon"]};
      }
    }
    return null; // في حال لم يتم العثور على تطابق
  }

  @override
  Widget build(BuildContext context) {
    var interestData = getInterestData();
    String icon = interestData!["icon"]!;
    String label = interestData["title"]!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: IntrinsicWidth(
        child: MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          color: Colors.white,
          elevation: 0,
          highlightElevation: 0,
          splashColor: const Color.fromARGB(255, 91, 121, 186),
          highlightColor: const Color.fromARGB(255, 70, 105, 179),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
