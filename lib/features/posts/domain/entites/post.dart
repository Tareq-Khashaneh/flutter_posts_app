import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String author;
  final Timestamp timeAgo;
  final String title;
  final String description;
  final int comments;

  Post({
    required this.id,
    required this.author,
    required this.timeAgo,
    required this.title,
    required this.description,
    required this.comments,
  });
}
