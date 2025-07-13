// ignore_for_file: camel_case_types

import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/widgets/initial_circle.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';

// final unread_count = sharedPreferences.get("unread_count");

class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const appBarWidget({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final unReadPoits = sharedPreferences.getString("unreadPoints");

    final colorScheme = context.colorScheme;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Builder(
          builder: (context) => Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                color: colorScheme.primary,
                iconSize: 30,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              const SizedBox(width: 8),
              // Stack(
              //   children: [
              //     IconButton(
              //       icon: const Icon(Icons.notifications_none),
              //       color: colorScheme.primary,
              //       iconSize: 30,
              //       onPressed: () {
              //         print("$unReadPoits");
              //         Navigator.pushNamed(context, 'Notification');
              //       },
              //     ),
              //     Positioned(
              //       right: 4,
              //       top: 4,
              //       child: Container(
              //         width: 20,
              //         height: 20,
              //         alignment: Alignment.center,
              //         decoration: const BoxDecoration(
              //           color: Color.fromRGBO(223, 0, 0, 0.737),
              //           shape: BoxShape.circle,
              //         ),
              //         child: Text(
              //           "$unReadPoits",
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontSize: 12,
              //             fontWeight: FontWeight.bold,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
          child: Initialcircle(
            text: userName.substring(0, 1).toUpperCase(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); //هاد شي ثابت بفلاتر ارتفاعه 56
}


//عملت اب بار مخصص مشان مايكبر الكود بالهوم ويكون واضح 
