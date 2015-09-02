// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library add_markers;

import 'dart:html' hide Animation, Point;
import 'dart:convert';

import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';
import 'package:food_map/service/map_ui.dart';
import 'package:food_map/service/class_meditech.dart';
import 'package:food_map/service/class_restaurant.dart';
import 'package:food_map/component/map.dart';

InfoWindow infowindow = new InfoWindow();

//////////////////////////////////////////////
///MEDITECH Building Markers
//////////////////////////////////////////////

void addMedBuilding(Building building, GMap _map) {
  final medMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(building.lat, building.lng)
    ..map = _map
    ..icon = medImg
    ..shape = shape
    ..animation = Animation.DROP
    ..title = building.name
    ..zIndex = 1);

  medMarker.onClick.listen((e) {
    openInfoWindow(buildingInfoWindow(building), medMarker, _map);
  });
}

buildingInfoWindow(Building build) {
  String htmlRvws = '<div>MEDITECH ${build.name}</div>';
  return htmlRvws;
}

//////////////////////////////////////////////
///Restaurant Markers
//////////////////////////////////////////////

void addRestaurant(Restaurant restaurant, GMap _map) {
  final restMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(restaurant.lat, restaurant.lng)
    ..map = _map
    ..icon = restImg
    ..shape = shape
    ..animation = Animation.DROP
    ..title = restaurant.name
    ..zIndex = 5);

  restMarker.onClick.listen((e) {
    openInfoWindow(restaurantInfoWindow(restaurant), restMarker, _map);
  });
}

String restaurantInfoWindow(Restaurant rest) {
  String htmlRvws =
  '<div class="info-window">'
  '<div class="info-header">${rest.name}'
  '<button>'
  '<a href="${rest.website}" target="_blank">     '
  '<i class="fa fa-external-link-square info-button"></i>'
  '</a>'
  '</button>'
  '</div>' +
  buildInfoReviews(rest) +
  '</div>';
  return htmlRvws;
}

String buildInfoReviews(Restaurant rest) {
  String reviewHtml = "";
  rest.reviews.forEach((review) {
    String starHtml = "";
    for (int i = 0; i < review.val; i++) {
      starHtml = starHtml + '<i class="fa fa-star"></i>';
    }
    reviewHtml = reviewHtml +
    '<div class="info-review">' +
    starHtml +
    '<div class="info-user"></div>'
    '<p>${review.cmt}</p>';
  });
  return reviewHtml;
}

/////////////////////////////////////////////////

openInfoWindow(String content,Marker marker, GMap _map) {
  if (infowindow != null) {
    infowindow.close();
  }
  infowindow.content = content;
  infowindow.open(_map, marker);
  return infowindow;
}
