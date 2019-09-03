package com.qmion.flutter_navigation_bar;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.view.WindowManager;
import android.app.Activity;
import android.widget.Toast;

//import static android.widget.Toast.*;

/** FlutterNavigationBarPlugin */
public class FlutterNavigationBarPlugin implements MethodCallHandler {

  private final Activity activity;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_navigation_bar");
    channel.setMethodCallHandler(new FlutterNavigationBarPlugin(registrar.activity(), channel));
  }

  private FlutterNavigationBarPlugin(Activity activity, MethodChannel channel){
    this.activity = activity;
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("setNavigationBarTransparent")){
      this.activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_IN_OVERSCAN, WindowManager.LayoutParams.FLAG_LAYOUT_IN_OVERSCAN);
      makeText(activity, "Hello", LENGTH_LONG).show();
    } else {
      result.notImplemented();
    }
  }
}
