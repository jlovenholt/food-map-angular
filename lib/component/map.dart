// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_component;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:google_maps/google_maps.dart';
import 'package:food_map/service/map_ui.dart';
import 'package:food_map/service/restaurant.dart';
import 'package:food_map/service/meditech_building.dart';
import 'package:food_map/component/map/markers.dart';

import 'dart:html' hide Animation, Point;
import 'dart:convert';

GMap map;
InfoWindow infowindow = new InfoWindow();

@Component(
    selector: 'map',
    templateUrl: 'map.html',
    cssUrl: 'map.css')
class MapComponent implements ShadowRootAware {
  final markers = <Marker> [];
  final mapOptions = new MapOptions()
    ..zoom = 10
    ..mapTypeControl = false
    ..streetViewControl = false
    ..minZoom = 6
    ..maxZoom = 20
    ..styles = retroMapStyle;

  MapComponent() {
    map = new GMap(document.getElementById("map-canvas"), mapOptions);

    // Try HTML5 geolocation
    window.navigator.geolocation.getCurrentPosition().then((position) {
      final initPos = new LatLng(position.coords.latitude, position.coords.longitude);
      map.center = initPos;
    }, onError: (error) {
      final initPos = new LatLng(44.9106355, -93.503853);
      map.center = initPos;
      print('ERROR: Geolocation service failed.  Defaulting to Minnetonka building');
    });
  }

  List<Building> buildings = [];
  List<Restaurant> restaurants = [];

  importData() {
    HttpRequest.getString('data.json').then((response) {
      Map data = JSON.decode(response);

      if (data.containsKey("meditech")) {
        for (Map bldng in data["meditech"]) {
          Building building = new Building.fromJsonMap(bldng);
          buildings.add(building);
          addMedBuilding(building);
        }
      }
      if (data.containsKey("restaurants")) {
        for (Map food in data["restaurants"]) {
          Restaurant restaurant = new Restaurant.fromJsonMap(food);
          restaurants.add(restaurant);
          addRestaurant(restaurant);
        }
      }
    });
  }
}