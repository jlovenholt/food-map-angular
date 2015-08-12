library map_ui;

import 'package:google_maps/google_maps.dart';

final shape = new MarkerShape()
  ..coords = [16, 32, 5, 8, 11, 0, 21, 0, 27, 8]
  ..type = 'poly';

final IMG_URL = "https://maps.google.com/mapfiles/kml/paddle";

final medImg = new Icon()
  ..url = '${IMG_URL}/grn-blank.png'
  ..scaledSize = new Size(32, 32);

final restImg = new Icon()
  ..url = '${IMG_URL}/orange-stars.png'
  ..scaledSize = new Size(32, 32);

final srchImg = new Icon()
  ..url = '${IMG_URL}/red-circle.png'
  ..scaledSize = new Size(32, 32);


final retroMapStyle = <MapTypeStyle>[
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.WATER
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[
    new MapTypeStyler()..color = "#84afa3",
    new MapTypeStyler()..lightness = 52,
    new MapTypeStyler()..visibility = "simplified"
  ],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = 'off'],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_BUSINESS
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = 'on'],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ALL
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[
    new MapTypeStyler()..saturation = -17,
    new MapTypeStyler()..gamma = 0.36
  ],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT_LINE
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..color = "#3F518C"],
];
