import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honeywell_mobility_sdk/honeywell_mobility_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Honeywell Mobility SDK'),
            ),
            body: Center(
              child: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScannerPage()),
                ),
                child: const Text('Open Scanner Page'),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum ScannerAction {
  none,
  claim,
  startScanning,
  stopScanning,
  release,
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  BarcodeReader? _barcodeReader;
  String? data;
  String? error;
  ScannerAction action = ScannerAction.none;

  @override
  void initState() {
    super.initState();
    _initReader();
  }

  Future<void> _initReader() async {
    _barcodeReader = await HoneywellMobilitySdk.createBarcodeReader(
      onRead: (event) {
        data = '${event.barcodeData} (${event.codeType})';
        error = null;
        if (mounted) setState(() {});
      },
      onFailure: (event) {
        error = 'Could not read barcode.';
        data = null;
        if (mounted) setState(() {});
      },
    );
    _barcodeReader?.setProperties(
      {
        BarcodeReaderProperty.trigger.controlMode(
          TriggerControlMode.autoControl,
        ),
        BarcodeReaderProperty.dataProcessing.launchBrowser(false),
      },
    );
  }

  @override
  void dispose() {
    _barcodeReader?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: data == null ? Colors.red.shade300 : Colors.green.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Data: $data',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Error At: $error',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _activeOn([
                ScannerAction.none,
                ScannerAction.release,
              ])
                  ? () async {
                      await _invoke((reader) => reader.claim());
                      _updateAction(ScannerAction.claim);
                    }
                  : null,
              child: const Text('Claim'),
            ),
            FilledButton(
              onPressed: _activeOn([
                ScannerAction.claim,
                ScannerAction.stopScanning,
              ])
                  ? () async {
                      await _invoke((reader) => reader.softwareTrigger(true));
                      _updateAction(ScannerAction.startScanning);
                    }
                  : null,
              child: const Text('Start Scanning'),
            ),
            FilledButton(
              onPressed: _activeOn([ScannerAction.startScanning])
                  ? () async {
                      await _invoke((reader) => reader.softwareTrigger(false));
                      _updateAction(ScannerAction.stopScanning);
                    }
                  : null,
              child: const Text('Pause Scanning'),
            ),
            FilledButton(
              onPressed: _activeOn(
                [
                  ScannerAction.claim,
                  ScannerAction.startScanning,
                  ScannerAction.stopScanning
                ],
              )
                  ? () async {
                      await _invoke((reader) => reader.release());
                      _updateAction(ScannerAction.release);
                    }
                  : null,
              child: const Text('Release'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  bool _activeOn(List<ScannerAction> actions) {
    return actions.contains(action);
  }

  void _updateAction(ScannerAction action) {
    this.action = action;
    setState(() {});
  }

  Future<void> _invoke(
      Future<void> Function(BarcodeReader reader) callback) async {
    if (_barcodeReader == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsupported device.')),
      );
    } else {
      try {
        await callback(_barcodeReader!);
      } on PlatformException catch (e) {
        error = '${e.message} (${e.code}) (${e.details})';
        if (mounted) setState(() {});
      }
    }
  }
}
