import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/route/route_helper.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';
import 'package:note_schedule_reminder/widgets/simple_text.dart';
import 'package:note_schedule_reminder/widgets/text_form_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmPasswordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool hideShowPassword1 = false;
  bool hideShowPassword2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height20 * 4,
                ),
                // profile image
                Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    CircleAvatar(
                      radius: Dimensions.radius20 * 4,
                      backgroundColor: Colors.green,
                    ),
                    // edit on profile
                    Positioned(
                      bottom: -Dimensions.width5,
                      right: Dimensions.width5,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_outlined,
                          size: Dimensions.height10 * 4,
                        ),
                      ),
                    )
                  ],
                ),
                /////
                SimpleText(
                  text: "register_text".tr,
                  sizeText: Dimensions.fontSize20,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black54,
                ),
                //user name
                TextFormFieldWidget(
                  textEditingController: _usernameTextEditingController,
                  hintText: "user_name_text".tr,
                  titleText: "user_name_text".tr,
                  icon: Icons.person,
                ),
                //email
                TextFormFieldWidget(
                  textEditingController: _emailTextEditingController,
                  hintText: "email_text".tr,
                  titleText: "email_text".tr,
                  icon: Icons.email_outlined,
                ),
                //password
                TextFormFieldWidget(
                  textEditingController: _passwordTextEditingController,
                  hintText: "password_text".tr,
                  titleText: "password_text".tr,
                  icon: Icons.password_outlined,
                  iconSuffix: hideShowPassword1
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onTap: () {
                    setState(() {
                      hideShowPassword1 = !hideShowPassword1;
                    });
                  },
                  showIconSuffix: true,
                  obscureText: hideShowPassword1 ? false : true,
                ),
                //confirm password
                TextFormFieldWidget(
                  textEditingController: _confirmPasswordTextEditingController,
                  hintText: "confirm_password_text".tr,
                  titleText: "confirm_password_text".tr,
                  icon: Icons.password_outlined,
                  iconSuffix: hideShowPassword2
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onTap: () {
                    setState(() {
                      hideShowPassword2 = !hideShowPassword2;
                    });
                  },
                  showIconSuffix: true,
                  obscureText: hideShowPassword2 ? false : true,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                //sign up button
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed(RouteHelper.getLoginPage());
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radius20),
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "sign_up_text".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                //already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already_have_accout_text".tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.getLoginPage());
                      },
                      child: Text(
                        "login_text".tr,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
