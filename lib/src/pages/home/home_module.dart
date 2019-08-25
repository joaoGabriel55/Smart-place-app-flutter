import 'package:smart_place_app/src/pages/chart/chart_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smart_place_app/src/app/app_module.dart';
import 'package:smart_place_app/src/pages/home/home_bloc.dart';
import 'package:smart_place_app/src/pages/home/home_repository.dart';
import 'package:smart_place_app/src/shared/custom_dio/custom_dio.dart';

import 'home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(HomeModule.to.getDependency<HomeRepository>())),
        Bloc((i) => ChartBloc(HomeModule.to.getDependency<HomeRepository>()),singleton: false),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (inject) => HomeRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
