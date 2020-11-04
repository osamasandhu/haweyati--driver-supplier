
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: 0.16.1
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : assert(locale != null), localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  // No description provided in @ourServices
  String get ourServices;

  // No description provided in @ourServicesDescription
  String get ourServicesDescription;

  // No description provided in @ourProducts
  String get ourProducts;

  // No description provided in @ourProductsDescription
  String get ourProductsDescription;

  // No description provided in @ourTrucks
  String get ourTrucks;

  // No description provided in @ourTrucksDescription
  String get ourTrucksDescription;

  // No description provided in @paymentAndSecurity
  String get paymentAndSecurity;

  // No description provided in @paymentAndSecurityDescription
  String get paymentAndSecurityDescription;

  // No description provided in @skip
  String get skip;

  // No description provided in @getStarted
  String get getStarted;

  // No description provided in @location
  String get location;

  // No description provided in @locationDescription
  String get locationDescription;

  // No description provided in @setYourLocation
  String get setYourLocation;

  // No description provided in @useLocation
  String get useLocation;

  // No description provided in @useLocationMessage1
  String get useLocationMessage1;

  // No description provided in @useLocationMessage2
  String get useLocationMessage2;

  // No description provided in @learnMore
  String get learnMore;

  // No description provided in @fetchingCurrentCoordinates
  String get fetchingCurrentCoordinates;

  // No description provided in @fetchingLocationData
  String get fetchingLocationData;

  // No description provided in @changingLanguage
  String get changingLanguage;

  // No description provided in @yes
  String get yes;

  // No description provided in @no
  String get no;

  // No description provided in @hello
  String get hello;

  // No description provided in @explore
  String get explore;

  // No description provided in @myOrders
  String get myOrders;

  // No description provided in @settings
  String get settings;

  // No description provided in @inviteFriends
  String get inviteFriends;

  // No description provided in @rewards
  String get rewards;

  // No description provided in @termsAndConditions
  String get termsAndConditions;

  // No description provided in @rateApp
  String get rateApp;

  // No description provided in @logout
  String get logout;

  // No description provided in @signIn
  String get signIn;

  // No description provided in @enterCredentials
  String get enterCredentials;

  // No description provided in @signingIn
  String get signingIn;

  // No description provided in @signingOut
  String get signingOut;

  // No description provided in @show
  String get show;

  // No description provided in @hide
  String get hide;

  // No description provided in @yourPhone
  String get yourPhone;

  // No description provided in @yourPassword
  String get yourPassword;

  // No description provided in @forgotPassword
  String get forgotPassword;

  // No description provided in @scaffoldings
  String get scaffoldings;

  // No description provided in @buildingMaterials
  String get buildingMaterials;

  // No description provided in @finishingMaterials
  String get finishingMaterials;

  // No description provided in @constructionDumpsters
  String get constructionDumpsters;

  // No description provided in @vehicles
  String get vehicles;

  // No description provided in @price
  String get price;

  // No description provided in @nProducts
  String nProducts(int count);

  // No description provided in @signInAsDriver
  String get signInAsDriver;

  // No description provided in @signInAsSupplier
  String get signInAsSupplier;

  // No description provided in @signUpAsDriver
  String get signUpAsDriver;

  // No description provided in @signUpAsSupplier
  String get signUpAsSupplier;

  // No description provided in @registerNow
  String get registerNow;

  // No description provided in @exitApp
  String get exitApp;

  // No description provided in @incorrectCredentials
  String get incorrectCredentials;

  // No description provided in @validatePassword
  String get validatePassword;

  // No description provided in @validatePhoneNo
  String get validatePhoneNo;

  // No description provided in @notASupplier
  String get notASupplier;

  // No description provided in @notADriver
  String get notADriver;

  // No description provided in @underReview
  String get underReview;

  // No description provided in @accountRejected
  String get accountRejected;

  // No description provided in @accountApproved
  String get accountApproved;

  // No description provided in @refreshingStatus
  String get refreshingStatus;

  // No description provided in @selectService
  String get selectService;

  // No description provided in @selectBranch
  String get selectBranch;

  // No description provided in @signingUp
  String get signingUp;

  // No description provided in @enterReqInfo
  String get enterReqInfo;

  // No description provided in @selectServices
  String get selectServices;

  // No description provided in @isSubBranch
  String get isSubBranch;

  // No description provided in @address
  String get address;

  // No description provided in @validateAddress
  String get validateAddress;

  // No description provided in @name
  String get name;

  // No description provided in @validateName
  String get validateName;

  // No description provided in @licenseNo
  String get licenseNo;

  // No description provided in @validateLicenseNo
  String get validateLicenseNo;

  // No description provided in @vehicleDetails
  String get vehicleDetails;

  // No description provided in @vehicleType
  String get vehicleType;

  // No description provided in @vehicleName
  String get vehicleName;

  // No description provided in @vehicleModel
  String get vehicleModel;

  // No description provided in @selectSupplier
  String get selectSupplier;

  // No description provided in @validateVehicle
  String get validateVehicle;

  // No description provided in @validateModel
  String get validateModel;

  // No description provided in @identification
  String get identification;

  // No description provided in @validateIdentification
  String get validateIdentification;

  // No description provided in @camera
  String get camera;

  // No description provided in @gallery
  String get gallery;

  // No description provided in @noImageSelected
  String get noImageSelected;

  // No description provided in @welcome
  String get welcome;

  // No description provided in @newOrders
  String get newOrders;

  // No description provided in @acceptedOrders
  String get acceptedOrders;

  // No description provided in @dispatchedOrders
  String get dispatchedOrders;

  // No description provided in @completedOrders
  String get completedOrders;

  // No description provided in @updatingProfile
  String get updatingProfile;

  // No description provided in @submit
  String get submit;

  // No description provided in @serviceRequests
  String get serviceRequests;

  // No description provided in @myProfile
  String get myProfile;

  // No description provided in @changePassword
  String get changePassword;

  // No description provided in @verification
  String get verification;

  // No description provided in @typeCode
  String get typeCode;

  // No description provided in @didntReceiveCode
  String get didntReceiveCode;

  // No description provided in @resendCode
  String get resendCode;

  // No description provided in @waitFor
  String get waitFor;

  // No description provided in @verifyingOTP
  String get verifyingOTP;

  // No description provided in @resetPassword
  String get resetPassword;

  // No description provided in @enterPhoneIntFormat
  String get enterPhoneIntFormat;

  // No description provided in @processing
  String get processing;

  // No description provided in @alreadyExistsDriver
  String get alreadyExistsDriver;

  // No description provided in @alreadyExistsSupplier
  String get alreadyExistsSupplier;

  // No description provided in @alreadyExistsProfile
  String get alreadyExistsProfile;

  // No description provided in @sureAcceptOrder
  String get sureAcceptOrder;

  // No description provided in @acceptOrder
  String get acceptOrder;

  // No description provided in @acceptingOrder
  String get acceptingOrder;

  // No description provided in @markCompleted
  String get markCompleted;

  // No description provided in @subtotal
  String get subtotal;

  // No description provided in @deliveryFee
  String get deliveryFee;

  // No description provided in @total
  String get total;

  // No description provided in @quantity
  String get quantity;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  
  
  
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  assert(false, 'AppLocalizations.delegate failed to load unsupported locale "$locale"');
  return null;
}
