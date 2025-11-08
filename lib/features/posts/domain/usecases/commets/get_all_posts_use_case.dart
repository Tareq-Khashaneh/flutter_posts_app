

import 'package:ebtech_test/features/posts/domain/entites/comment.dart';
import 'package:ebtech_test/features/posts/domain/repositories/comment_repo.dart';

class GetAllCommentsForPost {
  final CommentRepo repository;

  GetAllCommentsForPost(this.repository);
  Future<List<Comment>> call(String postId) async {
    return await repository.getAllCommentsForPost(postId);
  }
}
