import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signup_page.dart';
import 'package:haweyati_supplier_driver_app/supplier/auth-pages/supplier-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-home_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/helpline_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/notifications_page.dart';
import 'package:haweyati_supplier_driver_app/supplier/auth-pages/waiting-approval_page.dart';
import 'package:haweyati_supplier_driver_app/supplier/service-requests/buildingMaterial/available-building-materials-categories.dart';
import 'package:haweyati_supplier_driver_app/supplier/service-requests/dumpster/add-dumpster_page.dart';
import 'package:haweyati_supplier_driver_app/supplier/service-requests/dumpster/available-dumspters-list_page.dart';
import 'package:haweyati_supplier_driver_app/supplier/service-requests/finishingMaterial/add-finishing-Materail.dart';
import 'package:haweyati_supplier_driver_app/supplier/supplier-homepage.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import '../widgits/map.dart';
import 'ui/pages/auth/pre-sign-in_page.dart';
import 'ui/pages/supplier/services/available-services_page.dart';

final routes = {
  '/': (context) =>  PreSignInPage(),
  '/helpline': (context) => HelplinePage(),
  '/notifications': (context) => NotificationsPage(),
  '/location-picker': (context) => LocationPickerPage(),

  '/driver-home-page': (context) => DriverHomePage(),

  /// Supplier Routes.
  '/supplier-home-page': (context) => SupplierHomePage(),
  '/supplier-services': (context) => SupplierAvailableServicesPage(),

  '/dumpster-request': (context) => DumpsterRequestPage(),
  '/services-dumpsters': (context) => AvailableDumpstersListPage(),
  '/services-building-materials': (context) => BuildingMaterialCategories(),


  '/waiting-approval': (context) => WaitingApproval(),
  '/pre-sign-up': (context) => PreSignUpPage(),
  '/driver-sign-up': (context) => DriverSignUpPage(),
  '/driver-sign-in': (context) => SignInPage(false),
  '/supplier-sign-in': (context) => SignInPage(true),
  '/supplier-sign-up': (context) => SupplierSignUpPage(),

  '/select-location' : (context) => Location(),
  '/add-finishing-material': (context) => FinishingMaterialRequest(),
};