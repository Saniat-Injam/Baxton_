// import 'dart:io';
// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
// import 'package:baxton/core/common/widgets/custom_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/klant_flow/authentication/controller/signup_controller.dart';
// import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class SignupScreen extends StatelessWidget {
//   SignupScreen({super.key});
//   SignupController singupController = Get.put(SignupController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         forceMaterialTransparency: true,
//         title: Text(
//           'Aanmelden',
//           style: getTextStyle(
//             color: Color(0xFF333333),
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               Text(
//                 'Naam',
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 12),
//               AuthCustomTextField(
//                 text: 'Voer uw naam in',
//                 onChanged: (value) {
//                   singupController.validateForm();
//                 },
//                 controller: singupController.nameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter Your Name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Telefoonnummer',
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 12),
//               // Phone Number
//               IntlPhoneField(
//                 controller: singupController.phoneController,
//                 initialCountryCode: 'US',
//                 dropdownIcon: Icon(
//                   CupertinoIcons.chevron_down,
//                   color: AppColors.primaryWhite,
//                   size: 16,
//                 ),
//                 dropdownIconPosition: IconPosition.trailing,
//                 decoration: InputDecoration(
//                   hintText: 'Voer uw telefoonnummer in',
//                   hintStyle: getTextStyle(
//                     color: Color(0xFF898989),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   filled: true,
//                   counterText: "",
//                   fillColor: AppColors.primaryWhite,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 0,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(64),
//                     borderSide: BorderSide(color: AppColors.primaryBlack),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(64),
//                     borderSide: BorderSide(color: AppColors.primaryBlack),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(64),
//                     borderSide: BorderSide(color: AppColors.primaryBlack),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(64),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(64),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                 ),
//                 flagsButtonPadding: EdgeInsets.zero,
//                 flagsButtonMargin: EdgeInsets.only(left: 16, right: 0),
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//               ),
//               // AuthCustomTextField(
//               //   controller: singupController.phoneController1,
//               //   text: 'Voer uw telefoonnummer in',
//               //   onChanged: (value) {
//               //     singupController.validateFrom();
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Voer uw telefoonnummer in e.g:+8801234567891';
//               //     }
//               //     RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
//               //     if (!phoneRegex.hasMatch(value)) {
//               //       return 'Ongeldig telefoonnummerformaat. Gebruik +8801XXXXXXXXX';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               SizedBox(height: 16),
//               Text(
//                 'Email',
//                 style: getTextStyle(
//                   color: Color(0xFF333333),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 12),

//               AuthCustomTextField(
//                 controller: singupController.emailController,
//                 text: 'Voer uw e-mail in',
//                 onChanged: (value) {
//                   singupController.validateForm();
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter a valid email address';
//                   }

