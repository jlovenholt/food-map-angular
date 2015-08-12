// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library meditech_building;

class Building {
  String id;
  String name;
  num lat;
  num lng;
  bool show;

  Building.fromJsonMap(Map json) {
    id = json["id"];
    name = json["name"];
    lat = json["lat"];
    lng = json["lng"];
    show = true;
  }
}
