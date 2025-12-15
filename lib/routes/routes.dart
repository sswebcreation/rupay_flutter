import 'package:rupay/controllers/account/AccountBinding.dart';
import 'package:rupay/controllers/bank/AddBankBinding.dart';
import 'package:rupay/controllers/bank/BankBinding.dart';
import 'package:rupay/controllers/bank/MultiBankPDFBinding.dart';
import 'package:rupay/controllers/cash/AddCashBinding.dart';
import 'package:rupay/controllers/cash/CashBinding.dart';
import 'package:rupay/controllers/cash/MultiCashPDFBinding.dart';
import 'package:rupay/controllers/company/CompanyBinding.dart';
import 'package:rupay/controllers/daybook/DaybookBinding.dart';
import 'package:rupay/controllers/device/DeviceBinding.dart';
import 'package:rupay/controllers/home/HomeBinding.dart';
import 'package:rupay/controllers/ledger/LedgerBinding.dart';
import 'package:rupay/controllers/ledger/MultiLedgerPDFBinding.dart';
import 'package:rupay/controllers/login/LoginBinding.dart';
import 'package:rupay/controllers/order/AddOrderBinding.dart';
import 'package:rupay/controllers/order/MultiOrderPDFBinding.dart';
import 'package:rupay/controllers/order/OrderBinding.dart';
import 'package:rupay/controllers/otp/OTPBinding.dart';
import 'package:rupay/controllers/outstanding/MultiOSPDFBinding.dart';
import 'package:rupay/controllers/outstanding/OutstandingPaymentBinding.dart';
import 'package:rupay/controllers/purchase/AddPurchaseBinding.dart';
import 'package:rupay/controllers/purchase/MultiLIPurchasePDFBinding.dart';
import 'package:rupay/controllers/purchase/MultiPurchasePDFBinding.dart';
import 'package:rupay/controllers/purchase/PurchaseBinding.dart';
import 'package:rupay/controllers/purchase/PurchaseReturnBinding.dart';
import 'package:rupay/controllers/purchase/SinglePurchasePDFBinding.dart';
import 'package:rupay/controllers/purchase/SinglePurchaseReturnPDFBinding.dart';
import 'package:rupay/controllers/rateList/RateListBinding.dart';
import 'package:rupay/controllers/sales/AddSalesBinding.dart';
import 'package:rupay/controllers/sales/MultiLISalesPDFBinding.dart';
import 'package:rupay/controllers/sales/MultiSalesPDFBinding.dart';
import 'package:rupay/controllers/sales/SalesBinding.dart';
import 'package:rupay/controllers/sales/SalesReturnBinding.dart';
import 'package:rupay/controllers/sales/SingleSalesPDFBinding.dart';
import 'package:rupay/controllers/sales/SingleSalesReturnPDFBinding.dart';
import 'package:rupay/controllers/signUp/SignUpBinding.dart';
import 'package:rupay/controllers/splash/SplashBinding.dart';
import 'package:rupay/views/authentication/Login.dart';
import 'package:rupay/views/Splash.dart';
import 'package:rupay/views/authentication/OTP.dart';
import 'package:rupay/views/authentication/SignUp.dart';
import 'package:get/get.dart';
import 'package:rupay/views/home/Home.dart';
import 'package:rupay/views/home/account/Account.dart';
import 'package:rupay/views/home/bank/AddBank.dart';
import 'package:rupay/views/home/bank/Bank.dart';
import 'package:rupay/views/home/bank/MultiBankPDF.dart';
import 'package:rupay/views/home/cash/AddCash.dart';
import 'package:rupay/views/home/cash/Cash.dart';
import 'package:rupay/views/home/cash/MultiCashPDF.dart';
import 'package:rupay/views/home/company/Company.dart';
import 'package:rupay/views/home/company/SelectCompany.dart';
import 'package:rupay/views/home/daybook/Daybook.dart';
import 'package:rupay/views/home/device/Device.dart';
import 'package:rupay/views/home/ledger/Ledger.dart';
import 'package:rupay/views/home/ledger/MultiLedger.dart';
import 'package:rupay/views/home/ledger/MultiLedgerPDF.dart';
import 'package:rupay/views/home/order/AddOrder.dart';
import 'package:rupay/views/home/order/MultiOrderPDF.dart';
import 'package:rupay/views/home/order/Order.dart';
import 'package:rupay/views/home/outstanding/MultiOSPDF.dart';
import 'package:rupay/views/home/outstanding/OutstandingPayment.dart';
import 'package:rupay/views/home/purchase/AddPurchase.dart';
import 'package:rupay/views/home/purchase/MultiLIPurchasePDF.dart';
import 'package:rupay/views/home/purchase/MultiPurchasePDF.dart';
import 'package:rupay/views/home/purchase/Purchase.dart';
import 'package:rupay/views/home/purchase/PurchaseReturn.dart';
import 'package:rupay/views/home/purchase/SinglePurchasePDF.dart';
import 'package:rupay/views/home/purchase/SinglePurchaseReturnPDF.dart';
import 'package:rupay/views/home/rateList/RateList.dart';
import 'package:rupay/views/home/sales/AddSales.dart';
import 'package:rupay/views/home/sales/MultiLISalesPDF.dart';
import 'package:rupay/views/home/sales/MultiSalesPDF.dart';
import 'package:rupay/views/home/sales/Sales.dart';
import 'package:rupay/views/home/sales/SalesReturn.dart';
import 'package:rupay/views/home/sales/SingleSalesPDF.dart';
import 'package:rupay/views/home/sales/SingleSalesReturnPDF.dart';
import 'package:rupay/views/home/settings/ContactUs.dart';

