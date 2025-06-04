import 'package:charity_app/constants/image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/voluntary/presentation/widgets/container_fields.dart';
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
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          backgroundColor: colorScheme.surface,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          title: Text(
            "مجالات التطوع",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ContainerFields(
                      image: healthCare,
                      text: 'طبي',
                      buttomtext: "فرص التطوع",
                      buttomonTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ContainerFields(
                      image: training,
                      text: 'تعليمي',
                      buttomtext: "فرص التطوع",
                      buttomonTap: () {},
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
                      buttomonTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ContainerFields(
                      image: hand,
                      text: 'ميداني',
                      buttomtext: "فرص التطوع",
                      buttomonTap: () {},
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
