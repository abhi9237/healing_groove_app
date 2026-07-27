import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/auth/onBoarding/onBoarding_view.dart';
import 'package:healing/presentation/auth/welcome/welcome_view.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/view/user/review_booking/review_booking_screen.dart';

import '../../presentation/auth/auth_selection/auth_selection_view.dart';
import '../../presentation/auth/create_account/create_account_view.dart';
import '../../presentation/auth/login/login_view.dart';
import '../../presentation/auth/select_preference/select_preference_view.dart';
import '../../presentation/auth/tell_us_about_yourself/tell_us_about_yourself_view.dart';
import '../../presentation/auth/verify_otp/verify_otp_view.dart';
import '../../presentation/view/user/user_bottom_navigation/user_bottom_nav_view.dart';
import '../../presentation/view/user/explore_all/explore_all.dart';
import '../../presentation/view/user/view_detail/view_detail_screen.dart';
import '../../presentation/view/user/book_program/book_program_screen.dart';
import '../../presentation/view/user/enquire_now/enquire_now.dart';
import '../../presentation/view/user/my_journey_detail/my_journey_detail.dart';
import '../../presentation/view/user/cancel_booking/cancel_booking.dart';
import '../../presentation/view/user/cancel_confirmation/cancel_confirmation.dart';
import '../../presentation/view/user/enquiries_detail_view/enquiries_detail_screen.dart';
import '../../presentation/view/user/edit_profile/edit_profile_screen.dart';
import '../../presentation/view/user/help_support/help_support_screen.dart';
import '../../presentation/auth/forgot_password/forgot_password_view.dart';
import '../../presentation/view/user/saved_program/saved_program_screen.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RouteConstant.onBoarding,

    // redirect: (BuildContext context, GoRouterState state) async {
    //
    //   final bool isLoggedIn = await StorageService.hasToken();
    //
    //   final isAuthRoute = state.matchedLocation == RouteConstant.login ||
    //       state.matchedLocation == RouteConstant.otpVerification;
    //
    //   if (!isLoggedIn && !isAuthRoute) {
    //     return RouteConstant.login;
    //   }
    //
    //   if (isLoggedIn && isAuthRoute) {
    //     return RouteConstant.dashboard;
    //   }
    //
    //   // 4. If none of the above conditions are met, allow navigation.
    //   return null;
    // },
    routes: [
      GoRoute(
        path: RouteConstant.onBoarding,
        name: RouteConstant.onBoarding,
        builder: (context, state) {
          return OnBoardingView();
        },
      ),
      GoRoute(
        path: RouteConstant.welcome,
        name: RouteConstant.welcome,
        builder: (context, state) {
          return WelcomeView();
        },
      ),
      GoRoute(
        path: RouteConstant.login,
        name: RouteConstant.login,
        builder: (context, state) {
          return LoginView();
        },
      ),
      GoRoute(
        path: RouteConstant.authSelection,
        name: RouteConstant.authSelection,
        builder: (context, state) {
          return AuthSelectionView();
        },
      ),
      GoRoute(
        path: RouteConstant.createAccount,
        name: RouteConstant.createAccount,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          return CreateAccountView(arguments: extra);
        },
      ),
      GoRoute(
        path: RouteConstant.otpVerification,
        name: RouteConstant.otpVerification,
        builder: (context, state) {
          return const VerifyOtpView();
        },
      ),
      GoRoute(
        path: RouteConstant.tellUsAboutYourself,
        name: RouteConstant.tellUsAboutYourself,
        builder: (context, state) {
          return const TellUsAboutYourselfView();
        },
      ),
      GoRoute(
        path: RouteConstant.selectPreference,
        name: RouteConstant.selectPreference,
        builder: (context, state) {
          return const SelectPreferenceView();
        },
      ),
      GoRoute(
        path: RouteConstant.myJourneyDetail,
        name: RouteConstant.myJourneyDetail,
        builder: (context, state) {
          final extra = state.extra as Map<String,dynamic>;
          return  MyJourneyDetailScreen(
            bookingDetail: extra['bookingDetail'],
          );
        },
      ),
      GoRoute(
        path: RouteConstant.cancelBooking,
        name: RouteConstant.cancelBooking,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final bookingId = extra['bookingId'] as int;
          return CancelBooking(
            bookingId: bookingId,
          );
        },
      ),
      GoRoute(
        path: RouteConstant.cancelConfirmation,
        name: RouteConstant.cancelConfirmation,
        builder: (context, state) {
          return const CancelConfirmation();
        },
      ),
      GoRoute(
        path: RouteConstant.savedProgram,
        name: RouteConstant.savedProgram,
        builder: (context, state) {
          return const SavedProgramScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.viewDetail,
        name: RouteConstant.viewDetail,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return  ViewDetailScreen(
            data: extra,
          );
        },
      ),
      GoRoute(
        path: '${RouteConstant.enquiriesDetail}/:enquiryId',
        name: RouteConstant.enquiriesDetail,
        builder: (context, state) {
          final enquiryId = state.pathParameters['enquiryId'] ?? 'ENQ-29';
          final extra = state.extra as Map<String, dynamic>?;
          final enquiryDetail = extra?['enquiryDetail'] as DocModel?;
          return EnquiriesDetailScreen(
            enquiryId: enquiryId,
            enquiryDetail: enquiryDetail,
          );
        },
      ),
      GoRoute(
        path: RouteConstant.editProfile,
        name: RouteConstant.editProfile,
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.reviewBooking,
        name: RouteConstant.reviewBooking,
        builder: (context, state) {
          return  ReviewBookingScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.helpSupport,
        name: RouteConstant.helpSupport,
        builder: (context, state) {
          return const HelpSupportScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.forgotPassword,
        name: RouteConstant.forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordView();
        },
      ),
      GoRoute(
        path: RouteConstant.bookProgram,
        name: RouteConstant.bookProgram,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final data = extra?['programDetail'];
          return BookProgramScreen(data: data);
        },
      ),
      GoRoute(
        path: RouteConstant.enquireNow,
        name: RouteConstant.enquireNow,
        builder: (context, state) {
          return const EnquireNowUi();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return UserBottomNavView(child: child);
        },
        routes: [
          GoRoute(
            path: RouteConstant.userDashboard,
            name: RouteConstant.userDashboard,
            builder: (context, state) {
              return const UserDashboardTabsScreen();
            },
          ),
          GoRoute(
            path: RouteConstant.exploreAll,
            name: RouteConstant.exploreAll,
            builder: (context, state) {
              return const ExploreAllUi();
            },
          ),


        ],
      ),
    ],
  );
}
