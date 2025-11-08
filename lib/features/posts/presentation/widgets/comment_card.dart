import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../domain/entites/comment.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(width: 1,color: Colors.grey[300]!)
      ),child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(radius: 18,child: Text( comment.name.length >= 2
                    ? comment.name.substring(0, 2).toUpperCase()
                    : comment.name.toUpperCase(),),),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6,),
                    Text(
                      comment.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      timeago.format(comment.createdAt.toDate()),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      comment.comment,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 12),


          ],
        ),
      ),
    );
    ;
  }
}
