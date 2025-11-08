import '../../entites/post.dart';
import '../../repositories/post_repo.dart';

class GetPostsUseCase {
  final PostRepo repository;

  GetPostsUseCase(this.repository);
  Future<List<Post>> call() async {
    return await repository.getAllPosts();
  }
}
