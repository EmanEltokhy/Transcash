import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/signin_screen/signin_screen.dart';

// import 'package:email_validator/email_validator.dart';
import 'package:transcash/shared/components/components.dart';
import '../../widgets/clips.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final login = LoginCubit.get(context);
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "please sign in to continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          defaultFormField(
                            context: context,
                            controller: login.nationalController,
                            type: TextInputType.number,
                            label: 'National ID',
                            prefix: Icons.credit_card_rounded,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              context: context,
                              controller: login.passwordController,
                              type: TextInputType.visiblePassword,
                              label: 'PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: login.suffix,
                              isPassword: login.isPassword,
                              suffixPressed: login.changePasswordVisibility),
                          const SizedBox(
                            height: 60,
                          ),
                          defaultButton(150.0, 50.0, 'LOGIN', true, () {
                            if (formKey.currentState?.validate() == null) {
                              login.userLogin(context: context);
                            }
                          }, context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            child: Text(
                              "Don't have an account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                              onPressed: () {
                                navigate(context, SignupScreen());
                              },
                              child: Text(
                                "Sign up",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.teal,
                                    ),
                              ))
                        ],
                      ),
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
