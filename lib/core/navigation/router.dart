
import 'package:cadetbank/core/navigation/routes.dart';
import 'package:cadetbank/core/utils/dio_factory.dart';
import 'package:cadetbank/data/data_source/remote/pokemon_remote_data_source_impl.dart';
import 'package:cadetbank/data/repositories/pokemon_repository_impl.dart';
import 'package:cadetbank/presentation/cubits/pokemon_cubit.dart';
import 'package:cadetbank/presentation/screens/home/home_screen.dart';
import 'package:cadetbank/presentation/screens/initial/initial_screen.dart';
import 'package:cadetbank/presentation/screens/registration/registration_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const _dioFactory = DioFactory();

  static Dio? _dio;
  
  static Future<Dio> getDio() async {
    _dio ??= await _dioFactory.createDio();
    return _dio!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.init:
        return AppTransition.none(child: const InitialScreen());
      case Routes.registration:
        return AppTransition.slide(child: buildRegistrationScreen());
      case Routes.home:
        return AppTransition.slide(child: const HomeScreen());
      default:
        return AppTransition.none(child: const SizedBox.shrink());
    }
  }

  static Widget buildRegistrationScreen() {
    return FutureBuilder<Dio>(
      future: getDio(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final dio = snapshot.data!;
        final dataSource = PokemonRemoteDataSourceImpl(dio);
        final repository = PokemonRepositoryImpl(dataSource);

        return BlocProvider(
          create: (_) => PokemonCubit(repository),
          child: const RegistrationScreen(),
        );
      },
    );
  }
}


class AppTransition {

  static PageRouteBuilder none({
    required Widget child,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  static PageRouteBuilder slide({
    required Widget child,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the slide transition
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var slideAnimation = animation.drive(tween);

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
    );
  }
}