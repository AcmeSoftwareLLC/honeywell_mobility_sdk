class BarcodeReaderProperty<T extends Object> {
  const BarcodeReaderProperty(this.key);

  final String key;

  BarcodeReaderPropertyEntry<T> call(T value) {
    return BarcodeReaderPropertyEntry(key, value);
  }

  static const BarcodeReaderImagerPropertyGroup imager =
      BarcodeReaderImagerPropertyGroup();

  static const BarcodeReaderNotificationPropertyGroup notification =
      BarcodeReaderNotificationPropertyGroup();

  static const BarcodeReaderTriggerPropertyGroup trigger =
      BarcodeReaderTriggerPropertyGroup();

  static const BarcodeReaderSymbologyPropertyGroup symbology =
      BarcodeReaderSymbologyPropertyGroup();

  static const BarcodeReaderDataProcessingPropertyGroup dataProcessing =
      BarcodeReaderDataProcessingPropertyGroup();
}

class BarcodeReaderPropertyEntry<T extends Object> {
  const BarcodeReaderPropertyEntry(this.key, this._value);

  final String key;
  final T _value;

  Object get value {
    final value = _value;
    return value is Enum ? value.name : value;
  }

  @override
  String toString() => 'BarcodeReaderPropertyEntry($key, $value)';
}

class BarcodeReaderImagerPropertyGroup {
  const BarcodeReaderImagerPropertyGroup();

  /// Maximum exposure time in microseconds when using automatic exposure.
  final BarcodeReaderProperty<int> lightIntensity =
      const BarcodeReaderProperty('IMG_ILLUM_INTENSITY');

  /// Imager exposure. Exposure time (in microseconds) when using fixed exposure.
  final BarcodeReaderProperty<int> exposure =
      const BarcodeReaderProperty('IMG_EXPOSURE');

  /// Sensitivity of image sensor when using fixed exposure.
  final BarcodeReaderProperty<int> gain =
      const BarcodeReaderProperty('IMG_GAIN');

  /// Maximum exposure time in microseconds when using automatic exposure.
  final BarcodeReaderProperty<int> maximumExposure =
      const BarcodeReaderProperty('IMG_MAX_EXPOSURE');

  /// Maximum sensitivity of image sensor when using automatic exposure.
  final BarcodeReaderProperty<int> maximumGain =
      const BarcodeReaderProperty('IMG_MAX_GAIN');

  /// Target calculated value of image during automated exposure control.
  final BarcodeReaderProperty<int> targetValue =
      const BarcodeReaderProperty('IMG_TARGET_VALUE');

  /// Acceptable difference from [targetValue] of images.
  final BarcodeReaderProperty<int> targetAcceptableOffset =
      const BarcodeReaderProperty('IMG_TARGET_ACCEPTABLE_OFFSET');

  /// Maximum number of images to reject because the aren't close enough to [targetValue].
  final BarcodeReaderProperty<int> rejectionLimit =
      const BarcodeReaderProperty('IMG_REJECTION_LIMIT');

  /// Target percentile of target value for the Automatic Exposure mode.
  final BarcodeReaderProperty<int> targetPercentile =
      const BarcodeReaderProperty('IMG_TARGET_PERCENTILE');

  /// If and how exposure is automatically updated to improve image quality.
  final BarcodeReaderProperty<ImageExposureMode> exposureMode =
      const BarcodeReaderProperty('IMG_EXPOSURE_MODE');

  /// How image quality is determined by software controlled exposure modes.
  final BarcodeReaderProperty<ImageSampleMethod> sampleMode =
      const BarcodeReaderProperty('IMG_SAMPLE_METHOD');
}

class BarcodeReaderNotificationPropertyGroup {
  const BarcodeReaderNotificationPropertyGroup();

  /// Good Read Notification Enable/Disable.
  /// This setting determines whether the Good Read Beep and LED will play on successful decode.
  final BarcodeReaderProperty<bool> goodReadEnabled =
      const BarcodeReaderProperty('NTF_GOOD_READ_ENABLED');

  /// Bad Read Notification Enable/Disable.
  /// This setting determines whether the Bad Read Beep and LED will play when no bar code is decoded.
  final BarcodeReaderProperty<bool> badReadEnabled =
      const BarcodeReaderProperty('NTF_BAD_READ_ENABLED');

  /// Vibration Enable/Disabled.
  /// This setting determines whether the device will vibrate when a notification occurs.
  /// Note that this setting is ignored if the device's ringer mode is set to SILENT.
  final BarcodeReaderProperty<bool> vibrateEnabled =
      const BarcodeReaderProperty('NTF_VIBRATE_ENABLED');
}

