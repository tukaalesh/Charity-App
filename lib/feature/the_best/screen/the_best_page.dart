import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/core/extensions/widget_extentions.dart';
import 'package:charity_app/feature/the_best/cubit/theBest_cubit.dart';
import 'package:charity_app/feature/the_best/cubit/theBest_state.dart';
import 'package:charity_app/feature/the_best/widget/description_text.dart';
import 'package:charity_app/feature/the_best/widget/best_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TheBestPage extends StatelessWidget {
  const TheBestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (_) => TheBestCubit()..fetchTheBest(),
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: const ConstAppBar(title: 'أبرز المحسنين'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DescriptionText(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: BlocConsumer<TheBestCubit, TheBestState>(
                      listener: (context, state) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        if (state is TheBestLoaded) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('تم التحميل بنجاح')),
                          // );
                        } else if (state is TheBestError) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('حدث خطأ: ${state.message}')),
                          // );
                        }
                      },
                      builder: (context, state) {
                        if (state is TheBestLoading) {
                          return Center(
                            child: SpinKitCircle(
                              color: colorScheme.secondary,
                              size: 45,
                            ),
                          );
                        } else if (state is TheBestLoaded) {
                          final donors = state.bestList;

                          return RefreshIndicator(
                            onRefresh: () =>
                                context.read<TheBestCubit>().fetchTheBest(),
                            child: AnimationLimiter(
                              child: ListView.builder(
                                itemCount: donors.length,
                                itemBuilder: (context, index) {
                                  final donor = donors[index];
                                  final rank = index + 1;

                                  return BestTitle(
                                    rank: "المرتبة ${arabicRank(rank)}",
                                    name: donor.name,
                                    points: donor.points,
                                    medal: getMedal(rank),
                                  ).staggerListVertical(index);
                                },
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String arabicRank(int rank) {
    switch (rank) {
      case 1:
        return "الأولى";
      case 2:
        return "الثانية";
      case 3:
        return "الثالثة";
      case 4:
        return "الرابعة";
      case 5:
        return "الخامسة";
      case 6:
        return "السادسة";
      case 7:
        return "السابعة";
      case 8:
        return "الثامنة";
      case 9:
        return "التاسعة";
      case 10:
        return "العاشرة";
      default:
        return "$rank";
    }
  }

  Widget? getMedal(int rank) {
    switch (rank) {
      case 1:
        return const Icon(Icons.emoji_events, color: Color(0xFF47B981));
      case 2:
        return const Icon(Icons.emoji_events, color: Color(0xFF74CD9C));
      case 3:
        return const Icon(Icons.emoji_events, color: Color(0xFFA2E1BA));
      default:
        return null;
    }
  }
}
