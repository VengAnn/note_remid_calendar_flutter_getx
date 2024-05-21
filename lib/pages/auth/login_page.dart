import 'package:flutter/material.dart';
import 'package:note_schedule_reminder/utils/app_color.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/widgets/text_form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: SizedBox(
              height: Dimensions.screenHeight,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo_login.jpg",
                    width: Dimensions.width20 * 10,
                  ),
                  // email
                  TextFormFieldWidget(
                    textEditingController: _emailController,
                    hintText: "Email",
                    titleText: "Email",
                    icon: Icons.email_outlined,
                  ),
                  TextFormFieldWidget(
                    textEditingController: _emailController,
                    hintText: "Password",
                    titleText: "Password",
                    icon: Icons.password_outlined,
                    iconSuffix: Icons.visibility_off_outlined,
                    showIconSuffix: true,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SimpleText(text: "forgot password"),
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: Dimensions.height20 * 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.colorBlue,
                          AppColor.colorAmber,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: SimpleText(text: "Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
