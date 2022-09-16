import 'package:flutter/material.dart';

const logo = "https://www.topvalu.net/img/logo_topvalu.png";

const Color scaffoldBackground = Colors.white;
const Color appBarColor = Colors.white;
const Color appBarTitleColor = Color.fromRGBO(19, 19, 19, 1);
const Color homeIndicatorColor = Colors.pink;
const Color detailBackgroundColor = Colors.white;
const Color detailTextBackgroundColor = Colors.white;
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
);

const boxName = "productBox";
const purchaseBox = "purchaseBox";

const List<String> statusList = [
  "NEW",
  "RECOMMEND",
];

enum PaymentOptions {
  CashOnDelivery,
  PrePay,
  None,
}

const fcmKey =
    "AAAAKSYj5mc:APA91bH8mUxPIyxEFH-ERNib8Ah_lCGEmi_vXsD8AacyUyqt_8ZUrTx-9yNEherKxxFbdnSyW8M5WkZLYCPuXySKauMTZtfPvopGSopnO3OVhnJNjXANuSMc77An4zitzAuSly2GWW4c";
