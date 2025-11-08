import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtech_test/features/posts/domain/entites/comment.dart';
import 'package:ebtech_test/features/posts/domain/usecases/commets/add_comment_use_case.dart';
import 'package:ebtech_test/features/posts/domain/usecases/commets/get_all_posts_use_case.dart';
import 'package:ebtech_test/features/posts/domain/usecases/posts/add_post_use_case.dart';

import 'package:flutter/material.dart';

import '../../domain/entites/post.dart';
import '../../domain/usecases/posts/delete_post_use_case.dart';
import '../../domain/usecases/posts/get_all_posts_use_case.dart';
import '../../domain/usecases/posts/update_post_use_case.dart';

class PostDetailsProvider extends ChangeNotifier {
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetAllCommentsForPost getAllCommentsForPost;
  final AddCommentUseCase addCommentUseCase;
  PostDetailsProvider(
      this.updatePostUseCase,
      this.deletePostUseCase,
      this.getAllCommentsForPost,
      this.addCommentUseCase,
      );
  Post? _currentPost;

  Post? get currentPost => _currentPost;

  List<Post> _posts = [];
  List<Comment> _comments = [];
  List<Post> get posts => _posts;
  List<Comment> get comments => _comments;
  bool _isLoading = false;
  bool _isLoadingComments = false;
  bool get isLoading => _isLoading;
  bool get isLoadingComments => _isLoadingComments;

  String? _error;
  String? get error => _error;



  void setPost(Post? post) async {
    _currentPost = post;
    await fetchComments();
    notifyListeners(); // Notifies all listeners
  }


  Future<void> updatePost({
    required String title,
    required String content,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      if (currentPost == null) {
        return;
      }
      print("id ${currentPost!.id}");
      Post post = Post(
        id: currentPost!.id,
        author: currentPost!.author,
        timeAgo: currentPost!.timeAgo,
        title: title,
        description: content,
        comments: currentPost!.comments,
      );
      final updatePost = await updatePostUseCase.call(post);
      setPost(updatePost);
      _isLoading = false;
      notifyListeners();
      print("currentPOst ${currentPost!.title}");
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost() async {
    if (currentPost == null) {
      return;
    }
    deletePostUseCase.call(currentPost!.id!);
  }

  Future<void> fetchComments() async {
    if (currentPost == null) {
      return;
    }
    try {
      _isLoadingComments = true;
      notifyListeners();
      _comments = await getAllCommentsForPost.call(currentPost!.id!);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingComments = false;
      notifyListeners();
    }
  }

  Future<void> addComment({
    required String name,
    required String email,
    required String comment,
  }) async {
    if (currentPost == null) {
      return;
    }
    try {
      Comment commentEntity = Comment(
        id: null,
        name: name,
        email: email,
        comment: comment,
        createdAt: Timestamp.now(),
      );

      await addCommentUseCase.call(currentPost!.id!, commentEntity);
    } catch (e) {
      _error = e.toString();
    }
    await fetchComments();
  }
}
