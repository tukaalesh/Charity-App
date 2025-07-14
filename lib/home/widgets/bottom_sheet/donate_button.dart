import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/cubit/project_cubit.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/feature/saved_project/cubit/saved_project_cubit.dart';
import 'package:charity_app/feature/saved_project/cubit/saved_project_state.dart';
import 'package:charity_app/home/cubits/button/donate_now_cubit.dart';
import 'package:charity_app/home/cubits/button/saved_button_cubit.dart';
import 'package:charity_app/home/cubits/donationCubit/modal_cubit.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ProjectModel project;

  const DonateButton({super.key, required this.formKey, required this.project});

  @override
  Widget build(BuildContext context) {
    final ColorScheme = context.colorScheme;
    return BlocBuilder<ModalCubit, String>(
      builder: (context, selectedAmount) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                final savedProjectsState =
                    context.read<SavedProjectsCubit>().state;
                bool alreadySaved = false;

                if (savedProjectsState is SavedProjectsLoaded) {
                  alreadySaved = savedProjectsState.projects
                      .any((p) => p.id == project.id);
                }

                if (alreadySaved) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(
                          child: Text(
                              'عذراً، تم إضافة هذا المشروع مسبقًا إلى المشاريع المحفوظة')),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                await context
                    .read<SavedButtonCubit>()
                    .addProjectToFavorites(project);
                final state = context.read<SavedButtonCubit>().state;

                if (state is FavoriteSuccess) {
                  await context.read<SavedProjectsCubit>().fetchSavedProjects();
                  Navigator.of(context).pop(true);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Center(
                          child: Text("تمت الإضافة إلى المشاريع المحفوظة")),
                      backgroundColor: ColorScheme.secondary,
                    ),
                  );
                } else if (state is FavoriteFailure) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text("حدث خطأ أثناء الحفظ")),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorScheme.secondary,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(120, 50),
              ),
              child: const Text(
                "إضافة إلى المشاريع المحفوظة",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            BlocConsumer<DonationButtonCubit, DonationButtonState>(
              listener: (context, state) {
                if (state is DonationButtonSuccess) {
                  Navigator.of(context).pop(true);

                  context.read<ProjectsCubit>().updateProject(
                        project.copyWith(
                          currentAmount: project.currentAmount +
                              (int.tryParse(context.read<ModalCubit>().state) ??
                                  0),
                        ),
                      );

                  final donatedAmount =
                      int.tryParse(context.read<ModalCubit>().state) ?? 0;

                  context.read<SavedProjectsCubit>().updateProjectAmount(
                        project.id,
                        donatedAmount,
                      );

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Center(child: Text("تم التبرع بنجاح")),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  });
                } else if (state is BalanceNotEnough) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(
                          child: Text(
                              "ليس لديك رصيد كافٍ لإتمام هذه العملية، الرجاء شحن المحفظة وإعادة المحاولة.")),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is DonationButtonFailure) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text("حدث خطأ أثناءالتبرع")),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is DonationLoading
                      ? null
                      : () {
                          if (formKey.currentState?.validate() ?? false) {
                            final selectedAmount = int.tryParse(
                              context.read<ModalCubit>().state,
                            );
                            if (selectedAmount != null) {
                              context
                                  .read<DonationButtonCubit>()
                                  .donateToProject(
                                    projectId: project.id,
                                    amount: selectedAmount,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('الرجاء اختيار مبلغ أولاً')),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: state is DonationLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "تبرّع الآن",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
