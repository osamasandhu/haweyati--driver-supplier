
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
      one: '1 المنتج',
      other: '${count} منتجات',
    );
  }

  @override
  String get signInAsDriver => 'Sign In as Driver';
}
