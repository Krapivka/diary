import 'package:diary/features/secret_entry_code/data/datasources/secret_code_local_data_source.dart';
import 'package:diary/features/secret_entry_code/data/repositories/secret_code_repository_impl.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diary/core/data/datasources/note_local_data_source.dart';
import 'package:diary/core/data/datasources/task_local_data_source.dart';
import 'package:diary/core/data/repositories/note_repository_impl.dart';
import 'package:diary/core/data/repositories/task_repository_impl.dart';
import 'package:diary/core/services/google_drive/google_drive_service.dart';
import 'package:diary/core/services/notification/notification_service.dart';
import 'package:diary/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:diary/features/settings/data/repository/settings_repository.dart';
import 'package:diary/firebase_options.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'diary_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initializ mob ads
  MobileAds.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((app) => debugPrint(app.options.toString()));
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();
  //loading open ad
  // GetIt.I.registerSingleton<AppOpenAdManager>(AppOpenAdManager());
  // GetIt.I<AppOpenAdManager>().loadAppOpenAd();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingletonAsync<PackageInfo>(() async {
    packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  });

  //initialize notification service
  await NotificationService.initializeNotifications();

  //initialize local storage
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final GoogleDriveService gds = GoogleDriveService();

  gds.loginWithGoogle();

  //await sharedPreferences.setString(USER_PASSWORD, "1234");

  final taskRepository = TaskRepository(
    localDataSource:
        TaskLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  final settingsRepository = SettingsRepository(
    localDataSource:
        SettingsLocalDataSource(sharedPreferences: sharedPreferences),
  );

  final noteRepository = NoteRepository(
    localDataSource:
        NoteLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  final secretCodeRepository = SecretCodeRepository(
    localDataSource:
        SecretCodeLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  runApp(App(
    taskRepository: taskRepository,
    settingsRepository: settingsRepository,
    noteRepository: noteRepository,
    googleDriveService: gds,
    secretCodeRepository: secretCodeRepository,
  ));
}

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
