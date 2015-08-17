library menu_control;

import "package:angular/angular.dart";
import 'dart:html';

@Injectable()
class MenuControl implements ScopeAware {
  final username = "Brenda Smith, RN";
  final filterShow = false;
  String menuOption = 'map';
  Scope scope;

  MenuControl() {}
}

initNavMenu() {
  var navdrawerContainer = querySelector('.navdrawer-container');
  var appbarElement = querySelector('.app-bar');
  var menuBtn = querySelector('.menu');
  var main = querySelector('main');

  closeMenu(e) {
    document.body.classes.remove('open');
    appbarElement.classes.remove('open');
    navdrawerContainer.classes.remove('open');
  }

  toggleMenu(e) {
    document.body.classes.toggle('open');
    appbarElement.classes.toggle('open');
    navdrawerContainer.classes.toggle('open');
    navdrawerContainer.classes.add('opened');
  }

  main.onClick.listen(closeMenu);
  menuBtn.onClick.listen(toggleMenu);
  navdrawerContainer.onClick.listen((event) {
    if (event.target.nodeName == 'A' || event.target.nodeName == 'LI') {
      closeMenu(event);
    }
  });
}
