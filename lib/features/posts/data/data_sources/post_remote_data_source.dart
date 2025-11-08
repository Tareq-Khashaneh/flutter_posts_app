import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<bool> addPost(PostModel post);
  Future<void> addComment(String postId,CommentModel commentModel);
  Future<PostModel?> updatePost(PostModel post);
  Future<void> deletePost(String id);
  Future<List<CommentModel>> getAllComments(String postId);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final FirebaseFirestore _firestore;

  PostRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      // جلب البيانات من Collection "posts"
      final docRef = await _firestore.collection('posts').get();

      // تحويل كل مستند إلى PostModel
      List<PostModel> posts = docRef.docs.map((doc) {
        return PostModel.fromMap(doc.data(), doc.id);
      }).toList();

      return posts;
    } catch (e) {
      // يمكنك هنا التعامل مع الأخطاء بشكل مناسب
      print('Error fetching posts: $e');
      return [];
    }
  }

  @override
  Future<bool> addPost(PostModel post) async {
    try {
      await _firestore.collection('posts').add(post.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<PostModel?> updatePost(PostModel post) async {
    final docRef = _firestore.collection('posts').doc(post.id.toString());
    try {
      await docRef.update(post.toMap());
      final updatedDoc = await docRef.get();

      if (!updatedDoc.exists) return null;
      return PostModel.fromMap(updatedDoc.data()!, updatedDoc.id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deletePost(String id) async {
    _firestore.collection('posts').doc(id).delete();
  }

  @override
  Future<List<CommentModel>> getAllComments(String postId) async {
    try {
      final snapshot = await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();
      final List<CommentModel> c =  snapshot.docs
          .map((doc) => CommentModel.fromMap(doc.data(), doc.id))
          .toList();
      print("Comments ${c.length}");
return c;
    } catch (e) {
      print("Error fetching comments: $e");
      return [];
    }
  }

  Future<void> addComment(String postId, CommentModel comment) async {
    final postRef = _firestore.collection('posts').doc(postId);
    final commentsRef = postRef.collection('comments');

    await _firestore.runTransaction((transaction) async {
      // 1️⃣ First: read the post
      final postSnapshot = await transaction.get(postRef);
      final currentCount = postSnapshot['commentCounts'] ?? 0;

      // 2️⃣ Then: write the comment
      final newCommentRef = commentsRef.doc(); // Firestore generates ID
      transaction.set(newCommentRef, comment.toMap());

      // 3️⃣ Update the post comment count
      transaction.update(postRef, {'commentCounts': currentCount + 1});
    });
  }
}