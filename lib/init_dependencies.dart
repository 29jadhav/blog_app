import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/datasource/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/secrets/app_secrects.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrects.superBaseUrl, anonKey: AppSecrects.superBaseAPIKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDateSoruce>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    ..registerLazySingleton(() => BlogBloc(serviceLocator()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepo>(
      () => AuthRepoImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignup(authRepo: serviceLocator()),
    )
    ..registerFactory(
      () => UserSignin(authRepo: serviceLocator()),
    )
    ..registerFactory(
      () => GetCurrentUser(authRepo: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator(),
        userSignin: serviceLocator(),
        getCurrentUser: serviceLocator(),
        appUser: serviceLocator(),
      ),
    );
}
