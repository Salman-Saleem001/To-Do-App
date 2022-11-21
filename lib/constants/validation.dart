String? validateEmail(value) {
  if (value != null) {
    if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
      return null;
    }
  }
  return 'Enter a Valid Email Address';
}

String? validatePassword(val) {
  if (val == null || val.length < 8) {
    return "Password cannot be smaller then 8 characters";
  }
  return null;
}
