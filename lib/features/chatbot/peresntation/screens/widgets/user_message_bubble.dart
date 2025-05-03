import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserMessageBubble extends StatelessWidget {
  const UserMessageBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bot avatar with image

          // Message bubble
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Karius',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Welcome to the Egypt Tourism Assistant! I can help you discover the wonders of Egypt including attractions, restaurants, hotels, and travel tips across all Egyptian cities.',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Simply ask me anything about Egypt tourism in normal English, and I\'ll do my best to assist you!',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Image.asset('assets/images/pp.png'),
        ],
      ),
    );
  }
}
