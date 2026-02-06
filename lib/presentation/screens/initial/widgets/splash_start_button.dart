import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/core/res/values/strings.dart';
import 'package:cadetbank/core/navigation/routes.dart';

class SplashStartButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? route;

  const SplashStartButton({
    super.key,
    this.onPressed,
    this.route = Routes.registration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.s20,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed ?? () {
            Navigator.of(context).pushNamed(route!);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: const Text(
            Strings.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}