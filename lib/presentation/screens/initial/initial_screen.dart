
import 'package:cadetbank/core/navigation/routes.dart';
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/presentation/screens/initial/widgets/splash_logo.dart';
import 'package:cadetbank/presentation/screens/initial/widgets/splash_start_button.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SplashLogo()],
        )
      ),
    ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SplashStartButton(
          route: Routes.registration,
        ),

        SizedBox(height: Dimens.s10),

        SizedBox(height: Dimens.s20),
      ],
    ),
  );
}
