import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/container_fields.dart';
import 'package:flutter/material.dart';

class VolunteeringFields extends StatelessWidget {
  const VolunteeringFields({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(
          title: "مجالات التطوع",
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ContainerFields(
                      image: healthCare,
                      text: 'طبي',
                      buttomtext: "فرص التطوع",
                      onPressed: () {
                        Navigator.pushNamed(context, "HealtcareProjects");
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ContainerFields(
                      image: learning,
                      text: 'تعليمي',
                      buttomtext: "فرص التطوع",
                      onPressed: () {
                        Navigator.pushNamed(context, "LearningProject");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ContainerFields(
                      image: globalNetwork,
                      text: 'عن بُعد',
                      buttomtext: "فرص التطوع",
                      onPressed: () {
                        Navigator.pushNamed(context, "GlobalnetworkProjects");
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ContainerFields(
                      image: hand,
                      text: 'ميداني',
                      buttomtext: "فرص التطوع",
                      onPressed: () {
                        Navigator.pushNamed(context, "OnSiteProjects");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
