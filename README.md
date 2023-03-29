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

barcodeReader.claim(); // Once claiming the barcode reader, the callbacks will be active.
```

**Note:** The barcode reader will be null if the device does not support the barcode scanning.

### Scanning with software trigger
```dart
// true behaves as if the trigger was pressed, false behaves as if the trigger was released
barcodeReader.softwareTrigger(true|false);
```

### Handling lifecycle changes
```dart
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.resumed:
      barcodeReader.claim();
      break;
    case AppLifecycleState.inactive:
    case AppLifecycleState.paused:
      barcodeReader.release();
      break;
    case AppLifecycleState.detached:
      barcodeReader.close();
      break;
  }
}
```

[See the example app](https://github.com/AcmeSoftwareLLC/honeywell_mobility_sdk/tree/main/example) for more details.