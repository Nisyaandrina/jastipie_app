import 'package:flutter/material.dart';
import 'package:jastipie_app/src/views/auth/login_page.dart';
import 'package:jastipie_app/src/views/auth/register_page.dart';
import 'package:jastipie_app/src/views/auth/role_selection_page.dart';
import 'package:jastipie_app/src/views/home/home_jastiper.dart';
import 'package:jastipie_app/src/views/home/home_penitip.dart';
import 'package:jastipie_app/src/views/trip/create_trip_page.dart';
import 'package:jastipie_app/src/views/trip/trip_detail_page.dart';
import 'package:jastipie_app/src/views/trip/trip_list_page.dart';
import 'package:jastipie_app/src/widgets/under_development_page.dart';

class AppRouter {
  // Rute Otentikasi
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String roleSelectionRoute = '/role-selection';

  // Rute Home
  static const String homeJastiperRoute = '/home-jastiper';
  static const String homePenitipRoute = '/home-penitip';

  // Rute Trip
  static const String tripListRoute = '/trip-list';
  static const String tripDetailRoute = '/trip-detail';
  static const String createTripRoute = '/create-trip';

  // Rute 'Under Development'
  static const String requestListRoute = '/request-list';
  static const String createRequestRoute = '/create-request';
  static const String requestDetailRoute = '/request-detail';
  static const String bookingListRoute = '/booking-list';
  static const String bookingDetailRoute = '/booking-detail';
  static const String chatListRoute = '/chat-list';
  static const String chatPrivateRoute = '/chat-private';
  static const String chatGroupRoute = '/chat-group';
  static const String profileRoute = '/profile';
  static const String editProfileRoute = '/edit-profile';
  static const String reviewFormRoute = '/review-form';
  static const String reviewListRoute = '/review-list';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case roleSelectionRoute:
        return MaterialPageRoute(builder: (_) => const RoleSelectionPage());
      case homeJastiperRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeJastiperPage(),
        ); // ✅ samakan nama
      case homePenitipRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePenitipPage(),
        ); 
      case tripListRoute:
        return MaterialPageRoute(builder: (_) => const TripListPage());
      case createTripRoute:
        return MaterialPageRoute(builder: (_) => const CreateTripPage());
      case tripDetailRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => TripDetailPage(tripId: args),
          );
        }
        return _errorRoute();

      // Under Development
      case requestListRoute:
      case createRequestRoute:
      case requestDetailRoute:
      case bookingListRoute:
      case bookingDetailRoute:
      case chatListRoute:
      case chatPrivateRoute:
      case chatGroupRoute:
      case profileRoute:
      case editProfileRoute:
      case reviewFormRoute:
      case reviewListRoute:
        return MaterialPageRoute(
          builder: (_) =>
              UnderDevelopmentPage(routeName: settings.name ?? 'Unknown'),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Halaman tidak ditemukan!')),
        );
      },
    );
  }
}
