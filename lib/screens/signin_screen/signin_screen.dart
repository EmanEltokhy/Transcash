import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../widgets/clips.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> fNameFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> lNameFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> userNameFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> nationalFieldKey = GlobalKey();

  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> confirmedFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String? nameValidator(String? value) {
      if (value!.isEmpty) {
        return 'Must not be empty';
      }
      return null;
    }
    String? isEmailValid(String? email) {
      // Define a regular expression for a valid email address
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      // Test the email against the regular expression
      if(!emailRegex.hasMatch(email!)){
        return 'not valid email';
      }
      return null;
    }

    String? phoneValidator(String? value) {
      if (value!.isEmpty) {
        return 'Please Enter a Phone Number';
      } else if (!RegExp(r'^01[0125][0-9]{8}').hasMatch(value) ||
          value.length != 11) {
        return 'Please Enter a Valid Phone Number';
      }
      return null;
    }

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final register = RegisterCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: DrawClip(),
                          child: Container(
                              color: Colors.teal[200],
                              height: size.height / 2.9),
                        ),
                        ClipPath(
                          clipper: DrawClip1(),
                          child: Container(
                              color: Colors.teal, height: size.height / 2.9),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 30,
                          child: Text(
                            "CREATE ACCOUNT",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            defaultFormField(
                                controller: register.fNameController,
                                onChange: (value) {
                                  fNameFieldKey.currentState!.validate();
                                },
                                key: fNameFieldKey,
                                validate: nameValidator,
                                type: TextInputType.name,
                                label: 'First Name',
                                prefix: Icons.person,
                                context: context),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              context: context,
                              controller: register.lNameController,
                              onChange: (value) {
                                lNameFieldKey.currentState!.validate();
                              },
                              validate: nameValidator,
                              key: lNameFieldKey,
                              type: TextInputType.text,
                              label: 'Last Name',
                              prefix: Icons.person,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              context: context,
                              controller: register.usernameController,
                              onChange: (value) {
                                userNameFieldKey.currentState!.validate();
                              },
                              validate: nameValidator,
                              key: userNameFieldKey,
                              type: TextInputType.text,
                              label: 'Username',
                              prefix: Icons.person,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              context: context,
                              controller: register.emailController,
                              onChange: (value) {
                                emailFieldKey.currentState!.validate();
                              },
                              validate: isEmailValid,
                              key: emailFieldKey,
                              type: TextInputType.emailAddress,
                              label: 'Email',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              context: context,
                              controller: register.nationalIdController,
                              onChange: (value) {
                                nationalFieldKey.currentState!.validate();
                              },
                              key: nationalFieldKey,
                              validate: nameValidator,
                              type: TextInputType.number,
                              label: 'National ID',
                              prefix: Icons.credit_card_sharp,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              context: context,
                              controller: register.phoneNumberController,
                              validate: phoneValidator,
                              onChange: (value) {
                                phoneFieldKey.currentState!.validate();
                              },
                              key: phoneFieldKey,
                              type: TextInputType.phone,
                              label: 'Phone Number',
                              prefix: Icons.phone,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              controller: register.passwordController,
                              type: TextInputType.visiblePassword,
                              context: context,
                              label: 'PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: register.suffix,
                              onSubmit: (value) {},
                              isPassword: register.isPassword,
                              suffixPressed: register.changePasswordVisibility,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              type: TextInputType.visiblePassword,
                              controller: register.confirmedPassController,
                              context: context,
                              label: 'CONFIRM PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: register.suffix,
                              onChange: (value) {
                                confirmedFieldKey.currentState!.validate();
                              },
                              validate: (String? value) {
                                if(value!.isEmpty){
                                  return 'Enter password';
                                }
                                else if (register.passwordController.text !=
                                    value) {
                                  return 'Password doesn\'t match';
                                }
                                return null;
                              },
                              key: confirmedFieldKey,
                              isPassword: register.isPassword,
                              suffixPressed: register.changePasswordVisibility,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: register.checkBoxValue,
                                  onChanged: register.changeCheckBox,
                                  activeColor: const Color(0xff54ccf5),
                                ),
                                Text(
                                  'I agree to the terms and conditions',
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultButton(150.0, 50.0, 'SIGNUP', true,
                                    () {
                                  if (formKey.currentState!.validate()) {
                                      try {
                                        register.userRegister(context: context);
                                      }
                                      catch(error) {
                                        print(error);
                                      }
                                  }
                                }, context),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
