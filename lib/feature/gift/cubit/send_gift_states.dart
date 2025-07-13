abstract class SendGiftStates {}

class SendGiftinitial extends SendGiftStates {}

class SendGiftLoading extends SendGiftStates {}

class SendGiftSuccess extends SendGiftStates {}
//المحتاج مو مسجل بالتطبيق
class UnregisteredBeneficiary extends SendGiftStates{}

class SendGiftFailure extends SendGiftStates {}
//الرصيد غير كافي
class InsufficientBalance extends SendGiftStates {}
