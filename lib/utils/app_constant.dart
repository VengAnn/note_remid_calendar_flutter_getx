// ignore_for_file: constant_identifier_names

class AppConstant {
  static const String Base_Url = "http://192.168.3.16:8000/api/v1";

  static const String PathImg_Url = "http://192.168.3.16:8000/users/";

  //auth endpoint
  static const String Login_EndPoint = "/auth/login";
  static const String Logout_EndPoint = "/auth/logout";
  static const String Register_EndPoint = "/auth/register";
  static const String Register_google_EndPoint = "/auth/register-google";

  // event enpoint
  static const String Event_EndPoint = "/events";
  static const String Event_With_UserId_EndPoint = "/events/user";
}
