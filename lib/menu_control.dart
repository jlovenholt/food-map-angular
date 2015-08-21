library menu_control;

import "package:angular/angular.dart";
import 'dart:html';

@Injectable()
class MenuControl implements ScopeAware {
  String username = "";
  bool searchMap = false;

  String menuOption = 'map';
  Scope scope;

  var navdrawerContainer = querySelector('.navdrawer-container');
  var appbarElement = querySelector('.app-bar');

  MenuControl() {
  }

  restSearch(){
    print("rest1_SearchMap " + searchMap.toString());
   searchMap = true;
    print("rest2_SearchMap " + searchMap.toString());
  }

  onMenuListClick(String page){
    menuOption = page;
    onBodyClick();
  }

  onBarsClick(){
    document.body.classes.toggle('open');
    appbarElement.classes.toggle('open');
    navdrawerContainer.classes.toggle('open');
    navdrawerContainer.classes.add('opened');
  }

  onBodyClick(){
    document.body.classes.remove('open');
    appbarElement.classes.remove('open');
    navdrawerContainer.classes.remove('open');
  }
}
