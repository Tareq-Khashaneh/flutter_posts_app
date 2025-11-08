import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebtech_test/features/posts/domain/entites/post.dart';

class PostModel extends Post{

  PostModel({
     super.id,
    required super.author,
    required super.timeAgo,
    required super.title,
    required super.description,
    required super.comments,
  });
  // تحويل من Map (JSON) إلى كائن Post
  factory PostModel.fromMap(Map<String, dynamic> map,String docId) {
    return PostModel(
      id: docId,
      author: map['author'] ?? '',
      timeAgo: map['timeAgo'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      comments: map['commentCounts'] ?? 0,
    );
  }
  factory PostModel.fromJson(Map<String, dynamic> map,) {
    return PostModel(
      id: map['id'],
      author: map['author'] ?? '',
      timeAgo:  Timestamp.fromDate(DateTime.parse(map['timeAgo'])),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      comments: map['commentCounts'] ?? 0,
    );
  }
  // تحويل الكائن Post إلى Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'timeAgo': timeAgo,
      'title': title,
      'description': description,
      'commentCounts': comments,
    };
  } Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'timeAgo': timeAgo.toDate().toIso8601String(),
      'title': title,
      'description': description,
      'commentCounts': comments,
    };
  }
}