import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:psikolog_app/app/config.dart';
import 'package:psikolog_app/common_menu/navbar_menu.dart';
import 'package:psikolog_app/presentation/detail_article_page/controllers/detail_article_page.controller.dart';
import 'package:psikolog_app/splashscreen/splashscreen.dart';

import '../../presentation/paymentbook_page/controllers/paymentbook_page.controller.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginPageScreen(),
      binding: LoginPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPageScreen(),
      binding: RegisterPageControllerBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD_PAGE,
      page: () => const ForgotPasswordPageScreen(),
      binding: ForgotPasswordPageControllerBinding(),
    ),
    GetPage(
      name: Routes.OTP_PAGE,
      page: () => OtpPageScreen(),
      binding: OtpPageControllerBinding(),
    ),
    GetPage(
      name: Routes.RESETPASSWORD_PAGE,
      page: () => const ResetpasswordPageScreen(),
      binding: ResetpasswordPageControllerBinding(),
    ),
    GetPage(
      name: Routes.CHAT_PAGE,
      page: () => ChatPageScreen(),
      binding: ChatPageControllerBinding(),
    ),
    GetPage(name: Routes.NAVBAR, page: () => NavbarMenu(), bindings: [
      HomePageControllerBinding(),
      HistroyPageControllerBinding(),
      ProfilePageControllerBinding(),
      PesanPageControllerBinding(),
      LainnyaPageControllerBinding()
    ]),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => const HomePageScreen(),
      binding: HomePageControllerBinding(),
    ),
    GetPage(
      name: Routes.LISTDOCTOR_PAGE,
      page: () => const ListdoctorPageScreen(),
      binding: ListdoctorPageControllerBinding(),
    ),
    GetPage(
      name: Routes.SPECIFICDOCTOR_PAGE,
      page: () => const SpecificdoctorPageScreen(),
      binding: SpecificdoctorPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_PAGE,
      page: () => const PaymentPageScreen(),
      binding: PaymentPageControllerBinding(),
    ),
    GetPage(
      name: Routes.HISTROY_PAGE,
      page: () => const HistroyPageScreen(),
      binding: HistroyPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_PAGE,
      page: () => const ProfilePageScreen(),
      binding: ProfilePageControllerBinding(),
    ),
    GetPage(
      name: Routes.PESAN_PAGE,
      page: () => PesanPageScreen(),
      binding: PesanPageControllerBinding(),
    ),
    GetPage(
      name: Routes.LAINNYA_PAGE,
      page: () => const LainnyaPageScreen(),
      binding: LainnyaPageControllerBinding(),
    ),
    GetPage(
        name: Routes.PAYMENTBOOK_PAGE,
        page: () => PaymentbookPageScreen(),
        binding: PaymentbookPageControllerBinding()),
    GetPage(
      name: Routes.ADD_ADDRESS_PAGE,
      page: () => const AddAddressPageScreen(),
      binding: AddAddressPageControllerBinding(),
    ),
    GetPage(
      name: Routes.EDIT_ADDRESS_PAGE,
      page: () => const EditAddressPageScreen(),
      binding: EditAddressPageControllerBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_STATUS_PROGRES_PAGE,
      page: () => const TransactionStatusProgresPageScreen(),
      binding: TransactionStatusProgresPageControllerBinding(),
    ),
    GetPage(
      name: Routes.BIODATA_PAGE,
      page: () => BiodataPageScreen(),
    ),
    GetPage(
      name: Routes.REALTIME_PAGE,
      page: () => const RealtimePageScreen(),
      binding: RealtimePageControllerBinding(),
    ),
    GetPage(
      name: Routes.VOUCHER_PAGE,
      page: () => const VoucherPageScreen(),
      binding: VoucherPageControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDER_PAKET_PAGE,
      page: () => OrderPaketPageScreen(),
      binding: OrderPaketPageControllerBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_ARTICLE_PAGE,
      page: () => DetailArticlePageScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DetailArticlePageController>(
            () => DetailArticlePageController());
      }),
    ),
    GetPage(
      name: Routes.DOKTERREALTIME_PAGE,
      page: () => const DokterrealtimePageScreen(),
      binding: DokterrealtimePageControllerBinding(),
    ),
     GetPage(
      name: Routes.DOKTERHARIAN_PAGE,
      page: () => const DokterharianPageScreen(),
      binding: DokterharianPageControllerBinding(),
    ),
  ];
}
