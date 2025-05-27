import 'package:bvg_partner/modules/auth/forgot/forgot_provider.dart';
import 'package:bvg_partner/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_button.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 12,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontFamily: AppFonts.themeFont,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 26,
                    ),
                  ),
                ),
                Visibility(
                  visible: true,
                  replacement: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      AppTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        prefixeIcon: const Icon(
                          Icons.password,
                          color: ColorConst.greyFourth,
                        ),
                        showPassword: provider.showPassword,
                        sufixeIcon: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              provider.togglePasswordVisibility();
                            },
                            child: Icon(
                              provider.showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            )),
                        title: "New Password",
                        controller: provider.passwordController,
                        maxLength: 50,
                      ),
                      const Text("Enter OTP", style: TextStyle(fontSize: 14)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 12,
                        children: List.generate(6, _buildOtpField),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // controller.resendOtp();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: CustomButton(
                          isLoading: false,
                          text: "Submit",
                          onTap: () {
                            // if ((controller.checkValidPassword())) {
                            //   controller.submitOtp();
                            // }
                          },
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Column(
                      spacing: 20,
                      children: [
                        AppTextField(
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          prefixeIcon: const Icon(
                            Icons.mail_outline_outlined,
                            color: ColorConst.greyFourth,
                          ),
                          title: "Email Address",
                          controller: provider.emailController,
                          maxLength: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: CustomButton(
                            text: "Verify Mail",
                            onTap: () {
                              // var verifyJsonData = {
                              //   "email":
                              //       provider.emailController.value.text.trim(),
                              // };
                              // if ((controller.checkValid()) &&
                              //     (controller.checkEmailValidation(
                              //       controller.emailController.text,
                              //     ))) {
                              //   controller.verifyMail(verifyJsonData);
                              // }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpField(int index) {
    return Consumer<ForgotProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorConst.greyThree),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextField(
                controller: provider.controllers[index],
                focusNode: provider.focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 1,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  counterText: "",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (value) => provider.onOtpChanged(value, index),
              ),
            ),
          ),
        );
      },
    );
  }
}
