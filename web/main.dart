library food_map;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:logging/logging.dart';
import 'package:google_maps/google_maps.dart';

import 'package:food_map/component/map.dart';
import 'package:food_map/component/about.dart';
import 'package:food_map/component/settings.dart';
import 'package:food_map/routing/food_map_router.dart';

class MyAppModule extends Module {
  MyAppModule() {
    bind(MapComponent);
    bind(SettingsComponent);
    bind(AboutComponent);
    bind(RouteInitializerFn, toValue: mapRouteInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }
}

void main() {
  Logger.root..level = Level.FINEST
    ..onRecord.listen((LogRecord r) { print(r.message); });

  applicationFactory()
  .addModule(new MyAppModule())
  .run();
}