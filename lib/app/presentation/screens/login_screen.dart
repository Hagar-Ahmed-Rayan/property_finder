import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:propertyfinder/core/shared.dart';
import 'package:propertyfinder/core/signin_methods.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var database = FirebaseDatabase.instance.ref();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    var phoneController = TextEditingController();
    // final GoogleSignIn _googleSignIn = GoogleSignIn();

    //  print(ShopLoginCubit.get(context).loginModel!.user!.address!);

    return SafeArea(
      child: Center(
        child: Scaffold(
            appBar: null,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*   Row(

                            children: [





                              SizedBox(
                                  width:200
                              ),
                           /*   defaultTextButton(
                                function: () {

                                },
                                text: 'log in',
                              ),*/




                            ],


                          ),*/

                  Form(
                      key: formKey,
                      child: Column(
                          //  crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (dynamic value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              label: 'Password',
                              validate: (dynamic value) {
                                if (value!.isEmpty) return 'please enter your password ';
                              },

                              /* onSubmit: (value) {
                                      if (formKey.currentState!.validate()) {
            ShopLoginCubit.get(context).userLogin(
            email: emailController.text,
            password: passwordController.text,
            );
            };
                                    },*/
                            ),
                          ])),
                  //   isPassword: ShopLoginCubit.get(context).isPassword,

                  const SizedBox(
                    height: 50.0,
                  ),

                  Container(
                    width: 300,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        3,
                      ),
                      color: Colors.green,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print((emailController.text));
                          print((passwordController.text));
                          database.child('users').push().set({
                            "email": emailController.text,
                            "password": passwordController.text,
                          });

                          //    navto(context,HomeLayoutScreen());

                          //          navto(context,AddressScreen());
                        }

                        print(('##############'));
                        //            if(ShopLoginCubit.get(context).sucessmess=='Success')
                      },
                      // function,
                      child: const Text(
                        'log in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(onTap: () {}, child: const Text(' forget password?')),
                          const SizedBox(
                            width: 5,
                          ),
                          defaultTextButton(
                            function: () {},
                            text: 'Sign up',
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 2.0,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('OR Continue with'),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 80,
                              height: 2.0,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () async {
                                UserCredential? credential = await signInWithFacebook();
                                if (credential != null) {
                                  print(" User signed in successfully,");
                                  // User signed in successfully, continue with your app logic
                                } // Handle Facebook button press
                              },
                              icon: const Icon(
                                Icons.facebook,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () async {
                                User currentGoogleUser;
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                var user = await authenticateWithGoogle();
                                if (user != null) {
                                  assert(!user.isAnonymous);
                                  currentGoogleUser = auth.currentUser!;
                                  assert(user.uid == currentGoogleUser.uid);

                                  debugPrint('signInWithGoogle succeeded: $user');
                                }

                                // final user = await signInWithGoogle();
                                // debugPrint('$user');
                                //    signOut();
                                /* FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen((User? user) {
                                        if (user == null) {
                                          print('User is currently signed out!');
                                        } else {
                                          print('User is signed in!');
                                        }
                                      });*/
                                // try {
                                //   UserCredential credential = await signInWithGoogle();
                                //
                                //   // Continue with your app logic after successful sign-in
                                // } catch (e) {
                                //   print("Sign in with Google failed: $e");
                                //   print("erorrrrrrrrrrrrrrrrr");
                                //
                                //   // Handle sign-in error if any
                                // }
                              },
                              icon: const Icon(
                                Icons.email, //google

                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              children: [
                                /*      Container(
                                        width:50,
                                        child: defaultFormField(
                                          controller: phoneController,
                                          type: TextInputType.phone,
                                          validate: (dynamic? value) {
                                            if (value!.isEmpty) {
                                              return 'please enter your phone number';
                                            }
                                          },
                                          label: 'phone number',
                                        ),
                                      ),*/
                                IconButton(
                                  //message
                                  onPressed: () {
                                    // Handle sms button press
                                    //    verifyPhoneNumber(phoneController.text);
                                    //   verifyPhoneNumber("+201094039861");
                                  },
                                  icon: const Icon(
                                    Icons.message,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
