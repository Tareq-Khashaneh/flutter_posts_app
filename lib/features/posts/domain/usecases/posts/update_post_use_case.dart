

import '../../entites/post.dart';
import '../../repositories/post_repo.dart';

class UpdatePostUseCase {
  final PostRepo repository;

  UpdatePostUseCase(this.repository);
  Future<Post?> call(Post post) async {
    return await repository.updatePost(post);
  }
}
