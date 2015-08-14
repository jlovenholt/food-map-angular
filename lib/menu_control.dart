library menu_control;

import "package:angular/angular.dart";

@Injectable(
    selector: "[menu-control]")
class MenuControl {
  final username = "Brenda Smith, RN";

  final filterShow = false;
  MenuControl(Scope scope) {

  }
}