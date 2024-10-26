// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_whattodayrice/common/utils/event_bus.dart' as _i373;
import 'package:flutter_whattodayrice/data/data_sources/remote/auth_remote_data_source.dart'
    as _i83;
import 'package:flutter_whattodayrice/data/data_sources/remote/happy_meal_data_source.dart'
    as _i465;
import 'package:flutter_whattodayrice/data/data_sources/remote/post_remote_data_source.dart'
    as _i324;
import 'package:flutter_whattodayrice/data/data_sources/remote/second_hand_remote_data_source.dart'
    as _i106;
import 'package:flutter_whattodayrice/data/data_sources/remote/services/happy_meal_service.dart'
    as _i696;
import 'package:flutter_whattodayrice/data/data_sources/remote/services/supabase_service.dart'
    as _i453;
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart'
    as _i544;
import 'package:flutter_whattodayrice/data/repository/impl/auth_repository_impl.dart'
    as _i994;
import 'package:flutter_whattodayrice/data/repository/impl/meal_repository_impl.dart'
    as _i69;
import 'package:flutter_whattodayrice/data/repository/impl/post_repository_impl.dart'
    as _i699;
import 'package:flutter_whattodayrice/data/repository/impl/second_hand_repository_impl.dart'
    as _i393;
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart'
    as _i785;
import 'package:flutter_whattodayrice/data/repository/post_repository.dart'
    as _i730;
import 'package:flutter_whattodayrice/data/repository/second_hand_repository.dart'
    as _i852;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i373.EventBus>(() => _i373.EventBus());
    gh.lazySingleton<_i453.SupabaseService>(() => _i453.SupabaseService());
    gh.lazySingleton<_i696.HappyMealService>(
        () => const _i696.HappyMealService());
    gh.lazySingleton<_i106.SecondHandRemoteDataSource>(() =>
        _i106.SecondHandRemoteDataSource(
            supabaseService: gh<_i453.SupabaseService>()));
    gh.lazySingleton<_i324.PostRemoteDataSource>(() =>
        _i324.PostRemoteDataSource(
            supabaseService: gh<_i453.SupabaseService>()));
    gh.lazySingleton<_i83.AuthRemoteDataSource>(() => _i83.AuthRemoteDataSource(
        supabaseService: gh<_i453.SupabaseService>()));
    gh.lazySingleton<_i852.SecondHandRepository>(() =>
        _i393.SecondHandRepositoryImpl(
            secondHandRemoteDataSource:
                gh<_i106.SecondHandRemoteDataSource>()));
    gh.lazySingleton<_i465.HappyDormsMealRemoteDataSource>(() =>
        _i465.HappyDormsMealRemoteDataSource(
            happyMealService: gh<_i696.HappyMealService>()));
    gh.lazySingleton<_i544.AuthRepository>(() => _i994.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i83.AuthRemoteDataSource>()));
    gh.lazySingleton<_i730.PostRepository>(() => _i699.PostRepositoryImpl(
        postRemoteDataSource: gh<_i324.PostRemoteDataSource>()));
    gh.lazySingleton<_i785.DormitoryMealRepository>(() =>
        _i69.DormitoryMealRepositoryImpl(
            happyDormsMealRemoteDataSource:
                gh<_i465.HappyDormsMealRemoteDataSource>()));
    return this;
  }
}
