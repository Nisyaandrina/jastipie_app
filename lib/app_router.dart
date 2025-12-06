import 'package:flutter/material.dart';

// Auth
import 'views/auth/login_page.dart';
import 'views/auth/register_page.dart';
import 'views/auth/role_selection_page.dart';

// Home
import 'views/home/home_jastiper.dart';
import 'views/home/home_penitip.dart';

// Trip
import 'views/trip/create_trip_page.dart';
import 'views/trip/trip_list_page.dart';
import 'views/trip/trip_detail_page.dart';

// Request
import 'views/request/create_request_page.dart';
import 'views/request/request_list_page.dart';
import 'views/request/request_detail_page.dart';

// Booking
import 'views/booking/booking_list_page.dart';
import 'views/booking/booking_detail_page.dart';

// Chat
import 'views/chat/chat_private_page.dart';
import 'views/chat/chat_group_page.dart';
import 'views/chat/chat_list_page.dart';

// Profile
import 'views/profile/profile_page.dart';
import 'views/profile/edit_profile_page.dart';

// Review
import 'views/review/review_form_page.dart';
import 'views/review/review_list_page.dart';

// Under development placeholder
import 'widgets/under_development_page.dart';

class AppRouter {
  // Default landing: use role selection (aligned with mockups)
  static const String initialRoute = '/role';

  // Named routes catalog
  static const String login = '/login';
  static const String register = '/register';
  static const String roleSelection = '/role';

  static const String homeJastiper = '/home/jastiper';
  static const String homePenitip = '/home/penitip';

  static const String tripCreate = '/trip/create';
  static const String tripList = '/trip/list';
  static const String tripDetail = '/trip/detail';

  static const String requestCreate = '/request/create';
  static const String requestList = '/request/list';
  static const String requestDetail = '/request/detail';

  static const String bookingList = '/booking/list';
  static const String bookingDetail = '/booking/detail';

  static const String chatPrivate = '/chat/private';
  static const String chatGroup = '/chat/group';
  static const String chatList = '/chat/list';

  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';

  static const String reviewForm = '/review/form';
  static const String reviewList = '/review/list';

  // Under Development routes (UI only)
  static const String udGroupChatFull = '/ud/group-chat-full';
  static const String udRatingAdvanced = '/ud/rating-advanced';
  static const String udTripFiltering = '/ud/trip-filtering';
  static const String udIdentityVerification = '/ud/identity-verification';
  static const String udPushNotification = '/ud/push-notification';
  static const String udDashboard = '/ud/dashboard';
  static const String udComplain = '/ud/complain';
  static const String udAutoMatching = '/ud/auto-matching';
  static const String udDigitalPayment = '/ud/digital-payment';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case initialRoute:
      case roleSelection:
        return _material(const RoleSelectionPage(), settings);
      case login:
        return _material(const LoginPage(), settings);
      case register:
        return _material(const RegisterPage(), settings);

      // Home (role-based)
      case homeJastiper:
        return _material(const HomeJastiperPage(), settings);
      case homePenitip:
        return _material(const HomePenitipPage(), settings);

      // Trip
      case tripCreate:
        return _material(const CreateTripPage(), settings);
      case tripList:
        return _material(const TripListPage(), settings);
      case tripDetail:
        return _material(const TripDetailPage(), settings);

      // Request
      case requestCreate:
        return _material(const CreateRequestPage(), settings);
      case requestList:
        return _material(const RequestListPage(), settings);
      case requestDetail:
        return _material(const RequestDetailPage(), settings);

      // Booking
      case bookingList:
        return _material(const BookingListPage(), settings);
      case bookingDetail:
        return _material(const BookingDetailPage(), settings);

      // Chat
      case chatPrivate:
        return _material(const ChatPrivatePage(), settings);
      case chatGroup:
        // Group chat full version is under development by requirement
        return _material(
          const UnderDevelopmentPage(title: 'Group Chat Full Version'),
          settings,
        );
      case chatList:
        return _material(const ChatListPage(), settings);

      // Profile
      case profile:
        return _material(const ProfilePage(), settings);
      case profileEdit:
        return _material(const EditProfilePage(), settings);

      // Review
      case reviewForm:
        return _material(const ReviewFormPage(), settings);
      case reviewList:
        return _material(const ReviewListPage(), settings);

      // Under Development screens
      case udGroupChatFull:
        return _material(
          const UnderDevelopmentPage(title: 'Group Chat Full Version'),
          settings,
        );
      case udRatingAdvanced:
        return _material(
          const UnderDevelopmentPage(title: 'Rating Lanjutan'),
          settings,
        );
      case udTripFiltering:
        return _material(
          const UnderDevelopmentPage(title: 'Filtering Trip'),
          settings,
        );
      case udIdentityVerification:
        return _material(
          const UnderDevelopmentPage(title: 'Verifikasi Identitas'),
          settings,
        );
      case udPushNotification:
        return _material(
          const UnderDevelopmentPage(title: 'Notifikasi Push'),
          settings,
        );
      case udDashboard:
        return _material(
          const UnderDevelopmentPage(title: 'Dashboard'),
          settings,
        );
      case udComplain:
        return _material(
          const UnderDevelopmentPage(title: 'Komplain'),
          settings,
        );
      case udAutoMatching:
        return _material(
          const UnderDevelopmentPage(title: 'Matching Otomatis'),
          settings,
        );
      case udDigitalPayment:
        return _material(
          const UnderDevelopmentPage(title: 'Pembayaran Digital'),
          settings,
        );

      // Fallback: unknown route
      default:
        return _material(
          const UnderDevelopmentPage(title: 'Halaman belum tersedia'),
          settings,
        );
    }
  }

  static MaterialPageRoute _material(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}