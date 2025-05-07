import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_android_flutter/core/services/firebase/auth/firebase_auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  User? _user;
  String? _error;
  bool _isLoading = false;

  User? get user => _user;
  String? get error => _error;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    clearError();
    try {
      _user = await _authService.signIn(email: email, password: password);
    } catch (e) {
      _setError(e.toString());
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    clearError();
    try {
      _user = await _authService.signUp(email: email, password: password);
    } catch (e) {
      _setError(e.toString());
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    clearError();
    try {
      await _authService.signOut();
      _user = null;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void clearError() {
    _error = null;
  }
}
