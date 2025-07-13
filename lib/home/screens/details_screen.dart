import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/home/cubits/button/donate_now_cubit.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/home/widgets/project_donation/donation_field.dart';

class DetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const DetailsScreen({super.key, required this.project});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final TextEditingController customAmountController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<int> donationOptions = [100, 200, 400, 500];

  late int currentAmount;

  @override
  void initState() {
    super.initState();
    customAmountController = TextEditingController();
    currentAmount = widget.project.currentAmount;
  }

  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme = context.colorScheme;
    final fullDescription =
        widget.project.description ?? 'لا يوجد وصف متوفر لهذا المشروع.';

    final totalAmount = widget.project.totalAmount ?? 0;

    final progress =
        (totalAmount > 0) ? (currentAmount / totalAmount).clamp(0.0, 1.0) : 0.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (_) => DescriptionCubit(),
        child: Scaffold(
          appBar: const ConstAppBar(
            title: "تفاصيل المشروع",
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.project.photoUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image,
                                size: 100, color: Colors.grey),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: progress),
                              duration: const Duration(milliseconds: 500),
                              builder: (context, value, child) {
                                return LinearProgressIndicator(
                                  value: value,
                                  color: value > 0
                                      ? ColorScheme.secondary
                                      : Colors.grey,
                                  backgroundColor: Colors.grey[300],
                                  minHeight: 8,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${(progress * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<DescriptionCubit, bool>(
                      builder: (context, showFullDescription) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: showFullDescription
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Text(
                                fullDescription,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              secondChild: Text(
                                fullDescription,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  showFullDescription
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: ColorScheme.primary,
                                ),
                                onPressed: () {
                                  context.read<DescriptionCubit>().toggle();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<DonationAmountCubit, String>(
                      builder: (context, selectedAmount) {
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: donationOptions.map((amount) {
                            final isSelected =
                                selectedAmount == amount.toString();
                            return OutlinedButton(
                              onPressed: () {
                                context
                                    .read<DonationAmountCubit>()
                                    .selectAmount(amount.toString());
                                customAmountController.text = amount.toString();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: ColorScheme.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                foregroundColor: ColorScheme.primary,
                                backgroundColor: isSelected
                                    ? ColorScheme.primary.withOpacity(0.1)
                                    : null,
                              ),
                              child: Text('\$$amount'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    DonationField(
                      controller: customAmountController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "الرجاء إدخال مبلغ التبرع";
                        }
                        final parsedAmount = double.tryParse(value.trim());
                        if (parsedAmount == null) {
                          return "الرجاء إدخال رقم صالح";
                        }
                        if (parsedAmount <= 0) {
                          return "يرجى إدخال مبلغ صالح أكبر من 0";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    BlocConsumer<DonationButtonCubit, DonationButtonState>(
                      listener: (context, state) {
                        if (state is DonationButtonSuccess) {
                          //Navigator.pop(context, true);

                          final donated = double.tryParse(
                              customAmountController.text.trim());
                          if (donated != null) {
                            setState(() {
                              currentAmount += donated.toInt();
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("تم التبرع بنجاح"),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          );
                          customAmountController.clear();
                          context.read<DonationAmountCubit>().selectAmount('');
                          formKey.currentState?.reset();
                        } else if (state is DonationButtonFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("حدث خطأ أثناء التبرع"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is DonationLoading;
                        final colorScheme = Theme.of(context).colorScheme;

                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      final amount = double.tryParse(
                                          customAmountController.text.trim());
                                      if (amount == null || amount <= 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'الرجاء إدخال مبلغ صالح')),
                                        );
                                        return;
                                      }

                                      context
                                          .read<DonationButtonCubit>()
                                          .donateToProject(
                                            projectId: widget.project.id,
                                            amount: amount.toInt(),
                                          );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('تبرع الآن'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        '{ لَنْ تَنَالُوا الْبِرَّ حَتَّى تُنْفِقُوا مِمَّا تُحِبُّونَ}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DonationAmountCubit extends Cubit<String> {
  DonationAmountCubit() : super('');

  void selectAmount(String amount) {
    emit(amount);
  }
}

class DescriptionCubit extends Cubit<bool> {
  DescriptionCubit() : super(false);

  void toggle() => emit(!state);
}
