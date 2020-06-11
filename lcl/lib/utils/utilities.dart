
class Utils {
  static String getUsername(String email) {

    return "lc:${email.split('@')[0]}";

  }
}