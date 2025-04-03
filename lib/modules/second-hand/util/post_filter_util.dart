import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

abstract class PostBlockedUserFilterUtil {
  static List<Post> getFilteredPosts(List<Post> allPosts) {
    final curUserProfile = getIt<UserRepository>().getUserProfileFromCache();

    if (curUserProfile == null) {
      return allPosts;
    }

    List<Post> filteredPosts = [];

    for (int i = 0; i < allPosts.length; i++) {
      final post = allPosts[i];

      if (curUserProfile.blockedUserIds.contains(post.userId) == true) {
        continue;
      }

      filteredPosts.add(post);
    }

    return [...filteredPosts];
  }
}
