import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/core/extensions/widget_extentions.dart';
import 'package:charity_app/feature/donation_history/cubit/donation_history_cubit.dart';
import 'package:charity_app/feature/donation_history/cubit/donation_history_state.dart';
import 'package:charity_app/feature/donation_history/widget/donation_card.dart';
import 'package:charity_app/feature/donation_history/widget/empty_donationhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({super.key});

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonationHistoryCubit>().loadDonations();
    });
  }

  @override
  Widget build(BuildContext context) {
      final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar(title: 'سجل التبرعات'),
        body: BlocConsumer<DonationHistoryCubit, DonationHistoryState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();

            if (state is DonationHistoryLoaded) {
              if (state.donations.isEmpty) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('لا توجد تبرعات حالياً')),
                // );
              } else {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('تم تحميل سجل التبرعات')),
                // );
              }
            } else if (state is DonationHistoryError) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('حدث خطأ: ${state.message}')),
              // );
            }
          },
          builder: (context, state) {
            if (state is DonationHistoryLoading ||
                state is DonationHistoryInitial) {
              return Center(
                child: SpinKitCircle(size: 45, color: ColorScheme.secondary),
              );
            }

            if (state is DonationHistoryLoaded) {
              final donations = state.donations;

              if (donations.isEmpty) {
                return const EmptyDonationHistory();
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<DonationHistoryCubit>().loadDonations(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'هذا سجل تبرعاتك السابقة، التي توثق مساهماتك في دعم مشاريعنا. نشكرك على دعمك المستمر واهتمامك',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                           color:  isDark ? Colors.grey[400] : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child:AnimationLimiter (
                          child: ListView.separated(
                            itemCount: donations.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 2),
                            itemBuilder: (context, index) {
                              final donation = donations[index];
                              return DonationHistoryCard(donation: donation).staggerListVertical(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is DonationHistoryError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
