import 'package:charity_app/auth/presentation/widgets/auth_button.dart';
import 'package:charity_app/constants/image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/voluntary/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});
  TextEditingController bankAccountCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          backgroundColor: colorScheme.surface,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          title: Text(
            "المحفظة",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: colorScheme.surface,
        body: ListView(
          children: [
            SizedBox(
                width: double.infinity,
                height: size.height * 0.44,
                child: walletImage),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.warning,
                  color: colorScheme.secondary,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  r" رصيدك الحالي : 500$",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Customtextfields(
                      hint: "رقم حساب البنك",
                      inputType: TextInputType.number,
                      mycontroller: bankAccountCtrl,
                      valid: (value) {
                        return null;
                      }),
                  const SizedBox(
                    height: 13,
                  ),
                  Customtextfields(
                      hint: "المبلغ المراد شحنه",
                      inputType: TextInputType.number,
                      mycontroller: bankAccountCtrl,
                      valid: (value) {
                        return null;
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Authbutton(
                  buttonText: "تأكيد",
                  onPressed: () {},
                  color: colorScheme.secondary),
            )
          ],
        ),
      ),
    );
  }
}
