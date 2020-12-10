class AuthException implements Exception {
  final String key;

  static const Map<String, String> errors = {
    'EMAIL_EXISTS': "Email exists",
    'OPERATION_NOT_ALLOWED': "Operation Not Allowed",
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Too many attempts',
    'EMAIL_NOT_FOUND': "Email not Found",
    'INVALID_PASSWORD': "Invalid PassWord",
    'USER_DISABLED': "User Disabled",
  };
  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    }
    return "Errors Occured";
  }
}
