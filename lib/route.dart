import 'package:flutter/material.dart';
import 'package:orchids/auth/login_screen.dart';
import 'package:orchids/auth/order_cancel.dart';
import 'package:orchids/screens/catalogscreen/catalog_screen.dart';
import 'package:orchids/screens/homescreen/homescreen.dart';
import 'package:orchids/screens/productscreen/product_screen.dart';
import 'package:orchids/screens/sectionscreen/section_screen.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case CatalogScreen.routeName:
        return MaterialPageRoute(builder: (context) => CatalogScreen());
      case ProductScreen.routeName:
        return MaterialPageRoute(builder: (context) => ProductScreen());
      case SectionScreen.routeName:
        return MaterialPageRoute(builder: (context) => SectionScreen());

      case OrderCancelScreen.routeName:
        return MaterialPageRoute(builder: (context) => OrderCancelScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("something went wrong"),
            ),
          ),
        );
    }
  }
}
