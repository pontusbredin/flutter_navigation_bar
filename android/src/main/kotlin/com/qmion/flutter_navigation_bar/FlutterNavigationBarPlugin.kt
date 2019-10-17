package com.qmion.flutter_navigation_bar

import android.annotation.TargetApi
import android.app.Activity
import android.app.Application
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.Rect
import android.os.Build
import android.os.Bundle
import android.util.DisplayMetrics
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager.LayoutParams
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformPlugin


@TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
class FlutterNavigationBarPlugin(private val activity: Activity) : MethodCallHandler, EventChannel.StreamHandler, Application.ActivityLifecycleCallbacks {

    internal var hasSoftwareNavigationBar: Boolean = false
    internal var statusBarHeight: Double = 0.0
    internal var navigationBarHeight: Double = 0.0
    internal var navigationBarWidthLeft: Double = 0.0
    internal var navigationBarWidthRight: Double = 0.0
    internal var useEqualSides: Boolean = false

    private var mainView: View? = null
    private var _activity: Activity? = null
    private var eventsSink: EventChannel.EventSink? = null
    private var eventChannel: EventChannel? = null
    internal var isSetup: Boolean = false

    override fun onActivityCreated(activity: Activity, bundle: Bundle) {
    }

    override fun onActivityStarted(activity: Activity) {
        try {
            _activity = activity
            mainView = (activity.findViewById(android.R.id.content) as ViewGroup).getChildAt(0)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                activity.getWindow().setStatusBarColor(Color.TRANSPARENT)
                activity.getWindow().setNavigationBarColor(Color.TRANSPARENT)
                activity.getWindow().addFlags(LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                mainView?.setSystemUiVisibility(PlatformPlugin.DEFAULT_SYSTEM_UI)
                mainView?.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
            }
            setupForInsets()
        } catch (e: Exception) {
            // do nothing
        }
    }

