import 'dart:convert';

import 'package:blog_app/core/exception/server_exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signin({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerExceptions(errorMessage: "User does not exist!!");
      } else {
        return UserModel.fromJson(response.user!.toJson());
      }
    } catch (e) {
      throw ServerExceptions(errorMessage: e.toString());
    }
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {'name': name, 'email': email});

      if (response.user == null) {
        throw ServerExceptions(errorMessage: "Failed to create user");
      } else {
        return UserModel.fromJson(response.user!.toJson());
      }
    } catch (e) {
      throw ServerExceptions(errorMessage: e.toString());
    }
  }
}
