import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_chat_client/features/navigation/domain/entity/app_coordinate.dart';
import 'package:surf_practice_chat_client/features/navigation/domain/entity/coordinate.dart';

/// [RouteInformationParser] implementation.
/// Passed in the routeInformationParser field in [MaterialApp.router].
@immutable
class AppRouteInformationParser extends RouteInformationParser<Coordinate> {
  /// Public API doc?! Серьезно? Для конструкторов?
  @literal
  const AppRouteInformationParser();

  @override
  Future<Coordinate> parseRouteInformation(RouteInformation routeInformation) =>
      SynchronousFuture(AppCoordinate.initScreen);
}
