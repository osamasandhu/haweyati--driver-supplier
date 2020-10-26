
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ourServices => 'Our Services';

  @override
  String get ourServicesDescription => 'Renting different sizes of construction dumpsters and different types of scaffolding. By just easy steps, it will be delivered to your site.';

  @override
  String get ourProducts => 'Our Products';

  @override
  String get ourProductsDescription => 'You can buy any building & finishing materials as per your location & time schedule without contacting with any person.';

  @override
  String get ourTrucks => 'Our Trucks';

  @override
  String get ourTrucksDescription => 'Need to transfer your materials?Rent the right truck type to suit your materials volume with the right price';

  @override
  String get paymentAndSecurity => 'Payment & Security';

  @override
  String get paymentAndSecurityDescription => 'Pay with Mada, Visa/Mater Card and Apple pay for a secure & hands free deals, or choose cash on delivery option.';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get Started';

  @override
  String get location => 'Location';

  @override
  String get locationDescription => 'Please select your site location. This location will be used to show the services & delivering your items. You can edit this location at any time.';

  @override
  String get setYourLocation => 'Set Your Location';

  @override
  String get useLocation => 'Use Location?';

  @override
  String get useLocationMessage1 => 'This app wants to change your device settings.';

  @override
  String get useLocationMessage2 => 'Use Wifi and mobile networks for location';

  @override
  String get learnMore => 'Learn More';

  @override
  String get fetchingCurrentCoordinates => 'Fetching Current Coordinates';

  @override
  String get fetchingLocationData => 'Fetching Location Data';

  @override
  String get changingLanguage => 'Changing Language';

  @override
  String get yes => 'YES';

  @override
  String get no => 'NO';

  @override
  String get hello => 'Hello';

  @override
  String get explore => 'Explore our products and services';

  @override
  String get myOrders => 'My Order';

  @override
  String get settings => 'Settings';

  @override
  String get inviteFriends => 'Invite Friends';

  @override
  String get rewards => 'Rewards';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get rateApp => 'Rate App';

  @override
  String get logout => 'Sign out';

  @override
  String get signIn => 'Sign in';

  @override
  String get enterCredentials => 'Enter your Credentials';

  @override
  String get signingIn => 'Signing In';

  @override
  String get signingOut => 'Signing Out';

  @override
  String get show => 'Show';

  @override
  String get hide => 'Hide';

  @override
  String get yourPhone => 'Your Phone';

  @override
  String get yourPassword => 'Your Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get scaffoldings => 'Scaffoldings';

  @override
  String get buildingMaterials => 'Building Materials';

  @override
  String get finishingMaterials => 'Finishing Materials';

  @override
  String get constructionDumpsters => 'Construction Dumpsters';

  @override
  String get vehicles => 'Vehicles';

  @override
  String price(Object value) {
    return '${value} SAR';
  }

  @override
  String nProducts(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 Product',
      other: '${count} Products',
    );
  }

  @override
  String get signInAsDriver => 'Sign In as Driver';

  @override
  String get signInAsSupplier => 'Sign In as Supplier';
}
