import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/authentication/presentation/views/login_view.dart';
import 'package:animation/features/home/presentation/views/about_app_view.dart';
import 'package:animation/features/home/presentation/views/contact_us_view.dart';
import 'package:animation/features/home/presentation/views/instructions_view.dart';
import 'package:animation/features/home/presentation/views/patients_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;
import 'package:google_sign_in/google_sign_in.dart';

class HomeViewDrawer extends StatelessWidget {
  const HomeViewDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          String userEmail = '';
          if (state is GetUserEmailSuccess) {
            String email = state.user.email!;
            for (int i = 0; i < email.length; i++) {
              if (email[i] == '@') {
                userEmail = email.substring(0, i);
                break;
              }
            }
          }
          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Image.asset(
                  kLogo,
                  fit: BoxFit.cover,
                  width: 70,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      userEmail,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.4)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  trans.Get.to(const PatientsView(),
                      transition: trans.Transition.downToUp);
                },
                title: const Row(
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Patients',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: () {
                  trans.Get.to(const InstructionsView(),
                      transition: trans.Transition.downToUp);
                },
                title: const Row(
                  children: [
                    Icon(
                      Icons.change_circle_rounded,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Instructions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.policy_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About Application',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                onTap: () {
                  trans.Get.to(const AboutAppView(),
                      transition: trans.Transition.downToUp);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contact Us',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                onTap: () {
                  trans.Get.to(const ContactUsView(),
                      transition: trans.Transition.downToUp);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log Out',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {
                  bool shouldLogOut = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Log Out'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Log Out'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogOut) {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                    trans.Get.offAll(LoginPage());
                    showSuccessSnackBar(context, 'Log out Success');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
