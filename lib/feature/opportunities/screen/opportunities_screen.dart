import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/screen/project_screen.dart';
import 'package:charity_app/feature/opportunities/screen/urgent_screen.dart';
import 'package:flutter/material.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final isDark = context.isDarkMode;
     final ColorScheme =context.colorScheme;
    return DefaultTabController(
      length: 2, //عدد التابس

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new, 
                color: isDark ? Colors.grey[400] : Colors.black),
              onPressed: () {
            
              },
            ),
            title:  Text(
              'فرص التبرع',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                   color:  isDark ? Colors.grey[400] : Colors.black,),
            ),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'مشاريع'),
                Tab(text: 'حالات عاجلة'),
              ],
              labelColor:  isDark ? Colors.grey[400] : Colors.black,
             // labelColor: Colors.black,
             unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey,
              // unselectedLabelColor: Colors.grey,
              indicatorColor: ColorScheme.primary,
              indicatorWeight: 3,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: -11),
            ),
            elevation: 0,
          ),
          body: const TabBarView(
            children: [
              ProjectsScreen(),
              UrgentScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
