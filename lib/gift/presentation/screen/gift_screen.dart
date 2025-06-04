// ignore_for_file: avoid_print
import 'package:charity_app/auth/presentation/widgets/auth_button.dart';
import 'package:charity_app/auth/presentation/widgets/custom_text_field.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/gift/presentation/widget/button_out_line.dart';
import 'package:charity_app/voluntary/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GiftScreen extends StatelessWidget {
  GiftScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  GlobalKey<FormState> fromKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          title: const Text(
            'الهدية',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.arrow_back_ios),
        ),
        body: Form(
          key: fromKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 25.0, left: 5),
                child: Text(
                  'كل تبرع هو بصمة خير تترك أثرًا في حياة شخص قريب هنا، بإمكانك أن تكون مصدر الأمل والفرح لمن تحب',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text(
                  'بيانات المُهدى إليه ',
                  style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Customtextfields(
                    hint: "اسم المُهدى إليه",
                    inputType: TextInputType.name,
                    mycontroller: nameController,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return "اسم المُهدى إليه مطلوب";
                      }
                      return null;
                    }),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Customtextfields(
                    hint: "رقم المُهدى إليه",
                    inputType: TextInputType.number,
                    mycontroller: phoneController,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return "رقم المُهدى إليه مطلوب";
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, right: 25.0),
                child: Text(
                  "مبلغ التبرع",
                  style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  ButtonOutlined(
                    buttonText: r'100 $',
                    onPressed: () {
                      moneyController.text = "100";
                    },
                    borderColor: colorScheme.primary,
                    textColor: colorScheme.primary,
                  ),
                  ButtonOutlined(
                    buttonText: r'200 $',
                    onPressed: () {
                      moneyController.text = "200";
                    },
                    borderColor: colorScheme.primary,
                    textColor: colorScheme.primary,
                  ),
                  ButtonOutlined(
                    buttonText: r'300 $',
                    onPressed: () {
                      moneyController.text = "300";
                    },
                    borderColor: colorScheme.primary,
                    textColor: colorScheme.primary,
                  ),
                  ButtonOutlined(
                    buttonText: r'400 $',
                    onPressed: () {
                      moneyController.text = "400";
                    },
                    borderColor: colorScheme.primary,
                    textColor: colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Customtextfield(
                    hint: 'مبلغ التبرع',
                    icon: const Icon(Icons.attach_money),
                    inputType: TextInputType.number,
                    mycontroller: moneyController,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return "مبلغ التبرع مطلوب";
                      }
                      return null;
                    },
                    color: colorScheme.secondary),
              ),
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: Authbutton(
                    buttonText: "إرسال",
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {}
                      print('hi tuka alhiloeh');
                    },
                    color: colorScheme.secondary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
