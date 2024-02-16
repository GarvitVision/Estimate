// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Map items = {};

Future getItems() async {
  var pref = await SharedPreferences.getInstance();
  items = jsonDecode(pref.getString("ITEMS") ?? "");
}

Future saveItems() async {
  var pref = await SharedPreferences.getInstance();
  var itemsJson = jsonEncode(items);

  await pref.setString('ITEMS', itemsJson);
}

Future fetchItems() async {
  var pref = await SharedPreferences.getInstance();

  var encodeditems = pref.getString("ITEMS");

  if (encodeditems != null) {
    pentaWhItems = jsonDecode(encodeditems);

    paramItems = jsonDecode(encodeditems);

    paramWoodenItems = jsonDecode(encodeditems);

    zivaWhiteItems = jsonDecode(encodeditems);

    zivaBlackItems = jsonDecode(encodeditems);

    pentaWhiteGinaItems = jsonDecode(encodeditems);

    pentaBlackItems = jsonDecode(encodeditems);

    pentaWhiteFlatItems = jsonDecode(encodeditems);

    pentaBlackFlatItems = jsonDecode(encodeditems);

    greatWhiteItems = jsonDecode(encodeditems);

    l$TItems = jsonDecode(encodeditems);

    havellsFabioItems = jsonDecode(encodeditems);

    romaClassicItems = jsonDecode(encodeditems);

    romaUrbanItems = jsonDecode(encodeditems);

    enterQuantity = jsonDecode(encodeditems);
  }
}

var pentaWhItems;

var paramItems;

var paramWoodenItems;

var zivaWhiteItems;

var zivaBlackItems;

var pentaWhiteGinaItems;

var pentaBlackItems;

var pentaWhiteFlatItems;

var pentaBlackFlatItems;

var greatWhiteItems;

var l$TItems;

var havellsFabioItems;

var romaClassicItems;

var romaUrbanItems;

var enterQuantity;
