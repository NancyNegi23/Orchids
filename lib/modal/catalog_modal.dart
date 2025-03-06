import 'package:flutter/material.dart';

class CatalogThumbnail {
  final String name;
  final String imageUrl;
  final String price;
  final bool isCollaborated;
  final String collaborationPartner;
  final List<Color> itemColors;
  CatalogThumbnail({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.isCollaborated,
    this.collaborationPartner = "",
    required this.itemColors,
  });
}

List sweatshirtCatalog = [
  CatalogThumbnail(
    name: "Relaxed Fit Hoodie",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Ff3%2F8a%2Ff38a0c1839496284d5629c7297800ce88e3b07cc.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "1,499.00",
    isCollaborated: true,
    collaborationPartner: "ESSENTIALS",
    itemColors: [
      Colors.white,
      const Color(0xff801632),
      const Color(0xff286db5),
      const Color(0xff62717c),
      const Color(0xffccbea6),
      const Color(0xff155c75),
      const Color.fromARGB(255, 227, 148, 154),
    ],
  ),
  CatalogThumbnail(
    name: "Relaxed Fit Sweatshirt",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fc4%2F58%2Fc4583e5b8e7a670e78570ab67bba3a0d6dfc8d68.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "799.00",
    isCollaborated: false,
    collaborationPartner: "",
    itemColors: [
      const Color(0xffb3b3ae),
      const Color(0xffffffff),
      const Color.fromARGB(255, 122, 191, 125),
      const Color.fromARGB(255, 223, 138, 159),
    ],
  ),
  CatalogThumbnail(
    name: "Relaxed Fit Hoodie",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F93%2F22%2F93227ffcec223fec039b8597a67e286c0f902455.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "2,299.00",
    isCollaborated: false,
    collaborationPartner: "",
    itemColors: [
      const Color.fromARGB(255, 243, 210, 159),
      const Color(0xff385d3e),
      const Color(0xff3d251f),
    ],
  ),
  CatalogThumbnail(
    name: "Regular Fit Printed hoodie",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F5a%2Ffa%2F5afa8cb2c93fdc42bb4362df90a467a1c60a8b3a.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "1,999.00",
    isCollaborated: false,
    collaborationPartner: "",
    itemColors: [
      const Color(0xffe5decc),
      const Color(0xffcccfcf),
      const Color(0xffb05e55),
      const Color(0xffa68157),
      const Color(0xff242326),
    ],
  ),
  CatalogThumbnail(
    name: "Oversized Fit Cotton zip-through hoodie",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F76%2F42%2F7642faac76c13fa25794b51433fdd91f89ae2566.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "2,699.00",
    isCollaborated: true,
    collaborationPartner: "BLANK STAPLES",
    itemColors: [
      const Color(0xffdee0e5),
      const Color(0xff2a282d),
      const Color(0xffb4b4b5),
      const Color(0xff8d7468),
      const Color(0xffb87f50),
      const Color(0xff541b14),
      const Color(0xff441b1a),
    ],
  ),
  CatalogThumbnail(
    name: "Essentials No 11: THE SWEATSHIRT",
    imageUrl:
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F88%2F26%2F8826aefee43e863d845797c086567b735afaab8e.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    price: "2,699.00",
    isCollaborated: true,
    collaborationPartner: "ESSENTIALS",
    itemColors: [
      const Color(0xff1b1719),
      const Color(0xff654e41),
      const Color(0xffe4e3d5),
    ],
  ),
];
