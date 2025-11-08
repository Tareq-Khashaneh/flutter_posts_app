
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtech_test/features/posts/domain/usecases/posts/add_post_use_case.dart';
import 'package:flutter/material.dart';
import '../../domain/entites/post.dart';
import '../../domain/usecases/posts/get_all_posts_use_case.dart';

class PostsProvider extends ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;
  PostsProvider(this.getPostsUseCase, this.addPostUseCase);
  Post? _currentPost;

  Post? get currentPost => _currentPost;

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await getPostsUseCase.call();
      _posts = result;
    } catch (e) {
      _error = e.toString();
      _posts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPost({required String name,required String title,required String content}) async {
   try{
     Post post = Post(
       author: name,
       timeAgo: Timestamp.now(),
       title: title,
       description: content,
       comments: 0,
       id: null,
     );
     await addPostUseCase.call(post);
     fetchPosts();
   }
    catch (e) {
    _error = e.toString();
    }
  }
}
