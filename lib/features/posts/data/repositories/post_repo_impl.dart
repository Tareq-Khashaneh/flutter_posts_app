import 'package:ebtech_test/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:ebtech_test/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:ebtech_test/features/posts/domain/entites/post.dart';
import '../../../core/network/network_checker.dart';
import '../../domain/repositories/post_repo.dart';
import '../models/post_model.dart';

class PostRepoImpl extends PostRepo {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepoImpl(this.remoteDataSource, this.localDataSource, this.networkInfo, );
  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
       List<PostModel> posts = [];
      if(await networkInfo.isConnected){
         posts = await remoteDataSource.getAllPosts();
        await localDataSource.cacheList(posts);
      }
      else{
        final cached = await localDataSource.getCachedList();
        posts =cached;
      }

      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  @override
  Future<bool> addPost(Post post) async{
    try {
      final PostModel postModel = PostModel(
          author: post.author, timeAgo: post.timeAgo, title: post.title,
          description: post.description, comments: post.comments);
       await remoteDataSource.addPost(postModel);
      return true;
    } catch (e) {
      print('Error fetching posts: $e');
      return false;
    }
  }

  @override
  Future<Post?> updatePost(Post post) async{
    try {
      final PostModel postModel = PostModel(
        id: post.id,
          author: post.author, timeAgo: post.timeAgo, title: post.title,
          description: post.description, comments: post.comments);
     return await remoteDataSource.updatePost(postModel);

    } catch (e) {
      print('Error fetching posts: $e');
      return null;
    }
  }

  @override
  Future<void> deletePost(String id) async{
  await remoteDataSource.deletePost(id);
  }
}
