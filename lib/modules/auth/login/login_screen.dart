import 'package:bvg_partner/utils/common/common_functions.dart';
import 'package:bvg_partner/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../routes/route_const.dart';
import '../../../widgets/widgets.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.loginStatus == STATUSAPI.errorState) {
              showCustomSnackBar(
                context,
                message: provider.loginData.message ?? 'Something went wrong!',
                isError: true,
              );
            } else if (provider.loginStatus == STATUSAPI.successState) {
              showCustomSnackBar(
                context,
                message: provider.loginData.message ?? 'Success',
                isError: false,
              );
            }
          });
          return Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Log In',
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
                              '(Employee/Supervisor)',
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
                              Icons.mail_outline_outlined,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Email Address",
                            controller: provider.emailController,
                            maxLength: 50,
                          ),
                          SizedBox(height: 6),
                          AppTextField(
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            prefixeIcon: Icon(
                              Icons.password,
                              color: ColorConst.greyFourth,
                            ),
                            title: "Enter Password",
                            controller: provider.passwordController,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: ColorConst.themeColor,
                                checkColor: Colors.white,
                                value: provider.stayLoggedIn,
                                onChanged: (value) {
                                  provider.toggleStayLoggedIn();
                                },
                              ),
                              Text(
                                "Stay Logged in",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: AppFonts.themeFont,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: CustomButton(
                              text: "Login",
                              isLoading:
                                  provider.loginStatus == STATUSAPI.loading,
                              onTap: () {
                                if (!provider.checkValid()) {
                                  showCustomSnackBar(
                                    context,
                                    message: provider.validationError,
                                  );
                                } else {
                                  provider.login();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              context.pushNamed(RouteConst.forgotPassScreenRoute);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: ColorConst.themeColor,
                                fontFamily: AppFonts.themeFont,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 200),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppFonts.themeFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Text(
                          "Contact Admin",
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
              ],
            ),
          );
        },
      ),
    );
  }
}
