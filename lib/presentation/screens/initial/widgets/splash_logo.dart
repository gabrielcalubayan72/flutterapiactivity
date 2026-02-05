import 'package:cadetbank/core/res/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/assets.dart';
import 'package:cadetbank/core/res/values/dimens.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.pokepedia,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: Dimens.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.s50),
          child: Image.asset(Assets.initPokeLogo),
        ),
      ],
    );
  }
}