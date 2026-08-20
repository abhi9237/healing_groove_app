
import 'package:go_router/go_router.dart';
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/presentation/model/response/centre_response_model.dart';
import 'package:healing/presentation/auth/onBoarding/onBoarding_view.dart';
import 'package:healing/presentation/auth/welcome/welcome_view.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/view/terms_and_privacy/terms_and_privacy_screen.dart';
import 'package:healing/presentation/view/user/review_booking/review_booking_screen.dart';
import 'package:healing/presentation/view/wellness_centre/program_and_packages/programs_and_packages_screen.dart';
import 'package:healing/presentation/view/wellness_centre/set_up_your_centre/set_up_your_centre.dart';
import 'package:healing/presentation/view/wellness_centre/centre_detail/centre_detail.dart';
import 'package:healing/presentation/view/wellness_centre/make_it_shine/make_it_shine.dart';
import 'package:healing/presentation/view/wellness_centre/centre_under_review/centre_under_review.dart';
import 'package:healing/presentation/view/wellness_centre/wellness_bottom_navigation/wellness_bottom_nav_bar.dart';
import 'package:healing/presentation/view/wellness_centre/booking_detail/wellness_booking_detail_screen.dart';
import 'package:healing/presentation/view/wellness_centre/add_new_program/add_new_program_screen.dart';
import 'package:healing/presentation/view/wellness_centre/add_service/add_service_screen.dart';
import 'package:healing/presentation/view/wellness_centre/services/services_screen.dart';
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
import '../../presentation/view/user/change_password/change_password_screen.dart';
import '../../presentation/view/user/saved_program/saved_program_screen.dart';
import '../../presentation/view/wellness_centre/program_preview_detail/program_preview_detail_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/consultation_request/consultation_request_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/guest/guest_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/doctor/doctor_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/adddoctor/add_doctor_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/revenue/revenue_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/report/report_screen.dart';
import '../../presentation/view/wellness_centre/settings/ui/support/support_screen.dart';
import '../../presentation/auth/splash/splash_screen.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RouteConstant.splash,

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
        path: RouteConstant.splash,
        name: RouteConstant.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
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
        path: RouteConstant.termsAndPrivacy,
        name: RouteConstant.termsAndPrivacy,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final bool isTerms = extra?['isTerms'] ?? true;
          return TermsAndPrivacyScreen(isTerms: isTerms);
        },
      ),
      GoRoute(
        path: RouteConstant.programsAndPackages,
        name: RouteConstant.programsAndPackages,
        builder: (context, state) {
          return ProgramsAndPackagesScreen();
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
          final extra = state.extra as Map<String, dynamic>?;

          return TellUsAboutYourselfView(
            comingFrom: extra?['comingFrom'] ?? '',
          );
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
        path: RouteConstant.setUpYourCentre,
        name: RouteConstant.setUpYourCentre,
        builder: (context, state) {

          return SetUpYourCentre();
        },
      ),
      GoRoute(
        path: RouteConstant.centreDetail,
        name: RouteConstant.centreDetail,
        builder: (context, state) {
          return const CentreDetail();
        },
      ),
      GoRoute(
        path: RouteConstant.makeItShine,
        name: RouteConstant.makeItShine,
        builder: (context, state) {
          return const MakeItShine();
        },
      ),
      GoRoute(
        path: RouteConstant.centreUnderReview,
        name: RouteConstant.centreUnderReview,
        builder: (context, state) {
          final extra = state.extra as CentreResponseModel?;
          return CentreUnderReview(centreResponse: extra);
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
        path: RouteConstant.consultationRequest,
        name: RouteConstant.consultationRequest,
        builder: (context, state) {
          return const ConsultationRequestScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.guest,
        name: RouteConstant.guest,
        builder: (context, state) {
          return const GuestScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.doctors,
        name: RouteConstant.doctors,
        builder: (context, state) {
          return const DoctorScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.addDoctor,
        name: RouteConstant.addDoctor,
        builder: (context, state) {
          return const AddDoctorScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.revenue,
        name: RouteConstant.revenue,
        builder: (context, state) {
          return const RevenueScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.report,
        name: RouteConstant.report,
        builder: (context, state) {
          return const ReportScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.support,
        name: RouteConstant.support,
        builder: (context, state) {
          return const SupportScreen();
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
        path: RouteConstant.changePassword,
        name: RouteConstant.changePassword,
        builder: (context, state) {
          return const ChangePasswordScreen();
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
          final extra = state.extra as Map<String, dynamic>?;
          return EnquireNowUi(data: extra);
        },
      ),
      GoRoute(
        path: RouteConstant.wellnessBookingDetail,
        name: RouteConstant.wellnessBookingDetail,
        builder: (context, state) {
          if (state.extra is DocModel) {
            final doc = state.extra as DocModel;
            return WellnessBookingDetailScreen(
              bookingId: doc.id?.toString() ?? '',
              bookingDoc: doc,
            );
          }
          final bookingId = state.extra as String? ?? 'BK-MP3KB6I7';
          return WellnessBookingDetailScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: RouteConstant.addNewProgram,
        name: RouteConstant.addNewProgram,
        builder: (context, state) {
          final program = state.extra as DocModel?;
          return AddNewProgramScreen(program: program);
        },
      ),
      GoRoute(
        path: RouteConstant.addService,
        name: RouteConstant.addService,
        builder: (context, state) {
          return const AddServiceScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.wellnessServices,
        name: RouteConstant.wellnessServices,
        builder: (context, state) {
          return const ServicesScreen();
        },
      ),
      GoRoute(
        path: RouteConstant.programPreviewDetail,
        name: RouteConstant.programPreviewDetail,
        builder: (context, state) {
          final program = state.extra as DocModel;
          return ProgramPreviewDetailScreen(program: program);
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
      ShellRoute(
        builder: (context, state, child) {
          return WellnessBottomNavView(child: child);
        },
        routes: [
          GoRoute(
            path: RouteConstant.wellnessDashboard,
            name: RouteConstant.wellnessDashboard,
            builder: (context, state) {
              return const WellnessDashboardTabsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
