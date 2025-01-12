import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:yahay/core/utils/debug_image_creator_in_apps_folder/debug_image_creator_in_apps_folder.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/app_logger_factory.dart';
import 'package:yahay/features/initialization/widgets/root_context.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/firebase_options.dart';

class AppRunner with FolderCreator {
  Future<void> initialize() async {
    //
    final Logger logger = AppLoggerFactory(
      logFilter: kReleaseMode ? NoOpLogFilter() : DevelopmentFilter(),
    ).create();

    await runZonedGuarded(
      () async {
        final binding = WidgetsFlutterBinding.ensureInitialized();

        binding.deferFirstFrame();

        Future<void> init() async {
          try {
            await DotEnvHelper.instance.initEnv();
            final sharedPreferences = SharedPreferHelper();
            await sharedPreferences.initSharedPrefer();

            await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            );

            FlutterError.onError = (errorDetails) {
              FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
            };
            PlatformDispatcher.instance.onError = (error, stack) {
              FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
              return true;
            };

            await createFolders(sharedPreferences);

            final compositionRoot = await CompositionRoot(
              logger: logger,
              sharedPreferHelper: sharedPreferences,
            ).create();

            if (kDebugMode) {
              await DebugImageCreatorInAppsFolder(
                compositionRoot.dependencies.sharedPreferHelper,
              ).createImagesInAppsFolder();
            }

            runApp(
              RootContext(
                compositionResult: compositionRoot,
              ),
            );
          } catch (error, trace) {
            //
          } finally {
            binding.allowFirstFrame();
          }
        }

        await init();
      },
      (error, trace) {
        logger.log(
          Level.error,
          "Zone error",
          error: error,
          stackTrace: trace,
        );
      },
    );
  }
}
