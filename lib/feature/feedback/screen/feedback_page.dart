import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/core/extensions/widget_extentions.dart';
import 'package:charity_app/feature/feedback/cubit/feedback_cubit.dart';
import 'package:charity_app/feature/feedback/cubit/feedback_state.dart';
import 'package:charity_app/feature/feedback/widget/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
     final colorScheme=context.colorScheme;
    return BlocProvider(
      create: (_) => FeedbackCubit()..fetchFeedbacks(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: const ConstAppBar(title: 'آراء المستفيدين'),
          body: BlocConsumer<FeedbackCubit, FeedbackState>(
            listener: (context, state) {
              ScaffoldMessenger.of(context).clearSnackBars();

              if (state is FeedbackLoaded) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('تم تحميل الآراء بنجاح')),
                // );
              } else if (state is FeedbackError) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('حدث خطأ: ${state.message}')),
                // );
              }
            },
            builder: (context, state) {
              if (state is FeedbackLoading) {
                return Center(
                  child: SpinKitCircle(size: 45, color: colorScheme.secondary),
                );
              } else if (state is FeedbackLoaded) {
                if (state.feedbacks.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا توجد آراء حالياً',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<FeedbackCubit>().fetchFeedbacks(),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.feedbacks.length,
                      itemBuilder: (context, index) {
                        final feedback = state.feedbacks[index];
                        return FeedbackCard(
                          userName: feedback.userName,
                          message: feedback.message,
                          date: feedback.date,
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
      ),
    );
  }
}
