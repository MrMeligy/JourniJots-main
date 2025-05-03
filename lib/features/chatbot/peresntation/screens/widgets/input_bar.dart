// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:journijots/features/chatbot/data/chat_message_model.dart';
// import 'package:journijots/features/chatbot/peresntation/manager/message_cubit/message_cubit.dart';

// class InputBar extends StatefulWidget {
//   const InputBar({
//     super.key,
//     required TextEditingController messageController,
//     required this.messages,
//     required this.scrollController,
//   }) : _messageController = messageController;

//   final TextEditingController _messageController;
//   final ScrollController scrollController;
//   final List<ChatMessage> messages;

//   @override
//   State<InputBar> createState() => _InputBarState();
// }

// class _InputBarState extends State<InputBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             offset: const Offset(0, -2),
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             // User avatar with image
//             Container(
//               width: 36.w,
//               height: 36.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//                 image: const DecorationImage(
//                   image: AssetImage(
//                       'assets/images/Ellipse 7.png'), // Add your user avatar image
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(width: 12.w),

//             // Text input
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 height: 44.h,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(22.r),
//                 ),
//                 child: TextField(
//                   controller: widget._messageController,
//                   decoration: InputDecoration(
//                     hintText: 'Ask about Egypt tourism...',
//                     hintStyle: TextStyle(color: Colors.grey[500]),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 12.w),

//             // Send button
//             Container(
//               width: 44.w,
//               height: 44.h,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blue[300]!, Colors.blue[400]!],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(22.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withValues(alpha: 0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   final text = widget._messageController.text.trim();
//                   if (text.isEmpty) return;

//                   context.read<MessageCubit>().sendMessage(message: text);
//                   widget._messageController.clear();

//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (widget.scrollController.hasClients) {
//                       widget.scrollController.animateTo(
//                         widget.scrollController.position.maxScrollExtent,
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeOut,
//                       );
//                     }
//                   });
//                 },
//                 icon: Icon(Icons.send, color: Colors.white, size: 20.sp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
