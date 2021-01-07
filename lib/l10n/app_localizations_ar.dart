
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
  String get logout => 'تسجيل الخروج';

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
  String get deliveryVehicles => 'سيارات التوزيع';

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
  String get newOrders => 'جديد';

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
  String get changePassword => 'غير كلمة السر';

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

  @override
  String get inputValidPhone => 'الرجاء إدخال رقم هاتف صالح.';

  @override
  String get notifications => 'إشعارات';

  @override
  String get loadingNotifications => 'تحميل الإخطار';

  @override
  String get noNotifications => 'لا إخطارات حتى الآن';

  @override
  String get loadingAcceptedOrders => 'تحميل الطلبات المقبولة';

  @override
  String get dropOffAddress => 'عنوان التسليم';

  @override
  String get yearsAgo => 'سنين مضت';

  @override
  String get oneYearAgo => 'منذ عام واحد';

  @override
  String get lastYear => 'العام الماضي';

  @override
  String get monthsAgo => 'منذ اشهر';

  @override
  String get oneMonthAgo => 'قبل شهر';

  @override
  String get lastMonth => 'الشهر الماضي';

  @override
  String get weeksAgo => 'منذ أسابيع';

  @override
  String get oneWeekAgo => 'منذ أسبوع';

  @override
  String get lastWeek => 'الاسبوع الماضي';

  @override
  String get daysAgo => 'أيام مضت';

  @override
  String get oneDayAgo => 'قبل يوم واحد';

  @override
  String get yesterday => 'في الامس';

  @override
  String get hoursAgo => 'منذ ساعات';

  @override
  String get oneHourAgo => 'منذ ساعة واحدة';

  @override
  String get anHourAgo => 'قبل ساعة';

  @override
  String get minutesAgo => 'دقائق مضت';

  @override
  String get aMinuteAgo => 'قبل دقيقة';

  @override
  String get oneMinuteAgo => 'قبل دقيقة واحدة';

  @override
  String get secondsAgo => 'منذ ثوانى';

  @override
  String get justNow => 'في هذة اللحظة';

  @override
  String get needHelp => 'تحتاج مساعدة؟';

  @override
  String get availableForCall => 'متاح للاتصال';

  @override
  String get getHelp => 'احصل على مساعدة';

  @override
  String get not => 'ليس';

  @override
  String get availableServices => 'الخدمات المتاحة';

  @override
  String get availableDumpsters => 'القلاب المتاح';

  @override
  String get scaffoldingRequest => 'طلب سقالات';

  @override
  String get pricing => 'التسعير';

  @override
  String get days => 'أيام';

  @override
  String get rent => 'تأجير';

  @override
  String get extraDayRent => 'إيجار يوم إضافي';

  @override
  String get note => 'ملحوظة';

  @override
  String get description => 'وصف';

  @override
  String get noLocationPicked => 'لم يتم اختيار الموقع';

  @override
  String get submittingRequest => 'تقديم الطلب';

  @override
  String get requestSubmitted => 'تم تقديم الطلب بنجاح! رقم الطلب :';

  @override
  String get addDumpster => 'أضف القمامة';

  @override
  String get size => 'بحجم';

  @override
  String get helperPrice => 'سعر المساعد';

  @override
  String get availableBMCats => 'فئات مواد البناء المتوفرة';

  @override
  String get availableFMCats => 'فئات مواد التشطيب المتاحة';

  @override
  String get available => 'متاح';

  @override
  String get products => 'منتجات';

  @override
  String get addBuildingMaterial => 'أضف مواد البناء';

  @override
  String get twelveYardPrice => 'سعر 12 ياردة';

  @override
  String get twentyFourYardPrice => 'سعر 24 ياردة';

  @override
  String get addFinishingMaterial => 'أضف مواد التشطيب';

  @override
  String get multipleVariantCheck => 'هذا المنتج له متغيرات متعددة';

  @override
  String get options => 'خيارات';

  @override
  String get addOptions => 'إضافة خيارات';

  @override
  String get account => 'الحساب';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة سر جديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordUpdated => 'لقد تم تحديث كلمة السر الخاصة بك بنجاح!';

  @override
  String get enterOldPassword => 'الرجاء إدخال كلمة المرور القديمة';

  @override
  String get atLeastEight => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get enterNewPassword => 'الرجاء إدخال كلمة مرور جديدة';

  @override
  String get confirmNewPassword => 'الرجاء تأكيد كلمة المرور الجديدة';

  @override
  String get passwordNotMatched => 'جديد وتأكيد كلمات المرور غير متطابقة';

  @override
  String get changingPassword => 'تغيير كلمة المرور';

  @override
  String get noAcceptedOrders => 'لا توجد أوامر مقبولة';

  @override
  String get loadingCompletedOrders => 'Loading Completed Orders';

  @override
  String get noCompletedOrders => 'لا توجد أوامر مكتملة';

  @override
  String get loadingDispatchedOrders => 'تحميل الطلبات المرسلة';

  @override
  String get noDispatchedOrders => 'لا توجد أوامر مرسلة';

  @override
  String get loadingAvailableOrders => 'تحميل الطلبات المتاحة';

  @override
  String get noAvailableOrders => 'لا توجد أوامر متاحة';

  @override
  String get paymentType => 'نوع الدفع';

  @override
  String get changedVehicleInfo => 'لقد قمت بتغيير معلومات السيارة. سيكون حسابك معلقًا حتى تكتمل عملية التحقق!';

  @override
  String get proceed => 'تقدم';

  @override
  String get cancel => 'إلغاء';

  @override
  String get warning => 'تحذير';
}
