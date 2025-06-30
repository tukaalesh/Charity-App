import 'package:charity_app/feature/wallet/screen/wallet_screen.dart';
// import 'package:charity_app/features/wallet/screen/wallet_screen.dart';
import 'package:charity_app/home/screens/achievment_page.dart';
import 'package:charity_app/home/screens/home_page.dart';
import 'package:charity_app/home/screens/opportunities_page.dart';
// import 'package:charity_app/features/zakat/screen/zakah_page.dart';
import 'package:charity_app/zakat/screen/zakah_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(4); //هون عم نبلش من الهوم

  final List<Widget> pages =  [
    const ZakahPage(),// i0
     WalletScreen(),//i1
    const AchievmentPage(),//i2
    const OpportunitiesPage(),//i3
    const HomePage(),//i4
  ];

  void changePage(int index) => emit(index);//مشان نحدث الستيت لتبني واجهتنا

  Widget get currentPage => pages[state];
}
