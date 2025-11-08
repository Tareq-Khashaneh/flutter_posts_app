import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtech_test/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:ebtech_test/features/posts/data/models/comment_model.dart';
import 'package:ebtech_test/features/posts/domain/entites/comment.dart';
import 'package:ebtech_test/features/posts/domain/entites/post.dart';
import 'package:ebtech_test/features/posts/domain/repositories/comment_repo.dart';
import '../../domain/repositories/post_repo.dart';
import '../models/post_model.dart';

class CommentRepoImpl extends CommentRepo {
  final PostRemoteDataSource remoteDataSource;
  CommentRepoImpl(this.remoteDataSource);



  @override
  Future<void> addComment(String postId,Comment comment) async{
    try {
      final CommentModel commentModel = CommentModel(
          id: null, name: comment.name, email: comment.email, comment: comment.comment, createdAt: comment.createdAt);
      await remoteDataSource.addComment(postId,commentModel);

    } catch (e) {
      print('Error fetching posts: $e');

    }
  }

  @override
  Future<List<Comment>> getAllCommentsForPost(String postId) async{
    try {
      final comments = await remoteDataSource.getAllComments(postId);
      return comments;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

}
