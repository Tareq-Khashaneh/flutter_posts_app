import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../provider/post_detials_provider.dart';
import '../provider/posts_provider.dart';
import '../widgets/comment_card.dart';
import '../widgets/post_details_card.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_field.dart';
import '../../../core/shared/custom_title.dart';
import '../../../core/utils/alert_service.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Init ScreenUtil (make sure your MaterialApp has builder: ScreenUtilInit)
    ScreenUtil.init(context);

    final postDetailsProvider = Provider.of<PostDetailsProvider>(
      context,
      listen: true,
    );
    final post = postDetailsProvider.currentPost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Colors.grey[300],
            height: 1.h,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post != null)
              PostDetailsCard(
                post: post,
                postDetailsProvider: postDetailsProvider,
              ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTitle(
                  text: 'Comments',
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
                CustomButton(
                  text: "Add comment",
                  onTap: () {
                    final TextEditingController nameController =
                    TextEditingController();
                    final TextEditingController emailController =
                    TextEditingController();
                    final TextEditingController commentController =
                    TextEditingController();

                    AlertsService.showBottomSheet(
                      context,
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
                            top: 16.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTitle(
                                text: "Add Comment",
                                color: Colors.black,
                                fontSize: 20.sp,
                              ),
                              CustomTitle(
                                text: "Share your thoughts",
                                color: Colors.grey[400],
                                fontSize: 18.sp,
                              ),
                              SizedBox(height: 24.h),
                              CustomField(
                                label: "Name",
                                isFilled: true,
                                controller: nameController,
                              ),
                              SizedBox(height: 16.h),
                              CustomField(
                                label: "Email",
                                controller: emailController,
                              ),
                              SizedBox(height: 16.h),
                              CustomField(
                                label: "Comment",
                                controller: commentController,
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      text: "Cancel",

                                      padding: EdgeInsets.symmetric(
                                        horizontal: 45.w, // responsive width
                                        vertical: 10.h,   // responsive height
                                      ),
                                      colorText: Colors.black,
                                      colorButton: Colors.white,
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // responsive spacing
                                  Expanded(
                                    child: CustomButton(
                                      text: "Post",
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 55.w, // responsive width
                                        vertical: 10.h,   // responsive height
                                      ),
                                      onTap: () async {
                                        if (nameController.text.isEmpty ||
                                            emailController.text.isEmpty ||
                                            commentController.text.isEmpty) {
                                          return;
                                        }
                                        await postDetailsProvider.addComment(
                                          name: nameController.text,
                                          email: emailController.text,
                                          comment: commentController.text,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (postDetailsProvider.isLoadingComments) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (postDetailsProvider.error != null) {
                    return Center(
                      child: Text('Error: ${postDetailsProvider.error}'),
                    );
                  }

                  if (postDetailsProvider.comments.isEmpty) {
                    return const Center(child: Text('No Comments yet'));
                  }

                  return ListView.builder(
                    itemCount: postDetailsProvider.comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: postDetailsProvider.comments[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
