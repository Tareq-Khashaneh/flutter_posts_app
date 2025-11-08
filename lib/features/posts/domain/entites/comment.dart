import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  final String? id;
  final String name;
  final String email;
  final String comment;
  final Timestamp createdAt;
  Comment({required this.id,required this.name, required this.email, required this.comment,required this.createdAt});
}