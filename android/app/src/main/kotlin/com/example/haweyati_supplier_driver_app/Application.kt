package com.example.haweyati_supplier_driver_app
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService


class Application : FlutterApplication(), PluginRegistrantCallback {
    @Override
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    @Override
    override fun registerWith(registry: PluginRegistry) {
        registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin");
    }
}

