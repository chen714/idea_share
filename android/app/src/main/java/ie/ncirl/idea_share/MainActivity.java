package ie.ncirl.idea_share;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import androidx.annotation.NonNull;

import android.os.Build;
import android.view.ViewTreeObserver;
import android.view.WindowManager;

public class MainActivity extends FlutterFragmentActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
  }
}





//
//import androidx.annotation.NonNull;
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//import io.flutter.embedding.android.FlutterFragmentActivity;
//import android.view.WindowManager;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugins.localauth.LocalAuthPlugin;
//
//
//public class MainActivity extends FlutterFragmentActivity {
//  // TODO(bparrishMines): Remove this once v2 of GeneratedPluginRegistrant rolls to stable. https://github.com/flutter/flutter/issues/42694
//  @Override
//  public void configureFlutterEngine(FlutterEngine flutterEngine) {
//    flutterEngine.getPlugins().add(new LocalAuthPlugin());
//
////    get
//  }
//}

//import androidx.annotation.NonNull;
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//import io.flutter.embedding.android.FlutterFragmentActivity;
//
//
//public class MainActivity extends FlutterFragmentActivity {
//  @Override
//  protected void onCreate(Bundle savedInstanceState) {
//    super.onCreate(savedInstanceState);
//    GeneratedPluginRegistrant.registerWith(this);
//  }
//}
////
//public class MainActivity extends FlutterActivity {
//  @Override
//  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//    GeneratedPluginRegistrant.registerWith(flutterEngine);
//
//  }
//}

//import android.os.Bundle;
//import io.flutter.app.FlutterFragmentActivity;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//
//public class MainActivity extends FlutterFragmentActivity {
//  @Override
//  protected void onCreate(Bundle savedInstanceState) {
//    super.onCreate(savedInstanceState);
//    GeneratedPluginRegistrant.registerWith(this);
//  }
//}
