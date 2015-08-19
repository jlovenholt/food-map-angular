library food_map;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:food_map/component/map.dart';
import 'package:food_map/component/about.dart';
import 'package:food_map/component/settings.dart';
import 'package:food_map/routing/food_map_router.dart';
import 'package:food_map/menu_control.dart';

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
  applicationFactory()
  .rootContextType(MenuControl)
  .addModule(new MyAppModule()).run();
}