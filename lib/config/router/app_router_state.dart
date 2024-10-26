part of 'route_config.dart';

enum AppRouteState {
  splash('splash'),
  signIn('sign-in'),
  home('home'),
  loginInfo('login-info'),
  setting('setting'),
  emailRegister('email-register'),
  board('board'),
  postCreation('post-creation'),
  postDetail('post-detail'),
  secondHand('second-hand'),
  meal('meal');

  final String path;

  const AppRouteState(this.path);
}
