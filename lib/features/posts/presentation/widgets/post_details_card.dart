import 'package:ebtech_test/features/posts/presentation/provider/post_detials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/constants/app_colors.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_field.dart';
import '../../../core/shared/custom_title.dart';
import '../../../core/utils/alert_service.dart';
import '../../domain/entites/post.dart';
import '../screens/posts_screen.dart';

class PostDetailsCard extends StatelessWidget {
  const PostDetailsCard({
    super.key,
    required this.post,
    required this.postDetailsProvider,
  });

  final Post post;
  final PostDetailsProvider postDetailsProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(width: 1.w, color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 24.r),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      timeago.format(post.timeAgo.toDate()),
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 24.sp),
                  onPressed: () {
                    AlertsService.showBottomSheet(
                      context,
                      _openEditPostSheet(context, postDetailsProvider),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 24.sp),
                  onPressed: () {
                    AlertsService.showCustomDialog(
                      context,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTitle(
                            text: "Delete Post",
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                          CustomTitle(
                            text: "Are you sure?",
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                text: "Delete",
                                colorButton: AppColors.error,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 80.w,
                                  vertical: 10.h,
                                ),
                                onTap: () {
                                  postDetailsProvider.deletePost();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PostsScreen(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10.h),
                              CustomButton(
                                text: "Cancel",
                                colorText: Colors.black,
                                colorButton: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 80.w,
                                  vertical: 10.h,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              post.title,
              maxLines: 1,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.h),
            Text(
              post.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 12.h),
            Divider(thickness: 1.h, color: Colors.grey[300]),
            Row(
              children: [
                Icon(Icons.comment, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  '${post.comments} comment${post.comments != 1 ? 's' : ''}',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _openEditPostSheet(
      BuildContext context, PostDetailsProvider postsDetailsProvider) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    titleController.text = postsDetailsProvider.currentPost!.title;
    contentController.text = postsDetailsProvider.currentPost!.description;

    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTitle(
            text: "Edit Post",
            color: Colors.black,
            fontSize: 18.sp,
          ),
          CustomTitle(
            text: "Update your post details below",
            color: Colors.grey[400],
            fontSize: 16.sp,
          ),
          CustomField(
            controller: titleController,
            label: "Title",
          ),
          SizedBox(height: 12.h),
          CustomField(
            controller: contentController,
            maxLines: 4,
            label: "Content",
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Cancel",
                  onTap: () => Navigator.pop(context),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 10.h,
                  ),
                  colorText: Colors.black,
                  colorButton: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 10.h,
                  ),
                  text: "Update",
                  onTap: () async {
                    if (titleController.text.isEmpty ||
                        contentController.text.isEmpty) {
                      return;
                    }
                    await postsDetailsProvider.updatePost(
                      title: titleController.text,
                      content: contentController.text,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
