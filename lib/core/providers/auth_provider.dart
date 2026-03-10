import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';
import '../../features/auth/data/repositories/auth_repository.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
}

class AuthNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    _checkStatus();
    return AuthStatus.initial;
  }

  Future<void> _checkStatus() async {
    final token = await StorageService.instance.secureRead('access_token');
    if (token != null) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> login(String login, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    final token = await authRepository.login(login, password);
    await StorageService.instance.secureWrite('access_token', token);
    state = AuthStatus.authenticated;
  }

  Future<void> register(String name, String phone, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.register(phone, password, name);
    state = AuthStatus.unauthenticated;
  }

  Future<void> logout() async {
    await StorageService.instance.secureRemove('access_token');
    state = AuthStatus.authenticated;
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);
