class PasswordValidator {
  static final int minLength = 6;

  static bool isValid(String password) {
    return password.length >= minLength;
  }
}
