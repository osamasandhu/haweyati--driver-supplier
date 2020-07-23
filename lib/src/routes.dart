import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-finishing-Materail.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-signin_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signin_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/supplier-signin_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/supplier-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-home_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/supplier-home_page.dart';
import '../map.dart';

final routes = {
  "/": (context) => SupplierHomePage(),
  "/driver-home-page": (context) =>DriverHomePage(),
  "/supplier-sign-in": (context) => SupplierSignInPage(),
  "/supplier-sign-up": (context) => SupplierSignUpPage(),
  "/driver-sign-in": (context) => DriverSignInPage(),
  "/driver-pre-sign-up": (context) => DriverSignUpPage(),
  '/select-location' : (context) => Location(),
  "/pre-sign-in": (context) => PreSignInPage(),
  "/pre-sign-up": (context) => PreSignUpPage(),
  "/add-finishing-material": (context) => AddFinishingMaterial(),
};