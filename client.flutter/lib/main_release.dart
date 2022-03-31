import 'package:surf_practice_chat_client/config/app_config.dart';
import 'package:surf_practice_chat_client/config/debug_options.dart';
import 'package:surf_practice_chat_client/config/environment/build_types.dart';
import 'package:surf_practice_chat_client/config/environment/environment.dart';
import 'package:surf_practice_chat_client/config/urls.dart';
import 'package:surf_practice_chat_client/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(
      url: Url.prodUrl,
      proxyUrl: Url.prodProxyUrl,
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
