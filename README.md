# Honeywell Mobility SDK for Flutter

The Mobility SDK includes tools and resources that leverage functionality unique to our Honeywell Android mobile computers.

## Setup
Add the following line to `android/app/build.gradle`:

```groovy
dependencies {
    ...
    implementation 'com.github.AcmeSoftwareLLC:hwmsdk-android:main-SNAPSHOT' // add this line
}
```

## Usage
```dart
final barcodeReader = await HoneywellMobilitySdk.createBarcodeReader(
  onRead: (event) {
    print(event.barcodeData);
  },
  onFailure: (event) {
    print(event.timestamp);
  },
  onTrigger: (event) {
    print(event.state);
  },
);

barcodeReader?.setProperties({
  BarcodeReaderProperty.trigger.controlMode(TriggerControlMode.autoControl),
  BarcodeReaderProperty.dataProcessing.launchBrowser(false),
  BarcodeReaderProperty.symbology.aztec(true),
});

barcodeReader?.claim();
```

