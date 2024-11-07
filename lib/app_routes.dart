import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'home_page.dart';
import 'person_edit_page.dart';

part 'app_routes.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
  );
}

@TypedGoRoute<HomePageRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<PersonEditPageRoute>(
      path: 'person/edit/:personId',
    ),
    TypedGoRoute<PersonNewPageRoute>(
      path: 'person/new',
    ),
  ],
)
class HomePageRoute extends GoRouteData {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class PersonEditPageRoute extends GoRouteData {
  const PersonEditPageRoute(this.personId);
  final int personId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PersonEditPage(personId);
}

class PersonNewPageRoute extends GoRouteData {
  const PersonNewPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PersonEditPage(null);
}
