class ValidationMixin {
  String validateUserId(String value) {
    RegExp exp = RegExp('[^0-9]+');
    if (exp.hasMatch(value)) {
      return 'Please enter a valid User Id(only numbers)';
    } else if (!(value.length == 4)) {
      return 'User ID must be 4 digits long';
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return '*required';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be atleast 6 characters long';
    }
    return null;
  }
}