//                   RegExp emailRegex = RegExp(
//                     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//                   );
//                   if (!emailRegex.hasMatch(value)) {
//                     return 'Invalid email format. Example: example@mail.com';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Wachtwoord',
//                 style: getTextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFF333333),
//                 ),
//               ),
//               SizedBox(height: 12),
//               // Obx(
//               //   () => AuthCustomTextField(
//               //     text: 'Voer uw wachtwoord in',
//               //     onChanged: (value) {
//               //       singupController.validateFrom();
//               //     },
//               //     controller: singupController.passwordController,
//               //     obscureText: true,
//               //     suffixIcon: IconButton(
//               //       icon: Icon(
//               //         singupController.isPasswordVisible.value
//               //             ? Icons.visibility_off_outlined
//               //             : Icons.visibility_outlined,
//               //         color: Color(0xff37B874),
//               //       ),
//               //       onPressed: singupController.togglePasswordVisibility,
//               //     ),
//               //     validator: (value) {
//               //       if (value == null || value.isEmpty) {
//               //         return 'Wachtwoord is vereist';
//               //       }
//               //       if (value.length < 8) {
//               //         return 'Wachtwoord moet minimaal 8 tekens lang zijn';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//               Obx(
//                 () => AuthCustomTextField(
//                   text: 'Voer uw wachtwoord in',
//                   controller: singupController.passwordController,
//                   obscureText:
//                       singupController.isPasswordVisible.value ? false : true,
//                   onChanged: (value) {
//                     singupController.onPasswordChanged(value);
//                     singupController.validateForm();
//                   },
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       singupController.isPasswordFieldEmpty.value
//                           ? Icons
//                               .visibility_outlined // field empty → show normal visibility icon
//                           : (!singupController.isPasswordVisible.value
//                               ? Icons
//                                   .visibility_off_outlined // field not empty and visible → show off icon
//                               : Icons
//                                   .visibility_outlined // field not empty and hidden → show normal
//                                   ),
//                       color: Color(0xff37B874),
//                     ),
//                     onPressed: singupController.togglePasswordVisibility,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Wachtwoord is vereist';
//                     }
//                     if (value.length < 8) {
//                       return 'Wachtwoord moet minimaal 8 tekens lang zijn';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Herhaal wachtwoord',
//                 style: getTextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               SizedBox(height: 12),
//               // Obx(
//               //   () => AuthCustomTextField(
//               //     controller: singupController.retypepasswordController,
//               //     text: 'Voer uw wachtwoord in',
//               //     onChanged: (value) {
//               //       singupController.validateForm();
//               //     },
//               //     // obscureText: singupController.isPasswordVisible1.value,
//               //     obscureText: true,
//               //     suffixIcon: IconButton(
//               //       icon: Icon(
//               //         singupController.isPasswordVisible.value
//               //             ? Icons.visibility_off_outlined
//               //             : Icons.visibility_outlined,
//               //         color: Color(0xff37B874),
//               //       ),
//               //       onPressed: singupController.togglePasswordVisibility1,
//               //     ),
//               //     validator: (value) {
//               //       if (value == null || value.isEmpty) {
//               //         return 'Bevestig uw wachtwoord';
//               //       }
//               //       if (value != singupController.passwordController.text) {
//               //         return 'Wachtwoorden komen niet overeen';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//               Obx(
//                 () => AuthCustomTextField(
//                   text: 'Voer uw wachtwoord in',
//                   controller: singupController.confirmedPasswordController,
//                   obscureText:
//                       singupController.isConfirmedPasswordVisible.value
//                           ? false
//                           : true,
//                   onChanged: (value) {
//                     singupController.onConfirmedPasswordChanged(value);
//                     singupController.validateForm();
//                   },
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       singupController.isConfirmedPasswordFieldEmpty.value
//                           ? Icons
//                               .visibility_outlined // field empty → show normal visibility icon
//                           : (!singupController.isConfirmedPasswordVisible.value
//                               ? Icons
//                                   .visibility_off_outlined // field not empty and visible → show off icon
//                               : Icons
//                                   .visibility_outlined // field not empty and hidden → show normal
//                                   ),
//                       color: Color(0xff37B874),
//                     ),
//                     onPressed:
//                         singupController.toggleConfirmedPasswordVisibility,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Wachtwoord is vereist';
//                     }
//                     if (value.length < 8) {
//                       return 'Wachtwoord moet minimaal 8 tekens lang zijn';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 32),
//               Obx(
//                 () => CustomButton(
//                   title: 'Aanmelden',
//                   textcolor: Colors.white,
//                   onPress:
//                       singupController.isFromValid.value
//                           ? () {
//                             singupController.registerUser();
//                           }
//                           : null,
//                   backgroundColor: AppColors.buttonPrimary,
//                   borderColor: Color(0xFFEBF8F1),
//                 ),
//               ),
//               SizedBox(height: 28),
//               SizedBox(height: 32),
//               if (Platform.isAndroid || Platform.isIOS) ...[],
//               SizedBox(height: 16),
//               if (Platform.isIOS) ...[],
//               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Heb je al een account?",
//                     style: getTextStyle(
//                       color: AppColors.textPrimary,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(LoginScreen());
//                     },
//                     child: Text(
//                       "Inloggen",
//                       style: getTextStyle(
//                         color: AppColors.primaryGold,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/authentication/controller/signup_controller.dart';
import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  SignupController singupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Aanmelden',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Naam',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                text: 'Voer uw naam in',
                onChanged: (value) {
                  singupController.validateForm();
                },
                controller: singupController.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Telefoonnummer',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              // Phone Number
              IntlPhoneField(
                controller: singupController.phoneController,
                initialCountryCode: 'US',
                dropdownIcon: Icon(
                  CupertinoIcons.chevron_down,
                  color: AppColors.primaryWhite,
                  size: 16,
                ),
                dropdownIconPosition: IconPosition.trailing,
                decoration: InputDecoration(
                  hintText: 'Voer uw telefoonnummer in',
                  hintStyle: getTextStyle(
                    color: Color(0xFF898989),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  counterText: "",
                  fillColor: AppColors.primaryWhite,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: BorderSide(color: AppColors.primaryBlack),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: BorderSide(color: AppColors.primaryBlack),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: BorderSide(color: AppColors.primaryBlack),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                flagsButtonPadding: EdgeInsets.zero,
                flagsButtonMargin: EdgeInsets.only(left: 16, right: 0),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (phone) {
                  // Use `.value` to update the RxString
                  singupController.phoneNumberWithCode.value = phone.completeNumber;
                  singupController.validateForm();  // Validate form after phone number change.
                },
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: getTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: singupController.emailController,
                text: 'Voer uw e-mail in',
                onChanged: (value) {
                  singupController.validateForm();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email address';
                  }

                  RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format. Example: example@mail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Wachtwoord',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () => AuthCustomTextField(
                  text: 'Voer uw wachtwoord in',
                  controller: singupController.passwordController,
                  obscureText:
                      singupController.isPasswordVisible.value ? false : true,
                  onChanged: (value) {
                    singupController.onPasswordChanged(value);
                    singupController.validateForm();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordFieldEmpty.value
                          ? Icons.visibility_outlined
                          : (!singupController.isPasswordVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                      color: Color(0xff37B874),
                    ),
                    onPressed: singupController.togglePasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wachtwoord is vereist';
                    }
                    if (value.length < 8) {
                      return 'Wachtwoord moet minimaal 8 tekens lang zijn';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Herhaal wachtwoord',
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () => AuthCustomTextField(
                  text: 'Voer uw wachtwoord in',
                  controller: singupController.confirmedPasswordController,
                  obscureText:
                      singupController.isConfirmedPasswordVisible.value
                          ? false
                          : true,
                  onChanged: (value) {
                    singupController.onConfirmedPasswordChanged(value);
                    singupController.validateForm();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isConfirmedPasswordFieldEmpty.value
                          ? Icons.visibility_outlined
                          : (!singupController.isConfirmedPasswordVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                      color: Color(0xff37B874),
                    ),
                    onPressed:
                        singupController.toggleConfirmedPasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wachtwoord is vereist';
                    }
                    if (value.length < 8) {
                      return 'Wachtwoord moet minimaal 8 tekens lang zijn';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  title: 'Aanmelden',
                  textcolor: Colors.white,
                  onPress: singupController.isFromValid.value
                      ? () {
                          singupController.registerUser();
                        }
                      : null,
                  backgroundColor: AppColors.buttonPrimary,
                  borderColor: Color(0xFFEBF8F1),
                ),
              ),
              SizedBox(height: 28),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Heb je al een account?",
                    style: getTextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      "Inloggen",
                      style: getTextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
