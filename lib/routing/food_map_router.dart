// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library recipe_book_routing;

import 'package:angular/angular.dart';

void mapRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'map': ngRoute(
        path: '/map',
        view: 'view/map.html',
        mount: {
          'add': ngRoute(
              path: '/add',
              view: 'view/add.html')
        }),
    'settings': ngRoute(
        path: '/settings',
        view: 'view/settings.html'),
    'about': ngRoute(
        path: '/about',
        view: 'view/about.html'),
    'view_default': ngRoute(
        defaultRoute: true,
        enter: (RouteEnterEvent e) =>
        router.go('map', {},
        startingFrom: router.root.findRoute('map'),
        replace: true))

  });
}