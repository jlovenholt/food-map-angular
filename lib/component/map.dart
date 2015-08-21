// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_component;

import 'package:angular/angular.dart';
import 'package:google_maps/google_maps.dart';
import 'package:food_map/service/map_ui.dart';
import 'package:food_map/service/class_restaurant.dart';
import 'package:food_map/service/class_meditech.dart';
import 'package:food_map/component/map/markers.dart';
import 'package:google_maps/google_maps_places.dart';

import 'dart:html' hide Animation, Point;
import 'dart:convert';

part "map/restaurant_search.dart";

GMap _map;
List<Building> buildings = [];
List<Restaurant> restaurants = [];

@Component(
    selector: 'map',
    templateUrl: 'packages/food_map/component/map.html',
    cssUrl: const [
  'packages/food_map/component/map.css',
  'packages/food_map/font-awesome/css/font-awesome.min.css'
])
class MapComponent implements ShadowRootAware {
  bool _searchMap;

  final markers = <Marker>[];
  final mapOptions = new MapOptions()
    ..zoom = 10
    ..mapTypeControl = false
    ..streetViewControl = false
    ..minZoom = 6
    ..maxZoom = 20
    ..styles = retroMapStyle;

  @NgTwoWay("search-map")
  bool get searchMap => _searchMap;
  void set searchMap(values) {
    print("values " + values.toString());
    if (values) {
      searchByRadius();
    }
    print("1_searchMap " + _searchMap.toString() + " searchMap " + searchMap.toString());
    _searchMap = false;
    print("2_searchMap " + _searchMap.toString() + " searchMap " + searchMap.toString());
  }

  onShadowRoot(root) {
    importData();
    _map = new GMap(root.querySelector("#map-canvas"), mapOptions);

    // Try HTML5 geolocation
    window.navigator.geolocation.getCurrentPosition().then((position) {
      final initPos =
          new LatLng(position.coords.latitude, position.coords.longitude);
      _map.center = initPos;
    }, onError: (error) {
      final initPos = new LatLng(44.9106355, -93.503853);
      _map.center = initPos;
      print(
          'ERROR: Geolocation service failed.  Defaulting to Minnetonka building');
    });
  }

  importData() {
    HttpRequest.getString('data.json').then((response) {
      Map data = JSON.decode(response);

      if (data.containsKey("meditech")) {
        for (Map bldng in data["meditech"]) {
          Building building = new Building.fromJsonMap(bldng);
          buildings.add(building);
          addMedBuilding(building, _map);
        }
      }
      if (data.containsKey("restaurants")) {
        for (Map food in data["restaurants"]) {
          Restaurant restaurant = new Restaurant.fromJsonMap(food);
          restaurants.add(restaurant);
          addRestaurant(restaurant, _map);
        }
      }
    });
  }
}
