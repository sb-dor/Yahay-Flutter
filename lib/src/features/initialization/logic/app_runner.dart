import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/bloc_observer_manager/bloc_observer_manager.dart';
import 'package:yahay/src/core/utils/debug_image_creator_in_apps_folder/debug_image_creator_in_apps_folder.dart';
import 'package:yahay/src/core/utils/dotenv/dotenv.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/app_logger_factory.dart';
import 'package:yahay/src/features/initialization/widgets/root_context.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/firebase_options.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;

class AppRunner with FolderCreator {
  Future<void> initialize() async {
    //
    final Logger logger = AppLoggerFactory(
      logFilter: kReleaseMode ? NoOpLogFilter() : DevelopmentFilter(),
    ).create();

    final sharedPreferences = SharedPreferHelper();
    await sharedPreferences.initSharedPrefer();

    final dioSettings = DioSettings(
      sharedPreferHelper: sharedPreferences,
      logger: logger,
      dio: Dio(),
    );

    await dioSettings.initOptions();

    await runZonedGuarded(
      () async {
        final binding = WidgetsFlutterBinding.ensureInitialized();

        binding.deferFirstFrame();

        Future<void> init() async {
          try {
            // all blocs events are sequential by default, you can change inside the bloc's transformer (any bloc class)
            // or you can change here for all blocs
            Bloc.transformer = concurrency.sequential();
            // handles bloc errors, creations, changes, events etc.
            Bloc.observer = BlocObserverManager(logger);

            await DotEnvHelper.instance.initEnv();

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
              dioSettings: dioSettings,
            ).create();

            if (kDebugMode) {
              await DebugImageCreatorInAppsFolder(
                sharedPreferHelper: compositionRoot.dependencies.sharedPreferHelper,
                dioSettings: dioSettings,
              ).createImagesInAppsFolder();
            }

            runApp(
              RootContext(
                compositionResult: compositionRoot,
              ),
            );
          } catch (error) {
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
