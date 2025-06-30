import 'package:charity_app/auth/model/user_model.dart';
import 'package:charity_app/auth/screens/change_password_screen.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_cubit.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_state.dart';
import 'package:charity_app/home/screens/setting_drawer.dart';
import 'package:charity_app/home/widgets/home/home_appbar.dart';
import 'package:charity_app/home/widgets/home/home_slider.dart';
import 'package:charity_app/home/widgets/project_donation/donation_card.dart';
import 'package:charity_app/home/widgets/project_donation/donation_title.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInitial = '?';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonationCubit>().loadProjects();
      loadUserInitial();
    });
  }

  Future<void> loadUserInitial() async {
    final token = sharedPreferences.getString('token');
    try {
      final data = await Api()
          .get(url: "http://127.0.0.1:8000/api/getUser", token: token);
      final user = UserModel.fromJson(Map<String, dynamic>.from(data));
      if (mounted && user.fullName.isNotEmpty) {
        setState(() {
          userInitial = user.fullName[0].toUpperCase();
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      appBar: appBarWidget(userName: userInitial),
      drawer: const SettingDrawer(),
      body: BlocConsumer<DonationCubit, DonationState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();

          if (state is DonationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: ${state.message}')),
            );
          } else if (state is DonationLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحميل المشاريع بنجاح')),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<DonationCubit>().loadProjects();
              await loadUserInitial();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 650,
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: HomeSlider(),
                      ),
                      const Positioned(
                        top: 180,
                        right: 12,
                        child: DonationTitle(),
                      ),
                      Positioned(
                        top: 320,
                        left: 0,
                        right: 0,
                        child: () {
                          if (state is DonationLoading ||
                              state is DonationInitial) {
                            return Center(
                              child: SpinKitCircle(
                                  size: 20, color: colorScheme.secondary),
                            );
                          } else if (state is DonationLoaded) {
                            final projects = state.projects;
                            return SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: projects.length,
                                itemBuilder: (context, index) {
                                  return DonationCard(project: projects[index]);
                                },
                              ),
                            );
                          } else if (state is DonationError) {
                            return const Center(
                              child: Text(
                                'تعذر تحميل المشاريع',
                                style: TextStyle(color: Colors.black54),
                              ),
                            );
                          }
                          return Container();
                        }(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
