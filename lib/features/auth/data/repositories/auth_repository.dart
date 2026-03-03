import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_client.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<String> login(String email, String password) async {
    try {

      await Future.delayed(const Duration(seconds: 2));
      
      return 'simulated_dummy_jwt_token_12345';

    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password, String name) async {
     try {  
       // TODO: Replace with actual register endpoint
       await Future.delayed(const Duration(seconds: 2));
     } catch (e) {
       rethrow;
     }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient.dio);
});
