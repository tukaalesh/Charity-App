import 'package:charity_app/feature/gift/cubit/send_gift_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendGiftCubit extends Cubit<SendGiftStates> {
  SendGiftCubit() : super(SendGiftinitial());
  Future<void> sendGift({
    required nameController,
    required phoneController,
    required moneyController,
  }) async {
    emit(SendGiftLoading());

    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().post(
        url: "$baseUrl/api/donor/giveGift",
        body: {
          "beneficiary_name": nameController.text,
          "phone_number": phoneController.text,
          "amount": moneyController.text,
        },
        token: "$token",
      );

      final message = response["message"]?.toString() ?? '';

      if (message.contains("الرصيد")) {
        emit(InsufficientBalance());
        return;
      }

      if (message.contains("المحتاج")) {
        emit(UnregisteredBeneficiary());
        return;
      }

      emit(SendGiftSuccess());
    } catch (e) {
      final error = e.toString();

      if (error.contains('422')) {
        emit(InsufficientBalance());
        return;
      }

      if (error.contains('404')) {
        emit(UnregisteredBeneficiary());
        return;
      }

      emit(SendGiftFailure());
    }
  }
}
