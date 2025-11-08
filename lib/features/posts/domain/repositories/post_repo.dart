

import '../entites/post.dart';

abstract class PostRepo {
  Future<List<Post>> getAllPosts();
  Future<bool> addPost(Post post);
  Future<Post?> updatePost(Post post);
  Future<void> deletePost(String id);

}