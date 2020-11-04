
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
  String get price => 'Price';

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

  @override
  String get signUpAsDriver => 'Sign Up as Driver';

  @override
  String get signUpAsSupplier => 'Sign Up as Supplier';

  @override
  String get registerNow => 'Register Now';

  @override
  String get exitApp => 'Are you sure you want to exit this application?';

  @override
  String get incorrectCredentials => 'You have entered an incorrect username or password';

  @override
  String get validatePassword => 'Please provide password';

  @override
  String get validatePhoneNo => 'Please provide phone number';

  @override
  String get notASupplier => 'You are not registered as a Supplier on this account';

  @override
  String get notADriver => 'You are not registered as a Driver on this account';

  @override
  String get underReview => 'Your account is being reviewed!';

  @override
  String get accountRejected => 'Your account has been rejected!';

  @override
  String get accountApproved => 'Your account has been approved!';

  @override
  String get refreshingStatus => 'Refreshing status';

  @override
  String get selectService => 'You must select at least one service';

  @override
  String get selectBranch => 'Please select Branch';

  @override
  String get signingUp => 'Signing Up';

  @override
  String get enterReqInfo => 'Enter Required Information';

  @override
  String get selectServices => 'Select Services';

  @override
  String get isSubBranch => 'It is a Sub Branch';

  @override
  String get address => 'Address';

  @override
  String get validateAddress => 'Please Enter Address';

  @override
  String get name => 'Name';

  @override
  String get validateName => 'Please Enter Name';

  @override
  String get licenseNo => 'License Number';

  @override
  String get validateLicenseNo => 'Please Enter License Number';

  @override
  String get vehicleDetails => 'Vehicle Details';

  @override
  String get vehicleType => 'Vehicle Type';

  @override
  String get vehicleName => 'Vehicle Name';

  @override
  String get vehicleModel => 'Vehicle Model';

  @override
  String get selectSupplier => 'Select Supplier';

  @override
  String get validateVehicle => 'Please enter Vehicle Name';

  @override
  String get validateModel => 'Please enter Vehicle Model';

  @override
  String get identification => 'Identification';

  @override
  String get validateIdentification => 'Please enter identification';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get noImageSelected => 'No Image selected';

  @override
  String get welcome => 'Welcome';

  @override
  String get newOrders => 'New Orders';

  @override
  String get acceptedOrders => 'Accepted';

  @override
  String get dispatchedOrders => 'Dispatched';

  @override
  String get completedOrders => 'Completed';

  @override
  String get updatingProfile => 'Updating Profile';

  @override
  String get submit => 'Submit';

  @override
  String get serviceRequests => 'Service Requests';

  @override
  String get myProfile => 'My Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get verification => 'Verification';

  @override
  String get typeCode => 'Please type the verification code you received';

  @override
  String get didntReceiveCode => 'Didn\'t receive a code?';

  @override
  String get resendCode => 'Resend code?';

  @override
  String get waitFor => 'Wait for';

  @override
  String get verifyingOTP => 'Verifying OTP';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterPhoneIntFormat => 'Enter Your Phone Number in International Format to ';

  @override
  String get processing => 'Processing';

  @override
  String get alreadyExistsDriver => 'A driver with this phone number already exists';

  @override
  String get alreadyExistsSupplier => 'A supplier with this phone number already exists';

  @override
  String get alreadyExistsProfile => 'profile already exists with this phone number.Are you sure you want to sync these accounts?';

  @override
  String get sureAcceptOrder => 'Are you sure you want to accept this order?';

  @override
  String get acceptOrder => 'Accept Order';

  @override
  String get acceptingOrder => 'Accepting Order';

  @override
  String get markCompleted => 'Mark as completed';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get total => 'Total';

  @override
  String get quantity => 'Quantity';
}
