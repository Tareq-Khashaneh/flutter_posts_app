import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/injection.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_field.dart';
import '../../../core/shared/custom_title.dart';
import '../../domain/entites/post.dart';
import '../provider/post_detials_provider.dart';
import '../provider/posts_provider.dart';
import '../screens/post_details_screen.dart';
import '../widgets/post_card.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostsProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context); // Ensure ScreenUtil is initialized

    final postsProvider = Provider.of<PostsProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              color: Colors.grey[300],
              height: 1.h,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                text: "Posts",
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              CustomTitle(
                text: "${postsProvider.posts.length} posts",
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ],
          ),
          foregroundColor: Colors.black87,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => postsProvider.fetchPosts(),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCreatePostSheet(context, postsProvider),
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Builder(
            builder: (_) {
              if (postsProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (postsProvider.error != null) {
                return Center(child: Text('Error: ${postsProvider.error}'));
              }

              if (postsProvider.posts.isEmpty) {
                return const Center(child: Text('No posts available'));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: postsProvider.posts.length,
                itemBuilder: (context, index) {
                  final post = postsProvider.posts[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => PostDetailsProvider(
                              DI.updatePostUseCase,
                              DI.deletePostUseCase,
                              DI.getCommentsUseCase,
                              DI.addCommentUseCase,
                            )..setPost(post),
                            child: PostDetailsScreen(),
                          ),
                        ),
                      );
                    },
                    child: PostCard(post: post),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _openCreatePostSheet(BuildContext context, PostsProvider postProvider) {
    final nameController = TextEditingController();
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "Create New Post",
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
                CustomTitle(
                  text: "Share your thoughts with the company",
                  color: Colors.grey[400],
                  fontSize: 16.sp,
                ),
                SizedBox(height: 12.h),
                CustomField(
                  controller: nameController,
                  label: "Your name",
                ),
                SizedBox(height: 12.h),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: "Cancel",
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15,vertical: 10),
      colorButton: Colors.white,
                      colorText: Colors.black,
                      onTap: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: "Create",
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15,vertical: 10),

                        onTap: () async {
                          if (nameController.text.isEmpty ||
                              titleController.text.isEmpty ||
                              contentController.text.isEmpty) {
                            return;
                          }
                          await postProvider.addPost(
                            name: nameController.text,
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
          ),
        );
      },
    );
  }
}
