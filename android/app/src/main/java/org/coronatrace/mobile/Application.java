package org.coronatrace.mobile;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import com.transistorsoft.flutter.backgroundgeolocation.FLTBackgroundGeolocationPlugin;
import com.instabug.instabugflutter.InstabugFlutterPlugin;
import java.util.ArrayList;

public class Application extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @Override
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
        FLTBackgroundGeolocationPlugin.setPluginRegistrant(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        ArrayList<String> invocationEvents = new ArrayList<>();
        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE);
        new InstabugFlutterPlugin().start(Application.this, "d8d9d6c113ba17e5d515d3581726c9a0", invocationEvents);
    }
}
