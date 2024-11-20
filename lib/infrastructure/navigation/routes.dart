class Routes {
  static Future<String> get initialRoute async {
    // You can add any initialization logic here if needed
    return INITIAL;
  }

  // Adding INITIAL route for splash screen
  static const INITIAL = '/';
  static const ADD_ADDRESS_PAGE = '/add-address-page';
  static const CHAT_PAGE = '/chat-page';
  static const EDIT_ADDRESS_PAGE = '/edit-address-page';
  static const FORGOT_PASSWORD_PAGE = '/forgot-password-page';
  static const HISTROY_PAGE = '/histroy-page';
  static const HOME_PAGE = '/home-page';
  static const LAINNYA_PAGE = '/lainnya-page';
  static const LISTDOCTOR_PAGE = '/listdoctor-page';
  static const LOGIN_PAGE = '/login-page';
  static const OTP_PAGE = '/otp-page';
  static const PAYMENTBOOK_PAGE = '/paymentbook-page';
  static const PAYMENT_PAGE = '/payment-page';
  static const PESAN_PAGE = '/pesan-page';
  static const PROFILE_PAGE = '/profile-page';
  static const REGISTER_PAGE = '/register-page';
  static const RESETPASSWORD_PAGE = '/resetpassword-page';
  static const SPECIFICDOCTOR_PAGE = '/specificdoctor-page';
  static const NAVBAR = '/navbar';
  static const TRANSACTION_STATUS_PROGRES_PAGE = '/transaction-status-progres-page';
  static const BIODATA_PAGE = '/biodata-page';
  static const REALTIME_PAGE = '/realtime-page';
  static const VOUCHER_PAGE = '/voucher-page';
  static const ORDER_PAKET_PAGE = '/order-paket-page';
  static const DETAIL_ARTICLE_PAGE = '/detail-article-page';
  static const DOKTERREALTIME_PAGE = '/dokterrealtime-page';
  static const DOKTERHARIAN_PAGE = '/dokterharian-page';
}