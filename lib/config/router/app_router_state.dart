part of 'route_config.dart';

enum AppRouteState {
  splash('splash'),
  home('home'),
  signIn('sign-in'),
  setting('setting'),
  board('board'),
  postCreation('post-creation'),
  postDetail('post-detail'),
  secondHand('second-hand'),
  meal('meal');

  final String path;

  const AppRouteState(this.path);
}
