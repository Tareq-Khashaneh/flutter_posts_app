import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<void> cacheList(List<PostModel> posts);
  Future<List<PostModel>> getCachedList();
}

class PostLocalDataSourceImpl extends PostLocalDataSource {
  SharedPreferences _prefs;
  PostLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheList(List<PostModel> posts) async {
    try {
      List<String> postsJson = posts
          .map((post) => jsonEncode(post.toJson()))
          .toList();

      await _prefs.setStringList('posts', postsJson);
      print("posts ${_prefs.getStringList("posts")}");
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Future<List<PostModel>> getCachedList()async{
   List<String>? postJson =   _prefs.getStringList('posts');
   if(postJson == null ){
     return [];
   }
   print("get cahche");
  return postJson.map((post) => PostModel.fromJson(jsonDecode(post))).toList();
  }
}
