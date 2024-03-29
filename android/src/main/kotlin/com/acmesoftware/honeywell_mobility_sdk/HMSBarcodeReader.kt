package com.acmesoftware.honeywell_mobility_sdk

import android.os.Handler
import android.os.Looper
import com.honeywell.aidc.AidcManager
import com.honeywell.aidc.BarcodeReader
import io.flutter.plugin.common.BinaryMessenger
import java.util.concurrent.Executor

class HMSBarcodeReader(messenger: BinaryMessenger) : BarcodeReaderApi,
    BarcodeReader.BarcodeListener, BarcodeReader.TriggerListener {
    private lateinit var reader: BarcodeReader
    private var manager: AidcManager? = null
    private val flutterApi = BarcodeReaderFlutterApi(messenger)
    private val uiThreadExecutor = UiThreadExecutor()

    init {
        BarcodeReaderApi.setUp(messenger, this)
    }

    fun setManager(manager: AidcManager) {
        this.manager = manager
    }

    private val isSupported get() = manager != null

    override fun create(): Boolean {
        if (!isSupported) return false

        reader = manager!!.createBarcodeReader()
        reader.addBarcodeListener(this)
        reader.addTriggerListener(this)
        return true
    }

    override fun onBarcodeEvent(event: com.honeywell.aidc.BarcodeReadEvent) {
        val readEvent = BarcodeReadEvent(
            event.barcodeData,
            event.charset.name(),
            event.codeId,
            event.aimId,
            event.timestamp,
        )

        uiThreadExecutor.execute { flutterApi.onBarcodeEvent(readEvent) {} }
    }

    override fun onFailureEvent(event: com.honeywell.aidc.BarcodeFailureEvent) {
        uiThreadExecutor.execute {
            flutterApi.onFailureEvent(BarcodeFailureEvent(event.timestamp)) {}
        }
    }


    override fun onTriggerEvent(event: com.honeywell.aidc.TriggerStateChangeEvent) {
        uiThreadExecutor.execute {
            flutterApi.onTriggerEvent(TriggerStateChangeEvent(event.state)) {}
        }
    }

    override fun aim(on: Boolean) {
        reader.aim(on)
    }

    override fun claim() {
        reader.claim()
    }

    override fun close() {
        reader.removeBarcodeListener(this)
        reader.close()
    }

    override fun decode(on: Boolean) {
        reader.decode(on)
    }

    override fun light(on: Boolean) {
        reader.light(on)
    }

    override fun notify(notification: String) {
        reader.notify(notification)
    }

    override fun release() {
        reader.release()
    }

    override fun setProperty(key: String, value: Any) {
        when (value) {
            is Int -> reader.setProperty(key, value)
            is Boolean -> reader.setProperty(key, value)
            is String -> reader.setProperty(key, value)
        }
    }

    override fun setProperties(properties: Map<String, Any>) {
        reader.setProperties(properties)
    }

    override fun softwareTrigger(state: Boolean) {
        reader.softwareTrigger(state)
    }

    private class UiThreadExecutor : Executor {
        val handler: Handler = Handler(Looper.getMainLooper())
        override fun execute(command: Runnable) {
            handler.post(command)
        }
    }
}