part of 'route_config.dart';

enum AppRouteState {
  splash('splash'),
  home('home'),
  signIn('sign-in'),
  setting('setting'),
  board('board'),
  postDetail('post-detail/:id'),
  secondHand('second-hand'),
  createPost('create-post'),
  meal('meal');

  final String path;

  const AppRouteState(this.path);
}
