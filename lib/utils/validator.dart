class Validator{

  static String? validateEmpty(String? value, String? hint) {
    if (value == null || value.isEmpty) return "Please Enter $hint";
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return "Enter mobile";
    if (value.length != 10) return "Enter valid 10-digit number";
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter email";
    if (!value.contains("@")) return "Invalid email";
    return null;
  }
}