// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library restaurant;

class Review {
  int val;
  String cmt;

  Review.fromJsonMap(Map json) {
    val = json["val"];
    cmt = json["cmt"];
  }

  Review(this.val, this.cmt);
}

class Restaurant {
  String id;
  String name;
  num lat;
  num lng;
  List<Review> reviews = [];
  bool show;
  String website;

  Restaurant(this.id);

  Restaurant.fromJsonMap(Map json) {
    id = json["id"];
    name = json["name"];
    lat = json["lat"];
    lng = json["lng"];
    website = json["website"];
    for (Map rvw in json["reviews"]) {
      Review review = new Review.fromJsonMap(rvw);
      reviews.add(review);
    }
    show = true;
  }
}
