import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcash/shared/cubit/cubit.dart';
import 'package:transcash/shared/cubit/states.dart';
import '../shared/components/components.dart';

class profileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        final user = UserCubit.get(context);

          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: const Color(0xfd4d4d5fa)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg')
                              )
                          ),
                          // child: CircleAvatar(
                          //   radius: 64.0,
                          //   // backgroundColor:
                          //   // Theme.of(context).scaffoldBackgroundColor,
                          //   child:
                          //   // state.dentist.profileimage!
                          //   //     .startsWith('https')
                          //   //     ?
                          //   CircleAvatar(
                          //       radius: 60.0,
                          //       backgroundImage: NetworkImage(
                          //           'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg'))
                          //       // : CircleAvatar(
                          //       // radius: 60.0,
                          //       // backgroundImage: FileImage(
                          //       //     File(state.dentist.profileimage!))),
                          // ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                ),
                                color: Colors.teal,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt_outlined),
                                color: Colors.white,
                                padding: const EdgeInsets.only(left: 0, top: 1),
                                onPressed: () {
                                  // AppCubit.get(context).getProfileImage();
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  defaultFormField(
                    initialValue: '${user.customer.fName} ${user.customer.lName}',
                    type: TextInputType.name,
                    isClickable: false,
                    label: 'NAME',
                    prefix: Icons.person,
                    context: context,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),defaultFormField(
                    initialValue: user.customer.username,
                    isClickable: false,
                    type: TextInputType.name,
                    label: 'USERNAME',
                    prefix: Icons.person,
                    context: context,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  defaultFormField(
                    initialValue: user.customer.email,
                    isClickable: false,
                    type: TextInputType.emailAddress,
                    label: 'EMAIL',
                    prefix: Icons.email_outlined,
                    context: context,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  defaultFormField(
                    initialValue: user.customer.nationalId,
                    isClickable: false,
                    type: TextInputType.number,
                    label: 'National ID',
                    prefix: Icons.add_card_sharp,
                    context: context,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  defaultButton(size.width, 50.0, "Logout", false, () {
                    user.logout(context);
                  },context
                  )
                ],
              ),
            ),
          );
        }
        // else if (state is GetDentistDataLoadingState) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else if (state is GetDentistDataErrorState) {
        //   return Center(
        //     child: Text(state.error),
        //   );
        // } else if (state is UpdateDentistDataErrorState) {
        //   return Center(
        //     child: Text(state.error),
        //   );
        // } else {
        //   return SizedBox();
        // }
      // },
    );
  }
}