import '../../domain/entites/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel extends Comment {

  CommentModel({
   required super.id,
    required super.name,
    required super.email,
    required  super.comment,
    required  super.createdAt,
  });

  /// Convert model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'comment': comment,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  /// Create model from Firestore document
  factory CommentModel.fromMap(Map<String, dynamic> map, String docId) {
    return CommentModel(
      id: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      comment: map['comment'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  /// CopyWith for updating a comment locally if needed
  CommentModel copyWith({
    String? id,
    String? name,
    String? email,
    String? comment,
    Timestamp? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
