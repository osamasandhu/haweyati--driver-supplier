import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signin_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/signin_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-home_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/supplier-home_page.dart';

import 'add-varients.dart';
import 'driver-supplier-map.dart';
import 'map-page.dart';

final routes = {
  "/": (context) => SupplierHomePage(),
  "/driver-home-page": (context) =>DriverHomePage(),
  "/sign-in": (context) => SignInPage(),
  "/sign-up": (context) => SignUpPage(),
  "/pre-sign-in": (context) => PreSignInPage(),
  "/pre-sign-up": (context) => PreSignUpPage(),
  "/map": (context) => MapPage(),
  "/variants": (context) => AddVariants(),

};