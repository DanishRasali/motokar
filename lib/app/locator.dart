import 'package:get_it/get_it.dart';
import 'package:motokar/screens/guest/guest_chat/guest_chat_viewmodel.dart';
import 'package:motokar/screens/host/host_chat/host_chat_viewmodel.dart';

import 'package:motokar/screens/signin/signin_viewmodel.dart';
import 'package:motokar/screens/signup/signup_viewmodel.dart';
import 'package:motokar/screens/host/host_explore/host_explore_viewmodel.dart';
import 'package:motokar/screens/host/host_trips/host_trips_viewmodel.dart';
import 'package:motokar/screens/host/host_garage/host_garage_viewmodel.dart';
import 'package:motokar/screens/host/host_post/host_post_viewmodel.dart';
import 'package:motokar/screens/host/host_profile/host_profile_viewmodel.dart';
import 'package:motokar/screens/guest/guest_explore/guest_explore_viewmodel.dart';
import 'package:motokar/screens/guest/guest_post/guest_post_viewmodel.dart';
import 'package:motokar/screens/guest/guest_profile/guest_profile_viewmodel.dart';
import 'package:motokar/screens/guest/guest_trips/guest_trips_viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/chat_service.dart';
import 'package:motokar/services/cloud_storage_service.dart';
import 'package:motokar/services/post_services.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:motokar/services/rating_service.dart';
import 'package:motokar/services/trip_service.dart';
import 'package:motokar/services/vehicle_service.dart';

final GetIt locator = GetIt.instance;

void initializeLocator() {
  locator.registerLazySingleton(() => AuthenticationService());

  // firestore service
  locator.registerLazySingleton(() => ProfileService());
  locator.registerLazySingleton(() => VehicleService());
  locator.registerLazySingleton(() => TripService());
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => RatingService());
  locator.registerLazySingleton(() => CloudStorageService());

  // ViewModels
  locator.registerLazySingleton(() => SignInViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());

  locator.registerLazySingleton(() => HostExploreViewModel());
  locator.registerLazySingleton(() => HostTripsViewModel());
  locator.registerLazySingleton(() => HostGarageViewModel());
  locator.registerLazySingleton(() => HostPostViewModel());
  locator.registerLazySingleton(() => HostProfileViewModel());
  locator.registerLazySingleton(() => HostChatViewModel());

  locator.registerLazySingleton(() => GuestExploreViewModel());
  locator.registerLazySingleton(() => GuestTripsViewModel());
  locator.registerLazySingleton(() => GuestPostViewModel());
  locator.registerLazySingleton(() => GuestProfileViewModel());
  locator.registerLazySingleton(() => GuestChatViewModel());
}
