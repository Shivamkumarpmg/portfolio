import 'dart:io';

import 'package:bvg_partner/modules/auth/registration/registration_provider.dart';
import 'package:bvg_partner/routes/route_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../services/login_services/google_sign_in_service.dart';
import '../../../widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 26,
                                fontFamily: AppFonts.themeFont,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create your account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppFonts.themeFont,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          AppTextField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            prefixeIcon: Icon(
                              Icons.person_3_outlined,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Name",
                            controller: provider.nameController,
                            maxLength: 50,
                          ),
                          SizedBox(height: 6),
                          AppTextField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            prefixeIcon: Icon(
                              Icons.phone_android,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Mobile Number",
                            controller: provider.phoneController,
                            maxLength: 50,
                          ),
                          SizedBox(height: 6),
                          AppTextField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            prefixeIcon: Icon(
                              Icons.mail_outline_outlined,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Email Address",
                            controller: provider.mailController,
                            maxLength: 50,
                          ),
                          SizedBox(height: 6),
                          AppTextField(
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            prefixeIcon: Icon(
                              Icons.password,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Enter Password",
                            controller: provider.passController,
                            maxLength: 50,
                            showPassword: provider.showPassword,
                            sufixeIcon: IconButton(
                              onPressed: () {
                                provider.togglePasswordVisibility();
                              },
                              icon:
                              provider.showPassword
                                  ? Icon(
                                Icons.visibility_off_outlined,
                                color: ColorConst.greyFourth,
                              )
                                  : Icon(
                                Icons.visibility_outlined,
                                color: ColorConst.greyFourth,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          AppTextField(
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            prefixeIcon: Icon(
                              Icons.password,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Confirm Password",
                            controller: provider.confirmPassController,
                            maxLength: 50,
                            showPassword: true,
                            onChanged: (value){
                              provider.matchPassword();
                            },
                          ),
                          Align(
                               alignment: Alignment.centerLeft,
                              child: Text(provider.passwordMatchError, style: TextStyle(color: Colors.redAccent, fontSize: 12))),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: CustomButton(
                              text: "Register",
                              // isLoading:
                              // provider.loginStatus == STATUSAPI.loading,
                              onTap: () {
                                provider.addUser();
                                // if (!provider.checkValid()) {
                                //   showCustomSnackBar(
                                //     context,
                                //     message: provider.validationError,
                                //   );
                                // } else {
                                //   provider.login();
                                // }
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "Or Sign in with",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: AppFonts.themeFont,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                spacing: 30,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async{
                                      final user = await GoogleSignInProvider().signInWithGoogle();
                                      if (user != null) {
                                        print('Signed in as ${user}');
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(ConstImage.googleLogin, fit: BoxFit.fill),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(ConstImage.xLogin, fit: BoxFit.fill),
                                  ),Visibility(
                                    visible: Platform.isIOS,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(ConstImage.appleLogin, fit: BoxFit.fill),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already registered ?',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppFonts.themeFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.goNamed(RouteConst.loginScreenRoute);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontFamily: AppFonts.themeFont,
                              color: ColorConst.themeColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
