import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journijots/bottom_nanv_bar.dart';
import 'package:journijots/core/api/end_ponits.dart';
import 'package:journijots/core/cache/cache_helper.dart';
import 'package:journijots/core/services/service_locator.dart';
import 'package:journijots/core/utils/constants.dart';
import 'dart:io';
import 'package:journijots/core/utils/widgets/custom_appbar.dart';
import 'package:journijots/features/actions/presentation/manager/cubits/cubit/add_post_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _postController = TextEditingController();
  final List<File> _selectedImages = [];
  bool _isLoading = false;

  Future<void> _pickImages() async {
    // Store context before async operation
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        // Make sure widget is still mounted before updating state
        if (mounted) {
          setState(() {
            for (var image in images) {
              _selectedImages.add(File(image.path));
            }
          });
        }
      }
    } catch (e) {
      // Use stored scaffoldMessenger instead of context
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    } finally {
      // Check if widget is still mounted
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbodycolor,
      appBar: const CustomAppBar(
        color: Color(0xff529CE0),
        title: "Create Post",
        titleColor: Colors.white,
        leading: BackButton(
          color: Colors.white,
        ),
        icon: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User info row
                      Row(
                        children: [
                          ProfilePicture(
                            picture: getIt<CacheHelper>()
                                .getDataString(key: ApiKey.profilePic),
                          ),
                          SizedBox(width: 12.w),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Text input area
                      TextField(
                        controller: _postController,
                        decoration: const InputDecoration(
                          hintText: 'Share your Journy...',
                          border: InputBorder.none,
                        ),
                        maxLines: 5,
                        style: TextStyle(fontSize: 16.sp),
                      ),

                      // Image preview section
                      if (_selectedImages.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.h,
                          ),
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.file(
                                    _selectedImages[index],
                                    height: 100.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: EdgeInsets.all(4.r),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Upload image button
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kbodycolor,
                  foregroundColor: kprimarycolor,
                  elevation: 0,
                  side: const BorderSide(color: kprimarycolor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  minimumSize: Size(double.infinity, 46.h),
                ),
                icon: _isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
                        ),
                      )
                    : Icon(Icons.photo_library, size: 20.sp),
                label: Text(
                  _isLoading ? 'Loading...' : 'Upload Images',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Post button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0.r),
              child: ElevatedButton(
                onPressed: () {
                  // Implement post functionality
                  if (_postController.text.isNotEmpty) {
                    _uploadPost(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarPage(
                          initialPageIndex: 3,
                          initialTapIndex: 0,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimarycolor,
                  foregroundColor: kbodycolor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadPost(BuildContext context) async {
    await context.read<AddPostCubit>().addPost(post: _postController.text);
  }
}
