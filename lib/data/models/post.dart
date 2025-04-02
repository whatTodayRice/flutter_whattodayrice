import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    String? id,
    String? parentPostId,
    int? userId,
    String? nickname,
    String? title,
    String? content,
    String? imageUrl,
    int? price,
    String? location,
    DateTime? createdAt,
    int? sellStatus,
    @Default([]) List<Post> comments,
  }) = _Post;

  factory Post.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      {QuerySnapshot<Map<String, dynamic>>? querySnapshot}) {
    final data = snapshot.data();

    List<Post> comments = [];

    if (querySnapshot != null) {
      comments = [..._getCommentsFromJson(querySnapshot.docs)];
    }

    return Post(
      id: snapshot.id,
      parentPostId: data?['parent_post_id'],
      userId: data?['user_id'],
      title: data?['title'],
      content: data?['content'],
      price: data?['price'],
      imageUrl: data?['image_url'],
      location: data?['location'],
      sellStatus: data?['sell_status'],
      createdAt: (data?['created_at'] as Timestamp).toDate(),
      comments: [...comments],
    );
  }

  static List<Post> _getCommentsFromJson(List<DocumentSnapshot<Map<String, dynamic>>> commentDocs) {
    List<Post> comments = [];

    for (int i = 0; i < commentDocs.length; i++) {
      final data = commentDocs[i].data();

      comments.add(
        Post(
          id: data?['id'],
          parentPostId: data?['parent_post_id'],
          userId: data?['user_id'],
          nickname: data?['nickname'],
          content: data?['content'],
          createdAt: (data?['created_at'] as Timestamp).toDate(),
        ),
      );
    }

    return [...comments];
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
