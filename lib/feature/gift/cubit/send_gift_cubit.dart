import 'package:charity_app/feature/gift/cubit/send_gift_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class SendGiftCubit extends Cubit<SendGiftStates> {
  SendGiftCubit() : super(SendGiftinitial());
  // ignore: non_constant_identifier_names
  Future<void> sendGift(
      {required nameController,
      required phoneController,
      required moneyController}) async {
    emit(SendGiftLoading());
    // final token = sharedPreferences.get('token');
    try {
      final response = await Api().post(
          url: "http://$localhost/api/donor/giveGift",
          body: {
            "beneficiary_name": nameController.text,
            "phone_number": phoneController.text,
            "amount": moneyController.text,
          },
          token: "$token");
      if (response["message"] ==
          "لا يوجد لديك رصيد كافي للقيام بهذه العملية، الرجاء شحن المحفظة والمحاولة مرة أخرى") {
        emit(Insufficientbalance());
      }
      if (response["message"] == "تم الإهداء بنجsاح، شكراً لك!") {
        emit(SendGiftSuccess());
      }
      //  if(response["message"]=="لقد حدث خطأ! يبدو أن هذا المحتاج غير مسجل لدينا في التطبيق، يمكنك دعوته للتسجيل على صفحة الويب الخاصة بنا") {
      //   emit(SendGiftFailure());
      // }
    } catch (ex) {
      emit(SendGiftFailure());
    }
  }
}
