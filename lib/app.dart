import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/cubit/auth_cubit.dart';
import 'package:socialmedia/cubit/auth_states.dart';
import 'package:socialmedia/firebase_auth_repo.dart';
import 'package:socialmedia/pages/auth_page.dart';
import 'package:socialmedia/pages/home_page.dart';
import 'package:socialmedia/profile/firebase_profile_repo.dart';
import 'package:socialmedia/profile/profile_cubit.dart';
import 'package:socialmedia/themes/dark_mode.dart';

/*APP -Root level

Repositories: firebase

Bloc Providers
-auth
-profile
-post
-search
-theme

Check Auh State
-unauthenticated => auth page
-authenticated =>home page
*/

class MyApp extends StatelessWidget {
  //auth repo
  final authRepo = FirebaseAuthRepo();
  //profile repo
  final profileRepo = FirebaseProfileRepo();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        //profile cubit
        BlocProvider(
          create: (context) => ProfileCubit(profileRepo: profileRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, authStates) {
            //unauthenticated !!
            if (authStates is UnAuthenticated) {
              return AuthPage();
            }
            //authenticated one !
            if (authStates is Authenticated) {
              return HomePage();
            }
            //loading ..
            else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          //listen for any errors
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        theme: lightMode,
      ),
    );
  }
}
