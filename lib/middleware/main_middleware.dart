import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/services/share_preferences.dart';

class MainMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? token = SharedPreferencesService.getToken();

    if (token == null) {
      // return const RouteSettings(name: '/login');
      // return RouteSettings(name: RouteHelper.getLoginPage());
      return null;
    }
    return RouteSettings(name: RouteHelper.getCalenderPage());
  }
}
