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
  String? trigger;
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
      onTrigger: (event) {
        trigger = event.state ? 'Pressed' : 'Released';
        if (mounted) setState(() {});
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: action == ScannerAction.startScanning
              ? const LinearProgressIndicator(minHeight: 2)
              : const SizedBox.shrink(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ResultCard(data: data, trigger: trigger, error: error),
            const SizedBox(height: 16),
            DropdownMenu(
              leadingIcon: const Icon(Icons.barcode_reader),
              label: const Text('Scan Mode'),
              initialSelection: TriggerScanMode.oneShot,
              onSelected: (mode) {
                if (mode != null) {
                  _invoke(
                    (reader) => reader.setProperty(
                      BarcodeReaderProperty.trigger.scanMode(mode),
                    ),
                  );
                }
              },
              dropdownMenuEntries: [
                for (final mode in TriggerScanMode.values)
                  DropdownMenuEntry(value: mode, label: mode.name),
              ],
            ),
            const SizedBox(height: 16),
            _Button(
              label: 'Claim',
              enableFor: const [ScannerAction.none, ScannerAction.release],
              action: action,
              onPressed: () async {
                final supported = await _invoke((reader) => reader.claim());
                if (supported) _updateAction(ScannerAction.claim);
              },
            ),
            _Button(
              label: 'Start Scanning',
              enableFor: const [
                ScannerAction.claim,
                ScannerAction.stopScanning
              ],
              action: action,
              onPressed: () async {
                await _invoke((reader) => reader.softwareTrigger(true));
                _updateAction(ScannerAction.startScanning);
              },
            ),
            _Button(
              label: 'Pause Scanning',
              enableFor: const [ScannerAction.startScanning],
              action: action,
              onPressed: () async {
                await _invoke((reader) => reader.softwareTrigger(false));
                _updateAction(ScannerAction.stopScanning);
              },
            ),
            _Button(
              label: 'Release',
              enableFor: const [
                ScannerAction.claim,
                ScannerAction.startScanning,
                ScannerAction.stopScanning
              ],
              action: action,
              onPressed: () async {
                await _invoke((reader) => reader.release());
                _updateAction(ScannerAction.release);
              },
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

  void _updateAction(ScannerAction action) {
    this.action = action;
    setState(() {});
  }

  Future<bool> _invoke(
    Future<void> Function(BarcodeReader reader) callback,
  ) async {
    if (_barcodeReader == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsupported device.')),
      );
      return false;
    }

    try {
      await callback(_barcodeReader!);
    } on PlatformException catch (e) {
      error = '${e.message} (${e.code}) (${e.details})';
      if (mounted) setState(() {});
    }
    return true;
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.data,
    required this.trigger,
    required this.error,
  });

  final String? data;
  final String? trigger;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data == null ? Colors.red.shade300 : Colors.green.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'Data: $data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Trigger: $trigger',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Error At: $error',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.enableFor,
    required this.action,
    required this.onPressed,
  });

  final String label;
  final List<ScannerAction> enableFor;
  final ScannerAction action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _activeOn(enableFor) ? onPressed : null,
      child: Text(label),
    );
  }

  bool _activeOn(List<ScannerAction> actions) {
    return actions.contains(action);
  }
}
