

import '../entites/comment.dart';

abstract class CommentRepo{
  Future<void> addComment(String postId,Comment comment);
  Future<List<Comment>> getAllCommentsForPost(String postId);
}