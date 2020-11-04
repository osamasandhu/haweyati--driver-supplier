
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get ourServices => 'خدماتنا';

  @override
  String get ourServicesDescription => 'تأجير حاويات الدمار بمختلف مقاستها و عدة أنواع من السقالات، بخطوات بسيطة تصل إليك.';

  @override
  String get ourProducts => 'منتجاتنا';

  @override
  String get ourProductsDescription => 'تستطيع شراء مواد البناء والتشطيب حسب موقعك وجدول أعمالك بدون التواصل مع أي.';

  @override
  String get ourTrucks => 'منتجاتنا';

  @override
  String get ourTrucksDescription => 'هل تحتاج لنقل المواد الخاصة بك؟إستأجر الشاحنة المناسبة لحجم بضاعتك بالسعر المناسب.';

  @override
  String get paymentAndSecurity => 'الدفع والأمان';

  @override
  String get paymentAndSecurityDescription => 'إدفع عن طريق التطبيق ببطاقة مدى، فيزا/ماستر كارد وأبل باي لعملية أمنة و بدون ملامسة. ويمكنك أيضا إختيار الدفع عند التوصيل.';

  @override
  String get skip => 'تخطي';

  @override
  String get getStarted => 'البدء';

  @override
  String get location => 'الموقع';

  @override
  String get locationDescription => 'الرجاء تحديد موقع المشروع. هذا الموقع سيستخدم لإظهار الخدمات ولتوصيل بضائعك.يمكنك تغيير الموقع في أي وقت';

  @override
  String get setYourLocation => 'حدد موقعك';

  @override
  String get useLocation => 'إستخدام الموقع؟';

  @override
  String get useLocationMessage1 => 'هذا التطبيق يريد تغيير إعدادات هاتفك.الرجاء فتح خدمة تحديد المواقع في جهازك للمتابعة.';

  @override
  String get useLocationMessage2 => 'استخدم شبكات الواي فاي والجوال لتحديد الموقع';

  @override
  String get learnMore => 'Learn More';

  @override
  String get fetchingCurrentCoordinates => 'إحضار الإحداثيات الحالية';

  @override
  String get fetchingLocationData => 'إحضار بيانات الموقع';

  @override
  String get changingLanguage => 'تغيير اللغة';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'ل';

  @override
  String get hello => 'مرحبا';

  @override
  String get explore => 'اكتشف منتجاتنا وخدماتنا';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get settings => 'الضبط';

  @override
  String get inviteFriends => 'إدعو أصدقائك';

  @override
  String get rewards => 'المكافاّت';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get rateApp => 'قيم البرنامج';

  @override
  String get logout => 'Sign out';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get enterCredentials => 'أدخل بيانات الاعتماد الخاصة بك';

  @override
  String get signingIn => 'تسجيل الدخول';

  @override
  String get signingOut => 'تسجيل خروج';

  @override
  String get show => 'تبين';

  @override
  String get hide => 'إخفاء';

  @override
  String get yourPhone => 'هاتفك #';

  @override
  String get yourPassword => 'كلمتك السرية';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get scaffoldings => 'سقالات';

  @override
  String get buildingMaterials => 'مواد بناء';

  @override
  String get finishingMaterials => 'مواد التشطيب';

  @override
  String get constructionDumpsters => 'حاويات الدمار';

  @override
  String get vehicles => 'مركبات';

  @override
  String get price => 'السعر';

  @override
  String nProducts(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 المنتج',
      other: '${count} منتجات',
    );
  }

  @override
  String get signInAsDriver => 'تسجيل الدخول كسائق';

  @override
  String get signInAsSupplier => 'تسجيل الدخول كمورد';

  @override
  String get signUpAsDriver => 'سجل كسائق';

  @override
  String get signUpAsSupplier => 'اشترك كمورد';

  @override
  String get registerNow => 'سجل الان';

  @override
  String get exitApp => 'هل أنت متأكد أنك تريد الخروج من هذا التطبيق؟';

  @override
  String get incorrectCredentials => 'لقد أدخلت اسم مستخدم أو كلمة مرور غير صحيحة';

  @override
  String get validatePassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get validatePhoneNo => 'يرجى تقديم رقم الهاتف';

  @override
  String get notASupplier => 'أنت غير مسجل كمورد في هذا الحساب';

  @override
  String get notADriver => 'أنت غير مسجل كسائق في هذا الحساب';

  @override
  String get underReview => 'حسابك قيد المراجعة!';

  @override
  String get accountRejected => 'تم رفض حسابك!';

  @override
  String get accountApproved => 'تمت الموافقة على حسابك';

  @override
  String get refreshingStatus => 'حالة التحديث';

  @override
  String get selectService => 'يجب عليك اختيار خدمة واحدة على الأقل';

  @override
  String get selectBranch => 'الرجاء تحديد الفرع';

  @override
  String get signingUp => 'توقيع';

  @override
  String get enterReqInfo => 'أدخل المعلومات المطلوبة';

  @override
  String get selectServices => 'حدد الخدمات';

  @override
  String get isSubBranch => 'إنه فرع فرعي';

  @override
  String get address => 'عنوان';

  @override
  String get validateAddress => 'الرجاء إدخال العنوان';

  @override
  String get name => 'اسم';

  @override
  String get validateName => 'الرجاء إدخال الاسم';

  @override
  String get licenseNo => 'رقم الرخصة';

  @override
  String get validateLicenseNo => 'الرجاء إدخال رقم الترخيص';

  @override
  String get vehicleDetails => 'تفاصيل السيارة';

  @override
  String get vehicleType => 'نوع السيارة';

  @override
  String get vehicleName => 'اسم المركبة';

  @override
  String get vehicleModel => 'طراز السيارة';

  @override
  String get selectSupplier => 'حدد المورد';

  @override
  String get validateVehicle => 'الرجاء إدخال اسم السيارة';

  @override
  String get validateModel => 'الرجاء إدخال طراز السيارة';

  @override
  String get identification => 'هوية';

  @override
  String get validateIdentification => 'التحقق من صحة الهوية';

  @override
  String get camera => 'الة تصوير';

  @override
  String get gallery => 'صالة عرض';

  @override
  String get noImageSelected => 'لم يتم اختيار أي صورة';

  @override
  String get welcome => 'أهلا بك';

  @override
  String get newOrders => 'طلبات جديدة';

  @override
  String get acceptedOrders => 'قبلت';

  @override
  String get dispatchedOrders => 'أرسل';

  @override
  String get completedOrders => 'الطلبات المكتملة';

  @override
  String get updatingProfile => 'تحديث الملف الشخصي';

  @override
  String get submit => 'إرسال';

  @override
  String get serviceRequests => 'طلبات الخدمة';

  @override
  String get myProfile => 'ملفي';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get verification => 'التحقق';

  @override
  String get typeCode => 'الرجاء كتابة رمز التحقق الذي تلقيته';

  @override
  String get didntReceiveCode => 'لم تتلق رمز؟';

  @override
  String get resendCode => 'أعد إرسال الرمز؟';

  @override
  String get waitFor => 'أنتظر لأجل';

  @override
  String get verifyingOTP => 'التحقق من OTP';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get enterPhoneIntFormat => 'أدخل رقم هاتفك بالتنسيق الدولي إلى ';

  @override
  String get processing => 'معالجة';

  @override
  String get alreadyExistsDriver => 'يوجد سائق برقم الهاتف هذا بالفعل';

  @override
  String get alreadyExistsSupplier => 'يوجد مورد برقم الهاتف هذا بالفعل';

  @override
  String get alreadyExistsProfile => 'الملف الشخصي موجود بالفعل مع رقم الهاتف هذا. هل أنت متأكد أنك تريد مزامنة هذه الحسابات؟';

  @override
  String get sureAcceptOrder => 'هل أنت متأكد أنك تريد قبول هذا الطلب؟';

  @override
  String get acceptOrder => 'قبول الطلب';

  @override
  String get acceptingOrder => 'قبول الطلب';

  @override
  String get markCompleted => 'وضع علامة كمكتمل';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get total => 'مجموع';

  @override
  String get quantity => 'كمية';
}
