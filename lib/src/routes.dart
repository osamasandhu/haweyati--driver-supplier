import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/helpline_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/notifications_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import '../widgits/map.dart';
import 'data.dart';
import 'driver/driver-home_page.dart';
import 'supplier/auth-pages/supplier-sign-up_page.dart';
import 'supplier/auth-pages/waiting-approval_page.dart';
import 'supplier/service-requests/available-services_page.dart';
import 'supplier/service-requests/buildingMaterial/available-building-materials-categories.dart';
import 'supplier/service-requests/dumpster/add-dumpster_page.dart';
import 'supplier/service-requests/dumpster/available-dumspters-list_page.dart';
import 'supplier/service-requests/finishingMaterial/add-finishing-Materail.dart';
import 'supplier/supplier-homepage.dart';
import 'ui/pages/auth/pre-sign-in_page.dart';

final routes = <String, Widget Function(BuildContext)>{
  '/': (context) {
    if (AppData.isSignedIn) {
      if (AppData.isSupplier) {
        return AppData.supplier.status == 'Active'
            ? SupplierHomePage() : WaitingApproval();
      } else if (AppData.isDriver) {
        return AppData.driver.status == 'Active'
            ? DriverHomePage() : WaitingApproval();
      } else {
        throw Exception("Could not determine user type");
      }
    } else {
      return PreSignInPage();
    }
  },

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
  '/driver-sign-in': (context) => HaweyatiSignIn(false),
  '/supplier-sign-in': (context) => HaweyatiSignIn(true),
  '/supplier-sign-up': (context) => SupplierSignUpPage(),

  '/add-finishing-material': (context) => FinishingMaterialRequest(),
};