class BarcodeReaderTriggerPropertyGroup {
  const BarcodeReaderTriggerPropertyGroup();

  /// Trigger control mode.
  /// This setting determines what the behavior will be when the scan trigger state changes.
  final BarcodeReaderProperty<TriggerControlMode> controlMode =
      const BarcodeReaderProperty('TRIG_CONTROL_MODE');

  /// Automatic trigger mode timeout.
  /// This setting only applies when [controlMode] is set to [TriggerControlMode.autoControl].
  ///
  /// The value is an integer (in seconds) indicating how long the scanner will remain on while the scan trigger is pressed.
  /// Once this timeout has expired, the scanner will automatically be turned off to save power.
  final BarcodeReaderProperty<int> autoModeTimeout =
      const BarcodeReaderProperty('TRIG_AUTO_MODE_TIMEOUT');

  final BarcodeReaderProperty<bool> enable =
      const BarcodeReaderProperty('TRIG_ENABLE');

  /// Trigger scan delay.
  /// This setting turns on the aimer for a duration before starting to scan (in milliseconds).
  final BarcodeReaderProperty<int> scanDelay =
      const BarcodeReaderProperty('TRIG_SCAN_DELAY');

  final BarcodeReaderProperty<TriggerScanMode> scanMode =
      const BarcodeReaderProperty('TRIG_SCAN_MODE');
}

class BarcodeReaderSymbologyPropertyGroup {
  const BarcodeReaderSymbologyPropertyGroup();

  /// Enable or disable Code 128 FNC4.
  final BarcodeReaderProperty<bool> code128FNC4 =
      const BarcodeReaderProperty('DEC_C128_FNC4_ENABLED');

  /// Enable or disable Code 128 FNC4.
  final BarcodeReaderProperty<bool> code128 =
      const BarcodeReaderProperty('DEC_CODE128_ENABLED');

  /// Enable or disable GS1 128.
  final BarcodeReaderProperty<bool> gs1128 =
      const BarcodeReaderProperty('DEC_GS1_128_ENABLED');

  /// Enable or disable ISBT 128.
  final BarcodeReaderProperty<bool> isbt128 =
      const BarcodeReaderProperty('DEC_C128_ISBT_ENABLED');

  /// Enable or disable Code 39.
  final BarcodeReaderProperty<bool> code39 =
      const BarcodeReaderProperty('DEC_CODE39_ENABLED');

  /// Enable or disable full ASCII.
  /// When Code 39 full ASCII conversion is enabled Code 39 bar codes are transmitted with an extended character set.
  /// The full 128 ASCII character set is encoded in Code 39 by combining two regular Code 39 characters.
  final BarcodeReaderProperty<bool> code39FullAscii =
      const BarcodeReaderProperty('DEC_CODE39_FULL_ASCII_ENABLED');

  /// Enable or disable the start/stop transmission for Code 39.
  final BarcodeReaderProperty<bool> code39StartStopTransmit =
      const BarcodeReaderProperty('DEC_CODE39_START_STOP_TRANSMIT');

  /// Enable or disable Base 32 Conversion for Code 39.
  final BarcodeReaderProperty<bool> code39BAse32 =
      const BarcodeReaderProperty('DEC_CODE39_BASE32_ENABLED');

  /// Enable or disable Datamatrix.
  final BarcodeReaderProperty<bool> dataMatrix =
      const BarcodeReaderProperty('DEC_DATAMATRIX_ENABLED');

  /// Enable or disable Grid Matrix.
  final BarcodeReaderProperty<bool> gridMatrix =
      const BarcodeReaderProperty('DEC_GRIDMATRIX_ENABLED');

  /// Enable or disable UPC-A.
  final BarcodeReaderProperty<bool> upca =
      const BarcodeReaderProperty('DEC_UPCA_ENABLE');

  /// Enable or disable UPC-E0.
  final BarcodeReaderProperty<bool> upce =
      const BarcodeReaderProperty('DEC_UPCE0_ENABLED');

  /// Enable or disable Aztec.
  final BarcodeReaderProperty<bool> aztec =
      const BarcodeReaderProperty('DEC_AZTEC_ENABLED');

  /// Enable or disable Codabar.
  final BarcodeReaderProperty<bool> codebar =
      const BarcodeReaderProperty('DEC_CODABAR_ENABLED');

  /// Enable or disable Code 93.
  final BarcodeReaderProperty<bool> code93 =
      const BarcodeReaderProperty('DEC_CODE93_ENABLED');

  /// Enable or disable EAN-8.
  final BarcodeReaderProperty<bool> ean8 =
      const BarcodeReaderProperty('DEC_EAN8_ENABLED');

