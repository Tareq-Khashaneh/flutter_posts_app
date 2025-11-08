

import 'package:ebtech_test/features/posts/domain/repositories/comment_repo.dart';

import '../../entites/comment.dart';
import '../../entites/post.dart';
import '../../repositories/post_repo.dart';

class AddCommentUseCase {
  final CommentRepo repository;

  AddCommentUseCase(this.repository);
  Future<void> call(String postId,Comment comment) async {
    return await repository.addComment( postId,comment);
  }
}
