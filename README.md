# Honeywell Mobility SDK for Flutter

The Mobility SDK includes tools and resources that leverage functionality unique to [Honeywell Android mobile computers](https://sps.honeywell.com/us/en/products/productivity/mobile-computers), 
such as barcode scanning.

#### How Honeywell Mobile Computer makes barcode scanning easy ?
Honeywell’s highly accurate and adaptable barcode readers offer superior barcode scanning performance and data capture.

Versatile Honeywell barcode readers fit multiple enterprise workflows and offer a variety of configurations.
Whether they are positioned at the point of sale,
stationed above a warehouse conveyor belt or mounted on a wall for quick accessibility,
our intuitive barcode readers give enterprises the freedom to deploy them to fit their business-critical needs.

With industry-leading scanning performance,
Honeywell barcode readers can rapidly and accurately read even damaged barcodes to keep workflows optimized and on schedule.

Barcode scanners from Honeywell feature high-performance barcode readers that provide exceptional data collection and barcode scanning.
They are distinguished and flexible and come in a range of configurations for different organisational workflows.
Furthermore, their exceptional scanning capability does not over-complicate the system.
They can operate in a variety of business applications, including asset and inventory tracking.

## Supported Devices
- [CK65 Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/ck65-handheld-computer)
- [CN80 Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/cn80-handheld-computer)
- [CN80G Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/cn80g-handheld-computer)
- [CT40 Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/ct40-handheld-computer)
- [CT40 XP Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/ct40-xp-handheld-computer)
- [CT45 / CT45 XP](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/ct45-ct45-xp)
- [CT60 XP Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/ct60-xp-handheld-computer)
- [Dolphin CT60 Handheld Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/handheld-computers/dolphin-ct60-handheld-computer)
- [Honeywell Dolphin 75e]()
- [RT10 Rugged Tablet](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/tablets/rt10-rugged-tablet-android)
- [ScanPal EDA50 Handheld Computer]()
- [ScanPal EDA50K Handheld Computer]()
- [ScanPal EDA70 Handheld Computer]()
- [ScanPal EDA71 Enterprise Tablet](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/tablets/scanpal-eda71-enterprise-tablet)
- [Thor VM1A Vehicle-Mounted Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/vehicle-mount-computers/thor-vm1a-vehicle-mounted-computer)
- [Thor VM3A Vehicle-Mounted Computer](https://sps.honeywell.com/us/en/products/productivity/mobile-computers/vehicle-mount-computers/thor-vm3a-vehicle-mounted-computer)

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