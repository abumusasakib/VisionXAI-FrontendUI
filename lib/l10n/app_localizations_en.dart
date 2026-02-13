// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VisionXAI';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get ip => 'IP Address';

  @override
  String get port => 'Port';

  @override
  String get ipPortUpdated => 'IP and Port updated successfully';

  @override
  String get enterIpAndPort => 'Please enter IP and Port';

  @override
  String get updateIp => 'Update IP Address';

  @override
  String get imageUploadFailedMessage => 'Image upload failed';

  @override
  String get chooseImage => 'Choose image to generate caption';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get generatingCaption => 'Generating Caption...';

  @override
  String get captionText => 'Caption will appear here';

  @override
  String get stopCaptionGeneration => 'Stop';

  @override
  String get uploadImage => 'Upload Image';

  @override
  String get generateCaption => 'Generate Caption';

  @override
  String get selectImageFrom => 'Select image from source';

  @override
  String get camera => 'Capture Image with Camera';

  @override
  String get selectImageFromGallery => 'Select Image from Gallery';

  @override
  String get errorTitle => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get language => 'Language';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get ipConfiguration => 'IP Configuration';

  @override
  String get noLanguageSelected => 'No Language Selected';

  @override
  String get about => 'About';

  @override
  String get currentLanguage => 'Current Language';

  @override
  String get version => 'Version';

  @override
  String get platform => 'Platform';

  @override
  String get listen => 'Listen';

  @override
  String get stop => 'Stop';

  @override
  String uploadFailed(Object statusCode) {
    return 'Failed to upload image. Status: $statusCode';
  }

  @override
  String get uploadCancelled => 'Image upload was cancelled.';

  @override
  String uploadError(Object error) {
    return 'An error occurred during image upload: $error';
  }

  @override
  String get captionCancelled => 'Caption generation was cancelled.';

  @override
  String get captionStopped => 'Caption generation stopped by user.';

  @override
  String captionFailed(Object statusCode) {
    return 'Failed to generate caption. Status: $statusCode';
  }

  @override
  String get captionInProgress => 'Caption generation already in progress.';

  @override
  String generalError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get noCaptionInProgress => 'No caption generation in progress.';

  @override
  String get captionStoppedShort => 'Stopped caption generation...';

  @override
  String get imageUploaded => 'Image uploaded successfully.';

  @override
  String get captionGenerationStopped => 'Caption generation has been stopped.';

  @override
  String get failedToSpeak => 'Failed to speak the caption';

  @override
  String get connectionTimeout => 'Connection timed out. Please try again.';

  @override
  String badResponse(Object statusCode) {
    return 'Server error occurred (Status code: $statusCode).';
  }

  @override
  String get requestCancelled => 'Request was cancelled.';

  @override
  String get noInternetOrServerUnreachable =>
      'Unable to connect. Please check your internet or server address.';

  @override
  String get unknownError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get captionMissing => 'No caption available.';

  @override
  String get paletteSettings => 'Palette Settings';

  @override
  String get colorConfiguration => 'Color Configuration';

  @override
  String get pickAColor => 'Pick a Color';

  @override
  String get primaryColor => 'Primary Color';

  @override
  String get secondaryColor => 'Secondary Color';

  @override
  String get backgroundColor => 'Background Color';

  @override
  String get actionsSection => 'Actions';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get reset => 'Reset';

  @override
  String get cancel => 'Cancel';

  @override
  String get presetNameAlertTitle => 'Name Preset';

  @override
  String get presetNamePlaceholder => 'Provide preset name';

  @override
  String get select => 'Select';

  @override
  String get presetsList => 'Presets List';

  @override
  String get savePreset => 'Save Preset';

  @override
  String get generate => 'Generate from Background';

  @override
  String get generateFromImage => 'Generate from Image';

  @override
  String get pickFromFiles => 'Pick from files';

  @override
  String get pickFromGallery => 'Pick from gallery';

  @override
  String get localFilesNotSupported => 'Local files not supported on web';

  @override
  String paletteGenerationFailed(Object error) {
    return 'Failed to generate palette: $error';
  }

  @override
  String get generatingPalette => 'Generating Palette...';

  @override
  String get deletePresetTitle => 'Delete Preset?';

  @override
  String deletePresetMessage(Object presetName) {
    return 'Delete preset $presetName?';
  }

  @override
  String get resetting => 'Resetting...';

  @override
  String get resetPrompt => 'Are you sure you want to reset the color palette?';

  @override
  String get resetConfirmation => 'Reset successfully';
}
