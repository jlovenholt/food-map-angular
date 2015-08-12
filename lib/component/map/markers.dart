// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library add_markers;

import 'dart:html' hide Animation, Point;
import 'dart:convert';

import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';
import 'package:food_map/service/map_ui.dart';
import 'package:food_map/service/meditech_building.dart';
import 'package:food_map/service/restaurant.dart';
import 'package:food_map/component/map.dart';

//////////////////////////////////////////////
///MEDITECH Building Markers
//////////////////////////////////////////////

void addMedBuilding(Building building) {
  final medMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(building.lat, building.lng)
    ..map = map
    ..icon = medImg
    ..shape = shape
    ..animation = Animation.DROP
    ..title = building.name
    ..zIndex = 1);

  medMarker.onClick.listen((e) {
    openInfoWindow(buildingInfoWindow(building), medMarker);
  });
}

buildingInfoWindow(Building build) {
  String htmlRvws = '<div>MEDITECH ${build.name}</div>';
  return htmlRvws;
}

//////////////////////////////////////////////
///Restaurant Markers
//////////////////////////////////////////////

void addRestaurant(Restaurant restaurant) {
  final restMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(restaurant.lat, restaurant.lng)
    ..map = map
    ..icon = restImg
    ..shape = shape
    ..animation = Animation.DROP
    ..title = restaurant.name
    ..zIndex = 5);

  restMarker.onClick.listen((e) {
    openInfoWindow(restaurantInfoWindow(restaurant), restMarker);
  });
}

String restaurantInfoWindow(Restaurant rest) {
  String htmlRvws =
  '<div class="info-window">'
  '<div class="info-header">${rest.name}'
  '<button>'
  '<a href="${rest.website}" target="_blank">     '
  '<i class="icon icon-external-link-square info-button"></i>'
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
      starHtml = starHtml + '<i class="icon icon-star"></i>';
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

openInfoWindow(String content,Marker marker) {
  if (infowindow != null) {
    infowindow.close();
  }
  infowindow.content = content;
  infowindow.open(map, marker);
}
