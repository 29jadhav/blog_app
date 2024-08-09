import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print("MyApp Init state.. ");
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.appThemeDark,
      initialRoute: SigninPage.signinPage,
      routes: {
        SigninPage.signinPage: (context) =>
            BlocSelector<AppUserCubit, AppUserState, bool>(
              selector: (state) {
                print("state in selector $state");
                return state is AppUserLoggedIn;
              },
              builder: (context, isUserLoggedIn) {
                print("state in builder $isUserLoggedIn");
                if (isUserLoggedIn) {
                  return const Scaffold(
                    body: Center(
                      child: Text("Logged In"),
                    ),
                  );
                }
                return const SigninPage();
              },
            ),
        SignupPage.signupPage: (context) => const SignupPage(),
      },
    );
  }
}