    override fun onActivityResumed(activity: Activity) {
        if (eventsSink != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                activity.getWindow().getDecorView().dispatchApplyWindowInsets(activity.getWindow().getDecorView().getRootWindowInsets())
            }
        }
    }

    override fun onActivityPaused(activity: Activity) {
        unregisterListener()
    }

    override fun onActivityStopped(activity: Activity) {
        unregisterListener()
    }

    override fun onActivitySaveInstanceState(activity: Activity, bundle: Bundle) {
    }

    override fun onActivityDestroyed(activity: Activity) {
        unregisterListener()
        eventsSink = null
        eventChannel = null
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ICE_CREAM_SANDWICH) {
            activity.getApplication().unregisterActivityLifecycleCallbacks(this)
        }
    }

    private fun unregisterListener() {
        if (mainView != null) {
            mainView = null
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        // register listener
        hasSoftwareNavigationBar = false
        statusBarHeight = 0.0
        navigationBarHeight = 0.0
        navigationBarWidthLeft = 0.0
        navigationBarWidthRight = 0.0
        this.eventsSink = events
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity.getWindow().getDecorView().dispatchApplyWindowInsets(activity.getWindow().getDecorView().getRootWindowInsets())
        }
    }

    override fun onCancel(arguments: Any?) {
        eventsSink = null
    }

    private fun setupForInsets(): Boolean {
        if ((Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) && (!isSetup)) {
            val decorView = activity.getWindow().getDecorView()

            isSetup = true

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                decorView.setOnApplyWindowInsetsListener { view, insets ->

                    val windowInsets = activity.getWindow().getDecorView().getRootWindowInsets().consumeSystemWindowInsets()
                    var hasChanged = false
                    hasChanged = hasChanged or (hasSoftwareNavigationBar != (insets.systemWindowInsetBottom > 0))
                    hasChanged = hasChanged or (statusBarHeight != insets.systemWindowInsetTop.toDouble())
                    hasChanged = hasChanged or (navigationBarHeight != insets.systemWindowInsetBottom.toDouble())
                    hasChanged = hasChanged or (navigationBarWidthLeft != insets.systemWindowInsetLeft.toDouble())
                    hasChanged = hasChanged or (navigationBarWidthRight != insets.systemWindowInsetRight.toDouble())

                    hasSoftwareNavigationBar = (insets.systemWindowInsetBottom > 0)
                    statusBarHeight = insets.systemWindowInsetTop.toDouble()
                    navigationBarHeight = insets.systemWindowInsetBottom.toDouble()
                    navigationBarWidthLeft = insets.systemWindowInsetLeft.toDouble()
                    navigationBarWidthRight = insets.systemWindowInsetRight.toDouble()

                    if (useEqualSides) {
                        hasChanged = hasChanged or (navigationBarWidthRight != navigationBarWidthLeft)
                        if (navigationBarWidthLeft > navigationBarWidthRight) {
                            navigationBarWidthRight = navigationBarWidthLeft
                        } else {
                            navigationBarWidthLeft = navigationBarWidthRight
                        }
                    }

                    if ((eventsSink != null) and (hasChanged)) {
                        val items = mutableMapOf<String, Any?>()

                        val d = activity.getWindowManager().getDefaultDisplay()

                        val realDisplayMetrics = DisplayMetrics()
                        d.getRealMetrics(realDisplayMetrics)
                        val dpi: Double = (0.00625 * realDisplayMetrics.densityDpi)

                        items["hasSoftwareNavigationBar"] = hasSoftwareNavigationBar
                        items["statusBarHeight"] = statusBarHeight / dpi
                        items["navigationBarHeight"] = navigationBarHeight / dpi
                        items["navigationBarWidthRight"] = navigationBarWidthRight / dpi
                        items["navigationBarWidthLeft"] = navigationBarWidthLeft / dpi

                        eventsSink?.success(items)
                    }

                    val realDisplayMetrics = DisplayMetrics()
                    activity.windowManager.defaultDisplay.getRealMetrics(realDisplayMetrics)

                    //Less then 10% of the screen height. This means that the keyboard is not visible.
                    if ((insets.systemWindowInsetBottom.toDouble() / realDisplayMetrics.heightPixels.toDouble()) < 0.1) {
                        val rect = Rect(0, 0, 0, 0)
                        rect.top = statusBarHeight.toInt()
                        rect.bottom = windowInsets.systemWindowInsetBottom
                        rect.left = navigationBarWidthLeft.toInt()
                        rect.right = navigationBarWidthRight.toInt()

                        insets.replaceSystemWindowInsets(rect)
                    } else {
                        val rect = Rect(0, 0, 0, 0)

                        rect.top = insets.systemWindowInsetTop
                        rect.bottom = insets.systemWindowInsetBottom
                        rect.left = insets.systemWindowInsetLeft
                        rect.right = insets.systemWindowInsetRight

                        if (useEqualSides) {
                            if (rect.left > rect.right) {
                                rect.right = rect.left
                            } else {
                                rect.left = rect.right
                            }
                        }

                        insets.replaceSystemWindowInsets(rect)
                    }
                }
            }

        }

        return true
    }

    private fun equalSides(value: Boolean): Boolean {
        this.useEqualSides = value
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity.getWindow().getDecorView().dispatchApplyWindowInsets(activity.getWindow().getDecorView().getRootWindowInsets())
        }
        return value
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {

            val instance = FlutterNavigationBarPlugin(registrar.activity())

            val channel = MethodChannel(registrar.messenger(), "flutter_navigation_bar")
            channel.setMethodCallHandler(instance) //FlutterNavigationBarPlugin(registrar.activity()))

            instance.eventChannel = EventChannel(registrar.messenger(), "github.com/pontusbredin/flutter_navigation_bar")

            instance.eventChannel?.setStreamHandler(instance)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ICE_CREAM_SANDWICH) {
                registrar.activity().getApplication().registerActivityLifecycleCallbacks(instance)
            }

//      instance.setupForInsets() Moved
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when {
            call.method == "equalSides" -> {
                val bool: Boolean = call.argument<Boolean>("bool") ?: false
                result.success(equalSides(bool))
            }
            else -> result.notImplemented()
        }
    }

    private fun isTablet(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.DONUT) {
            activity.resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK >= Configuration.SCREENLAYOUT_SIZE_LARGE
        } else {
            false
        }
    }
}