class Routes {
  static const INITIAL = '/splash';

  static final routes = [
    GetPage(
      name: '/splash', 
      page: () => Splash(),
      binding: SplashBinding()
    ),
    GetPage(
      name: '/login',
      page: () => Login(),
      binding: LoginBinding()
    ),
    GetPage(
        name: '/otp',
        page: () => OTP(),
        binding: OTPBinding()
    ),
    GetPage(
      name: '/signUp',
      page: () => SignUp(),
      binding: SignUpBinding()
    ),
    GetPage(
      name: '/home',
      page: () => Home(),
      binding: HomeBinding()
    ),
    GetPage(
      name: '/outstandingPayment',
      page: () => OutstandingPayment(),
      binding: OutstandingPaymentBinding()
    ),
    GetPage(
      name: '/order',
      page: () => Order(),
      binding: OrderBinding()
    ),
    GetPage(
      name: '/addOrder',
      page: () => AddOrder(),
      binding: AddOrderBinding()
    ),
    GetPage(
      name: '/ledger',
      page: () => Ledger(),
        binding: LedgerBinding()
    ),
    GetPage(
      name: '/sales',
      page: () => Sales(),
      binding: SalesBinding()
    ),
    GetPage(
      name: '/addSales',
      page: () => AddSales(),
      binding: AddSalesBinding()
    ),
    GetPage(
      name: '/salesReturn',
      page: () => SalesReturn(),
      binding: SalesReturnBinding()
    ),
    GetPage(
      name: '/singleSalesPDF',
      page: () => SingleSalesPDF(),
      binding: SingleSalesPDFBinding()
    ),
    GetPage(
      name: '/singleSalesReturnPDF',
      page: () => SingleSalesReturnPDF(),
      binding: SingleSalesReturnPDFBinding()
    ),
    GetPage(
      name: '/multiLISalesPDF',
      page: () => MultiLISalesPDF(),
      binding: MultiLISalesPDFBinding()
    ),
    GetPage(
      name: '/multiSalesPDF',
      page: () => MultiSalesPDF(),
      binding: MultiSalesPDFBinding()
    ),
    GetPage(
      name: '/multiLIPurchasePDF',
      page: () => MultiLIPurchasePDF(),
      binding: MultiLIPurchasePDFBinding()
    ),
    GetPage(
      name: '/multiPurchasePDF',
      page: () => MultiPurchasePDF(),
      binding: MultiPurchasePDFBinding()
    ),
    GetPage(
        name: '/purchase',
        page: () => Purchase(),
        binding: PurchaseBinding()
    ),
    GetPage(
        name: '/addPurchase',
        page: () => AddPurchase(),
        binding: AddPurchaseBinding()
    ),
    GetPage(
        name: '/singlePurchasePDF',
        page: () => SinglePurchasePDF(),
        binding: SinglePurchasePDFBinding()
    ),
    GetPage(
        name: '/singlePurchaseReturnPDF',
        page: () => SinglePurchaseReturnPDF(),
        binding: SinglePurchaseReturnPDFBinding()
    ),
    GetPage(
        name: '/purchaseReturn',
        page: () => PurchaseReturn(),
        binding: PurchaseReturnBinding()
    ),
    GetPage(
      name: '/multiLedgerPDF',
      page: () => MultiLedgerPDF(),
      binding: MultiLedgerPDFBinding()
    ),
    GetPage(
      name: '/rateList',
      page: () => RateList(),
      binding: RateListBinding()
    ),
    GetPage(
        name: '/multiOSPDF',
        page: () => MultiOSPDF(),
        binding: MultiOSPDFBinding()
    ),
    GetPage(
        name: '/multiOrderPDF',
        page: () => MultiOrderPDF(),
        binding: MultiOrderPDFBinding()
    ),
    GetPage(
      name: '/account',
      page: () => Account(),
      binding: AccountBinding()
    ),
    GetPage(
      name: '/company',
      page: () => Company(),
      binding: CompanyBinding()
    ),
    GetPage(
      name: '/selectCompany',
      page: () => SelectCompany(),
      binding: CompanyBinding()
    ),
    GetPage(
      name: '/device',
      page: () => Device(),
      binding: DeviceBinding()
    ),
    GetPage(
      name: '/contactUs',
      page: () => ContactUs(),
    ),
    GetPage(
      name: '/daybook',
      page: () => Daybook(),
      binding: DaybookBinding(),
    ),
    GetPage(
      name: '/cash',
      page: () => Cash(),
      binding: CashBinding(),
    ),
    GetPage(
      name: '/addCash',
      page: () => AddCash(),
      binding: AddCashBinding(),
    ),
    GetPage(
        name: '/multiCashPDF',
        page: () => MultiCashPDF(),
        binding: MultiCashPDFBinding()
    ),
    GetPage(
      name: '/bank',
      page: () => Bank(),
      binding: BankBinding(),
    ),
    GetPage(
      name: '/addBank',
      page: () => AddBank(),
      binding: AddBankBinding(),
    ),
    GetPage(
        name: '/multiBankPDF',
        page: () => MultiBankPDF(),
        binding: MultiBankPDFBinding()
    ),
    GetPage(
        name: '/multiLedger',
        page: () => MultiLedger(),
        binding: LedgerBinding()
    ),
  ];
}
