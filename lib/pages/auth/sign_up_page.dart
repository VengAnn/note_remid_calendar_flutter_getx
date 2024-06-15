import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/components/dialogs.dart';
import 'package:note_schedule_reminder/components/loading_custom.dart';
import 'package:note_schedule_reminder/controllers/auth/sign_up_controller.dart';
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

  bool onPressedBtn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SignUpController>(builder: (signUpController) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Form(
                      key: _formKey,
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
                                backgroundColor: Colors.grey,
                                backgroundImage:
                                    signUpController.profile != null
                                        ? FileImage(signUpController.profile!)
                                        : null,
                                child: signUpController.profile == null
                                    ? Icon(
                                        Icons.person,
                                        size: Dimensions.radius20 * 4,
                                      )
                                    : null,
                              ),
                              // edit on profile
                              Positioned(
                                bottom: -Dimensions.width5,
                                right: Dimensions.width5,
                                child: IconButton(
                                  onPressed: () {
                                    showCustomBottomSheet();
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    size: Dimensions.height10 * 4,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SimpleText(
                            text: "register_text".tr,
                            sizeText: Dimensions.fontSize20,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black54,
                          ),
                          // user name
                          TextFormFieldWidget(
                            textEditingController:
                                _usernameTextEditingController,
                            hintText: "user_name_text".tr,
                            titleText: "user_name_text".tr,
                            icon: Icons.person,
                            btnTapped: onPressedBtn,
                            textVilidation: "please enter your name",
                          ),
                          // email
                          TextFormFieldWidget(
                            textEditingController: _emailTextEditingController,
                            hintText: "email_text".tr,
                            titleText: "email_text".tr,
                            icon: Icons.email_outlined,
                            btnTapped: onPressedBtn,
                            textVilidation: "please input your email",
                            showInvalidEmail: true,
                          ),
                          // password
                          TextFormFieldWidget(
                            textEditingController:
                                _passwordTextEditingController,
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
                            btnTapped: onPressedBtn,
                            textVilidation: "please enter your password",
                          ),
                          // confirm password
                          TextFormFieldWidget(
                            textEditingController:
                                _confirmPasswordTextEditingController,
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
                            btnTapped: onPressedBtn,
                            textVilidation:
                                "please enter your confirm password",
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          // sign up button
                          InkWell(
                            onTap: () {
                              // Dismiss the keyboard
                              FocusScope.of(context).unfocus();
                              setState(() {
                                onPressedBtn = true;
                              });

                              if (_passwordTextEditingController.text !=
                                  _confirmPasswordTextEditingController.text) {
                                Dialogs.showSnackBar(
                                    "please the same password");
                              } else {
                                // otherwise if password and confirm password the same ok
                                if (_usernameTextEditingController.text.isNotEmpty &&
                                    _emailTextEditingController
                                        .text.isNotEmpty &&
                                    _passwordTextEditingController
                                        .text.isNotEmpty &&
                                    _confirmPasswordTextEditingController
                                        .text.isNotEmpty) {
                                  if (_formKey.currentState!.validate()) {
                                    signUpController.register(
                                      _usernameTextEditingController.text,
                                      _emailTextEditingController.text,
                                      _passwordTextEditingController.text,
                                    );
                                  }
                                }
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
                          // already have an account
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
              ),
              if (signUpController.isLoading)
                Container(
                  color: Colors.black54,
                  height: Dimensions.screenHeight,
                  width: Dimensions.screenWidth,
                  child: const LoadingCustom(),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// Bottom Sheet
void showCustomBottomSheet() {
  Get.bottomSheet(
    GetBuilder<SignUpController>(builder: (signUpController) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width5,
          vertical: Dimensions.height5,
        ),
        width: double.maxFinite,
        height: Dimensions.height20 * 6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.height10),
            topRight: Radius.circular(Dimensions.height10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.height20 * 2,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Image',
                        style: TextStyle(
                          fontSize: Dimensions.fontSize20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // btn close
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close_outlined),
                    ),
                  ),
                ],
              ),
            ),
            //
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        signUpController.setImageCamera();
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(right: Dimensions.width5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        child: Image.asset(
                          "assets/images/camera_img.png",
                          width: Dimensions.width20 * 3,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        signUpController.setImageGallery();
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        child: Image.asset(
                          "assets/images/galary_img.png",
                          width: Dimensions.width20 * 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }),
  );
}
