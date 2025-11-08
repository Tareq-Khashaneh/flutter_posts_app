


import '../../repositories/post_repo.dart';

class DeletePostUseCase {
  final PostRepo repository;

  DeletePostUseCase(this.repository);
  Future<void> call(String postId) async {
    return await repository.deletePost(postId);
  }
}