  /// Enable or disable EAN-13.
  final BarcodeReaderProperty<bool> ean13 =
      const BarcodeReaderProperty('DEC_EAN13_ENABLED');

  /// Enable or disable Maxicode.
  final BarcodeReaderProperty<bool> maxiCode =
      const BarcodeReaderProperty('DEC_MAXICODE_ENABLED');

  /// Enable or disable PDF-417.
  final BarcodeReaderProperty<bool> pdf417 =
      const BarcodeReaderProperty('DEC_PDF417_ENABLED');

  /// Enable or disable QR Code.
  final BarcodeReaderProperty<bool> qrCode =
      const BarcodeReaderProperty('DEC_QR_ENABLED');

  /// Enable or disable GS1 DataBar Omnidirectional.
  final BarcodeReaderProperty<bool> rss =
      const BarcodeReaderProperty('DEC_RSS_14_ENABLED');

  /// Enable or disable GS1 DataBar Limited.
  final BarcodeReaderProperty<bool> rssLimited =
      const BarcodeReaderProperty('DEC_RSS_LIMITED_ENABLED');

  /// Enable or disable GS1 DataBar Expanded.
  final BarcodeReaderProperty<bool> rssExpanded =
      const BarcodeReaderProperty('DEC_RSS_EXPANDED_ENABLED');

  /// Enable or disable Interleaved 2 of 5.
  final BarcodeReaderProperty<bool> interleaved25 =
      const BarcodeReaderProperty('DEC_I25_ENABLED');
}

class BarcodeReaderDataProcessingPropertyGroup {
  const BarcodeReaderDataProcessingPropertyGroup();

  /// Data added to the beginning of the bar code data.
  final BarcodeReaderProperty<String> prefix =
      const BarcodeReaderProperty('DPR_PREFIX');

  /// Data added to the end of the bar code data.
  final BarcodeReaderProperty<String> suffix =
      const BarcodeReaderProperty('DPR_SUFFIX');

  /// Data added to the beginning of the bar code data to indicate the symbology.
  final BarcodeReaderProperty<String> symbologyPrefix =
      const BarcodeReaderProperty('DPR_SYMBOLOGY_PREFIX');

  /// Indicates if scanning bar codes containing URLs will open the internet browser.
  final BarcodeReaderProperty<bool> launchBrowser =
      const BarcodeReaderProperty('DPR_LAUNCH_BROWSER');

  /// Indicates if scanning bar codes generated by EZ Config for Mobility
  /// will launch EZ Config on the mobile computer to apply settings.
  final BarcodeReaderProperty<bool> ezConfig =
      const BarcodeReaderProperty('DPR_LAUNCH_EZ_CONFIG');

  /// Indicates if bar codes starting with "//" will attempt to open an application.
  final BarcodeReaderProperty<bool> scanToIntent =
      const BarcodeReaderProperty('DPR_SCAN_TO_INTENT');
}

enum ImageExposureMode {
  /// Exposure does not change automatically.
  fixed,

  /// Image sensor controls the exposure automatically.
  autoSensor,

  /// Software automatically updates exposure to improve image quality.
  autoExposure,

  /// Software automatically updates exposure to improve image quality of bar codes.
  contextSensitive,
}

enum ImageSampleMethod {
  /// Image quality determined by entire image.
  uniform,

  /// Image quality determined by center of image.
  center,

  /// Image quality determined by entire image but weighted toward center of image.
  centerWeighted,
}

enum TriggerControlMode {
  /// Disabled.
  /// When this setting is applied, pressing the scan button will not be handled.
  disable,

  /// Automatic control.
  /// When this setting is applied, the scanner service will handle the scan trigger state changes,
  /// turning the scanner on when pressed, and turning it off when released.
  ///
  /// Turning the scanner on means turning on the aimer and illumination, and enabling decoding.
  autoControl,

  /// Client control.
  /// When this setting is applied, the scanner service will notify registered client(s) when the scan trigger state changes.
  /// It is then up to the client to decide how to handle these trigger events.
  clientControl,
}

enum TriggerScanMode {
  /// OneShot.
  /// When this setting is applied, pressing the trigger button will allow to scan only one barcode.
  oneShot,

  /// Continuous.
  /// When this setting is applied, pressing the trigger button will allow to scan multiple barcodes,
  /// however duplicate barcodes are not scanned.
  continuous,

  /// ReadOnRelease.
  /// When this setting is applied, pressing the trigger will start the aimer
  /// and releasing the trigger will scan the barcode.
  readOnRelease,

  /// ReadOnSecondTriggerPress.
  /// When this setting is applied, pressing the trigger first time will start the aimer
  /// and pressing the trigger second time will scan the barcode.
  readOnSecondTriggerPress,
}
