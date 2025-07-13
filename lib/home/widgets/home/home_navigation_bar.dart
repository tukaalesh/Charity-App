import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation/navigation_cubit.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  void navigate(BuildContext context, int index) {
    final cubit = context.read<NavigationCubit>();
    cubit.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme =context.colorScheme;
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
          selectedItemColor: ColorScheme.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) => navigate(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake),
               label: 'زكاة'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'المحفظة'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet_giftcard_outlined),
                 label: 'الهدية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                 label: 'فرص التبرع'),
            BottomNavigationBarItem(icon: Icon(Icons.home),
             label: 'الرئيسية'),
          ],
        );
      },
    );
  }
}
