import 'package:charity_app/feature/gift/screen/gift_screen.dart';
import 'package:charity_app/feature/opportunities/screen/opportunities_screen.dart';
import 'package:charity_app/feature/wallet/screen/wallet_screen.dart';
import 'package:charity_app/home/screens/home_page.dart';
import 'package:charity_app/feature/zakat/screen/zakah_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(4); //هون عم نبلش من الهوم

  final List<Widget> pages = [
    const ZakahPage(), // i0
    WalletScreen(), //i1
    GiftScreen(), //i2
    const OpportunitiesScreen(), //i3
    const HomePage(), //i4
  ];

  void changePage(int index) => emit(index); //مشان نحدث الستيت لتبني واجهتنا

  Widget get currentPage => pages[state];
}
