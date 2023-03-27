package com.acmesoftware.honeywell_mobility_sdk

import com.honeywell.aidc.AidcManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger

/** HoneywellMobilitySdkPlugin */
class HoneywellMobilitySdkPlugin : FlutterPlugin,
    AidcManager.CreatedCallback {
    private lateinit var binaryMessenger: BinaryMessenger
    private lateinit var barcodeReader: HMSBarcodeReader

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binaryMessenger = binding.binaryMessenger
        barcodeReader = HMSBarcodeReader(binaryMessenger)
        AidcManager.create(binding.applicationContext, this)
    }

    override fun onCreated(manager: AidcManager) {
        barcodeReader.setManager(manager)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        BarcodeReaderApi.setUp(binding.binaryMessenger, null)
    }
}
