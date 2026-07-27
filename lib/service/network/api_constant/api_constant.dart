class ApiConstant {

  /// Live Url
  // static const url = 'https://api.thehealinggroove.com/api/';

  /// Local Url
  static const url = 'https://ferocious-underling-snooze.ngrok-free.dev/api/';
  static const signIn = '${url}users/login';
  static const sendOtp = '${url}auth/send-otp';
  static const verifyOtp = '${url}auth/verify-otp';
  static const resendOtp = '${url}auth/resend-otp';
  static const createAccount = '${url}users/';
  static const updateUserProfile = '${url}users/';
  static const logout = '${url}users/logout';
  static const userMe = '${url}users/me';
  static const getCenters = '${url}centers';
  static const getCentersDetail = '${url}centers/';
  static const refreshToken = '${url}users/refresh-token';
  static const helpAndSupport = '${url}support-tickets';
  static const centreProgram = '${url}center-program-data/';
  static const seatAvailability = '${url}package-seat-availability/';
  static const createBooking = '${url}bookings';
  static const createRazorPayOrder = '${url}payments/razorpay/order';
  static const verifyRazorPay = '${url}payments/razorpay/verify';
  static const myBookings = '${url}bookings';
  static const requestCancellation = '${url}cancel-booking/request';
  static const getEnquiriesAndBookings = '${url}service-requests';
  static const refundEnquiries = '${url}cancel-booking/preview';
  static const saveCentre = '${url}users/me/saved-centers';
  static const getSaveCentre = '${url}users/me/saved-centers';


}
