import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtech_test/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:ebtech_test/features/posts/domain/usecases/posts/delete_post_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../posts/data/data_sources/post_remote_data_source.dart';
import '../posts/data/repositories/comment_repo_impl.dart';
import '../posts/data/repositories/post_repo_impl.dart';
import '../posts/domain/usecases/commets/add_comment_use_case.dart';
import '../posts/domain/usecases/commets/get_all_posts_use_case.dart';
import '../posts/domain/usecases/posts/add_post_use_case.dart';
import '../posts/domain/usecases/posts/get_all_posts_use_case.dart';
import '../posts/domain/usecases/posts/update_post_use_case.dart';
import 'network/network_checker.dart';

class DI {
  static late final FirebaseFirestore firestore;
  static late final PostRemoteDataSource postRemoteDataSource;
  static late final PostLocalDataSource postLocalDataSource;
  static late final PostRepoImpl postRepository;
  static late final CommentRepoImpl commentRepository;
  static late final SharedPreferences prefs;
  static late final GetPostsUseCase getPostsUseCase;
  static late final DeletePostUseCase deletePostUseCase;
  static late final AddPostUseCase addPostUseCase;
  static late final UpdatePostUseCase updatePostUseCase;
  static late final GetAllCommentsForPost getCommentsUseCase;
  static late final AddCommentUseCase addCommentUseCase;
  static late final NetworkInfo networkInfo;
  static Future<void> init() async {
    firestore = FirebaseFirestore.instance;
    prefs = await SharedPreferences.getInstance();
    postRemoteDataSource = PostRemoteDataSourceImpl(firestore);
    postLocalDataSource = PostLocalDataSourceImpl(prefs);
    networkInfo = NetworkInfoInternetChecker(InternetConnectionChecker.instance);
    postRepository = PostRepoImpl(postRemoteDataSource,postLocalDataSource,networkInfo);
    commentRepository = CommentRepoImpl(postRemoteDataSource);

    getPostsUseCase = GetPostsUseCase(postRepository);
    addPostUseCase = AddPostUseCase(postRepository);
    updatePostUseCase = UpdatePostUseCase(postRepository);
    deletePostUseCase = DeletePostUseCase(postRepository);
    getCommentsUseCase = GetAllCommentsForPost(commentRepository);
    addCommentUseCase = AddCommentUseCase(commentRepository);
  }
}
