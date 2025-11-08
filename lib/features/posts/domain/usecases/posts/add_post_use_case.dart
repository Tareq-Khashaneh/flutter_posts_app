

import '../../entites/post.dart';
import '../../repositories/post_repo.dart';

class AddPostUseCase {
  final PostRepo repository;

  AddPostUseCase(this.repository);
  Future<bool> call(Post post) async {
    return await repository.addPost(post);
  }
}
