// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'VisionXAI';

  @override
  String get settingsScreenTitle => 'সেটিংস';

  @override
  String get ip => 'IP ঠিকানা';

  @override
  String get port => 'পোর্ট';

  @override
  String get ipPortUpdated => 'IP এবং পোর্ট সফলভাবে আপডেট করা হয়েছে';

  @override
  String get enterIpAndPort => 'অনুগ্রহ করে IP এবং পোর্ট লিখুন';

  @override
  String get updateIp => 'IP ঠিকানা আপডেট করুন';

  @override
  String get imageUploadFailedMessage => 'ছবি আপলোড ব্যর্থ হয়েছে';

  @override
  String get chooseImage => 'ক্যাপশন তৈরি করতে ইমেজ বেছে নিন';

  @override
  String get noImageSelected => 'কোনো ছবি নির্বাচন করা হয়নি';

  @override
  String get generatingCaption => 'ক্যাপশন তৈরি করা হচ্ছে...';

  @override
  String get captionText => 'ক্যাপশন এখানে প্রদর্শিত হবে';

  @override
  String get stopCaptionGeneration => 'থামো';

  @override
  String get uploadImage => 'ছবি আপলোড করুন৷';

  @override
  String get generateCaption => 'ক্যাপশন তৈরি করুন';

  @override
  String get selectImageFrom => 'উৎস থেকে ছবি নির্বাচন করুন';

  @override
  String get camera => 'ক্যামেরা দিয়ে ছবি ক্যাপচার করুন';

  @override
  String get selectImageFromGallery => 'গ্যালারি থেকে ছবি নির্বাচন করুন';

  @override
  String get errorTitle => 'ত্রুটি';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get language => 'ভাষা';

  @override
  String get languageSettings => 'ভাষা সেটিংস';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get ipConfiguration => 'আইপি কনফিগারেশন';

  @override
  String get noLanguageSelected => 'কোন ভাষা নির্বাচিত নেই';

  @override
  String get about => 'সম্পর্কিত';

  @override
  String get currentLanguage => 'বর্তমান ভাষা';

  @override
  String get version => 'সংস্করণ';

  @override
  String get platform => 'প্ল্যাটফর্ম';

  @override
  String get listen => 'শুনুন';

  @override
  String get stop => 'থামুন';

  @override
  String uploadFailed(Object statusCode) {
    return 'ছবি আপলোড ব্যর্থ হয়েছে। স্ট্যাটাস: $statusCode';
  }

  @override
  String get uploadCancelled => 'ছবি আপলোড বাতিল করা হয়েছে।';

  @override
  String uploadError(Object error) {
    return 'ছবি আপলোডের সময় একটি ত্রুটি ঘটেছে: $error';
  }

  @override
  String get captionCancelled => 'ক্যাপশন তৈরি বাতিল করা হয়েছে।';

  @override
  String get captionStopped => 'ব্যবহারকারী ক্যাপশন তৈরি বন্ধ করেছেন।';

  @override
  String captionFailed(Object statusCode) {
    return 'ক্যাপশন তৈরি ব্যর্থ হয়েছে। স্ট্যাটাস: $statusCode';
  }

  @override
  String get captionInProgress => 'ক্যাপশন তৈরি ইতিমধ্যেই চলছে।';

  @override
  String generalError(Object error) {
    return 'একটি ত্রুটি ঘটেছে: $error';
  }

  @override
  String get noCaptionInProgress => 'কোনো ক্যাপশন তৈরি চলছে না।';

  @override
  String get captionStoppedShort => 'ক্যাপশন তৈরি বন্ধ করা হয়েছে...';

  @override
  String get imageUploaded => 'ছবি সফলভাবে আপলোড করা হয়েছে।';

  @override
  String get captionGenerationStopped => 'ক্যাপশন তৈরি বন্ধ করা হয়েছে।';

  @override
  String get failedToSpeak => 'টেক্সট-টু-স্পিচ ব্যর্থ হয়েছে।';

  @override
  String get connectionTimeout => 'সংযোগে সময় শেষ হয়েছে। আবার চেষ্টা করুন।';

  @override
  String badResponse(Object statusCode) {
    return 'সার্ভারে সমস্যা হয়েছে (স্ট্যাটাস কোড: $statusCode)।';
  }

  @override
  String get requestCancelled => 'অনুরোধ বাতিল করা হয়েছে।';

  @override
  String get noInternetOrServerUnreachable =>
      'সংযোগ ব্যর্থ হয়েছে। অনুগ্রহ করে ইন্টারনেট বা সার্ভার ঠিকানা যাচাই করুন।';

  @override
  String get unknownError =>
      'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে। পরে আবার চেষ্টা করুন।';

  @override
  String get captionMissing => 'কোনো ক্যাপশন প্রাপ্ত হয়নি।';

  @override
  String get paletteSettings => 'প্যালেট সেটিংস';

  @override
  String get colorConfiguration => 'রঙ কনফিগারেশন';

  @override
  String get pickAColor => 'একটি রঙ নির্বাচন করুন';

  @override
  String get primaryColor => 'প্রাথমিক রঙ';

  @override
  String get secondaryColor => 'দ্বিতীয় রঙ';

  @override
  String get backgroundColor => 'পটভূমির রঙ';

  @override
  String get actionsSection => 'কার্যক্রম';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get delete => 'মুছে ফেলুন';

  @override
  String get reset => 'রিসেট করুন';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get presetNameAlertTitle => 'নাম প্রিসেট করুন';

  @override
  String get presetNamePlaceholder => 'প্রিসেট নাম প্রদান করুন';

  @override
  String get select => 'নির্বাচন করুন';

  @override
  String get presetsList => 'প্রিসেট তালিকা';

  @override
  String get savePreset => 'প্রিসেট সংরক্ষণ করুন';

  @override
  String get generate => 'পটভূমি থেকে তৈরি করুন';

  @override
  String get generateFromImage => 'ছবি থেকে তৈরি করুন';

  @override
  String get pickFromFiles => 'ফাইল থেকে নির্বাচন করুন';

  @override
  String get pickFromGallery => 'গ্যালারি থেকে নির্বাচন করুন';

  @override
  String get localFilesNotSupported => 'ওয়েবে লোকাল ফাইল সমর্থিত নয়';

  @override
  String paletteGenerationFailed(Object error) {
    return 'প্যালেট তৈরি ব্যর্থ হয়েছে: $error';
  }

  @override
  String get generatingPalette => 'প্যালেট তৈরি করা হচ্ছে...';

  @override
  String get deletePresetTitle => 'প্রিসেট মুছে ফেলবেন?';

  @override
  String deletePresetMessage(Object presetName) {
    return 'প্রিসেট $presetName মুছে ফেলবেন?';
  }

  @override
  String get resetting => 'রিসেট করা হচ্ছে...';

  @override
  String get resetPrompt => 'আপনি কি রঙ প্যালেট রিসেট করতে চান?';

  @override
  String get resetConfirmation => 'রিসেট সফল হয়েছে';
}
