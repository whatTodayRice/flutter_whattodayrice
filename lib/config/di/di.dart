import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_whattodayrice/config/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
