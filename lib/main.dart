import 'package:animation/core/utils/api_services.dart';
import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/manager/Alzheimer_stepper_cubit.dart';
import 'package:animation/features/Autism/presentation/manager/autism_cubit.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/splash_and_getStarted/presentation/views/splash_view.dart';
import 'package:animation/features/tumor_stepper/presentation/manager/tumor_stepper_cubit.dart';
import 'package:animation/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => TumorStepperCubit(ApiService(baseUrl: baseApiForEmulator)),
        ),
        BlocProvider(
          create: (context) => AlzheimerStepperCubit(),
        ),
        BlocProvider(create: (context) => AutismCubit(),),
        BlocProvider(create: (context) => StrokeCubit(ApiService(baseUrl: baseApiForEmulator)),),
      
      ],
      child: const GetMaterialApp(
        initialRoute: 'SplashPage',
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
