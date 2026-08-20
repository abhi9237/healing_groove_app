class ApiConstant {

  /// Live Url
  // static const url = 'https://api.thehealinggroove.com/api/';

  /// Local Url
  // static const url = 'https://ferocious-underling-snooze.ngrok-free.dev/api/';

  static const url = 'http://192.168.1.56:3000/api/';

  static const signIn = '${url}users/login';
  static const sendOtp = '${url}auth/send-otp';
  static const verifyOtp = '${url}auth/verify-otp';
  static const resetPassword = '${url}auth/reset-password';
  static const changePassword = '${url}auth/change-password';
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
  static const deleteProgram = '${url}packages/';
  static const seatAvailability = '${url}package-seat-availability/';
  static const createBooking = '${url}bookings';
  static const createRazorPayOrder = '${url}payments/razorpay/order';
  static const verifyRazorPay = '${url}payments/razorpay/verify';
  static const myBookings = '${url}bookings';
  static const requestCancellation = '${url}cancel-booking/request';
  static const getEnquiriesService = '${url}service-requests';
  static const searchEnquiriesService = '${url}service-requests/search';
  static const enquireService = '${url}service-requests';
  static const refundEnquiries = '${url}cancel-booking/preview';
  static const saveCentre = '${url}users/me/saved-centers';
  static const getSaveCentre = '${url}users/me/saved-centers';
  static const genRateInvoice = '${url}invoice/';
  static const getPackages = '${url}packages';
  static const searchCenters = '${url}search';

  // Wellness Center
  static const uploadImage = '${url}media';
  static const createCentre = '${url}centers';
  static const centreStatus = '${url}centers';
  static const centreServices = '${url}services';
  static const createCentreServices = '${url}services';
  static const updateCentreServices = '${url}services/';
  static const deleteCentreServices = '${url}services/';
  static const getPrograms = '${url}packages/';
  static const createPrograms = '${url}packages';
  static const updatePrograms = '${url}packages/';
  static const centreBookings = '${url}bookings';
  static const getDoctors = '${url}users';
  static const addDoctor = '${url}users';
  static const getRevenue = '${url}bookings/';
  static const createSupportTicket = '${url}support-tickets';
  static const terms = '${url}terms';
  static const privacyPolicy = '${url}privacy-policy';

}
