class EmailValidator {
  static bool emailValidator(String email) {
    final r = RegExp(r'\w+@+[a-zA-Z]+\.+[a-z]{2,4}$');
    return r.firstMatch(email) == null ? false : true;
  }
}
