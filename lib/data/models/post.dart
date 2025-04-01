import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: "id") required String postId,
    int? userId,
    String? nickname,
    String? title,
    String? content,
    String? imageUrl,
    int? price,
    bool? isShared,
    String? location,
    DateTime? createdAt,
    int? sellStatus,
  }) = _Post;

  factory Post.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return Post(
      postId: snapshot.id,
      userId: data?['user_id'],
      title: data?['title'],
      content: data?['content'],
      price: data?['price'],
      imageUrl: data?['image_url'],
      isShared: data?['is_shared'],
      location: data?['location'],
      sellStatus: data?['sell_status'],
      createdAt: (data?['created_at'] as Timestamp).toDate(),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
