// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of map_component;

List<Marker> searchMarkers = <Marker>[];
InfoWindow infoWindowAdd;

searchByRadius() {
  ///Remove old markers
  for (Marker mark in searchMarkers) {
    mark.visible = false;
  }
//  if (searchInfoWindow != null) {
//    print(searchInfoWindow);
//    searchInfoWindow.cancel();
//  }
  ///Search for new markers
  final request = new PlaceSearchRequest()
    ..location = _map.center
    ..bounds = _map.bounds
    ..types = ['restaurant'];

  void callback(List<PlaceResult> results, PlacesServiceStatus status,
      PlaceSearchPagination pagination) {
    if (status == PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
        createMarker(results[i]);
      }
    }
  }

  final service = new PlacesService(_map);
  service.nearbySearch(request, callback);
}

//////////////////////////////////////////////
///Search Restaurant Markers
//////////////////////////////////////////////

void createMarker(PlaceResult place) {
  final srchMarker = new Marker(new MarkerOptions()
    ..map = _map
    ..position = place.geometry.location
    ..icon = srchImg
    ..shape = shape
    ..zIndex = 3);
  searchMarkers.add(srchMarker);

  addToRestaurants() {
    String id = (srchMarker.position.lat.toInt().toString() +
        place.name.replaceAll(new RegExp(r' '), '') +
        srchMarker.position.lng.toInt().toString());
    var restaurant = new Restaurant(id)
      ..name = place.name
      ..lat = srchMarker.position.lat
      ..lng = srchMarker.position.lng
      ..reviews = [new Review(3, 'asdflkjh')]
      ..show = true
      ..website = place.website;
    restaurants.add(restaurant);
    addRestaurant(restaurant, _map);
    infowindow.close();
  }

  srchMarker.onClick.listen((e) {
    infoWindowAdd = openInfoWindow(searchInfoWindow(place), srchMarker, _map);
    infoWindowAdd.onDomready.listen((event) {
      var one = querySelector('map').shadowRoot.querySelector('#map-canvas').querySelector('.addInfoBtn');
      print(one);
      one.onClick.listen((e) {
        addToRestaurants();
      });
//    test();
//    infoWindowAdd.addListener('domready', test(infoWindowAdd));
    });
  });
}

String searchInfoWindow(PlaceResult place) {
  String searchInfoContent = '<div class="info-window">'
      '<div class="info-header">'
      '<img src=${place.icon} style="width:16px;height:16px;">${place.name}'
      '<button>'
      '<i class="fa fa-plus addInfoBtn"></i>'
      '</button>'
      '</div>${place.placeId}'
      '</div>';
  return searchInfoContent;
}
