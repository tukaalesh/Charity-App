import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class PinCodeScreen extends StatelessWidget {
  PinCodeScreen({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    GlobalKey<FormState> fromKey = GlobalKey();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Form(
        key: fromKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: size.height * 0.55,
                child: pinCodeImage),
            const Center(
                child: Text('الرجاء إدخال رمز التحقق المرسل إلى رقم هاتفك')),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                cursorHeight: 24,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                enableActiveFill: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  borderRadius: BorderRadius.circular(8),
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: colorScheme.secondary,
                  inactiveColor: Colors.grey.shade200,
                  selectedColor: colorScheme
                      .secondary, //  يعني يلي عم اكتب فيه لون الحواف للحقل الفعال
                  errorBorderColor: Colors.redAccent,
                  fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Authbutton(
                  buttonText: "تأكيد",
                  onPressed: () {},
                  color: colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
