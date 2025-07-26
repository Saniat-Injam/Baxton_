import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _tokenKey = 'token';
  static const _userIdKey = 'id';
  static const _role =
      'UserType'; // This will store the roles as a comma-separated string
  static const _isProfileCreated = 'isProfileCreated';
  static const _profileId = 'profileId';

  // Save auth data to SharedPreferences
  static Future<void> saveAuthData(
    String token,
    String userId,
    String role,
    String isProfileCreated,
    String profileId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_role, role); // Save roles as a string
    await prefs.setString(_isProfileCreated, isProfileCreated);
    await prefs.setString(_profileId, profileId);
    debugPrint(
      'Auth data saved: $token, $userId, $role, $isProfileCreated , $profileId',
    );
  }

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get stored user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileId);
  }

  // Get stored roles as a List<String> by splitting the comma-separated string
  static Future<List<String>> getRoles() async {
    final prefs = await SharedPreferences.getInstance();
    String? rolesString = prefs.getString(_role);
    if (rolesString != null) {
      return rolesString.split(
        ',',
      ); // Convert the comma-separated string back into a list
    }
    return [];
  }

  // Get stored profile creation status
  static Future<String?> getProfileCreated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isProfileCreated);
  }

  // Clear all auth data
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_role);
    await prefs.remove(_isProfileCreated);
    await prefs.remove(_profileId);
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Check if user has a role
  static Future<bool> isRole() async {
    final role = await getRoles();
    return role.isNotEmpty;
  }

  // Check if user has a profile created
  static Future<bool> isProfileCreated() async {
    final isProfileCreated = await getProfileCreated();
    Logger().d(
      "check in auth service isProfileCreated: ====> $isProfileCreated",
    );
    return isProfileCreated != null && isProfileCreated.isNotEmpty;
  }
}
