abstract class JoinToProjectStates {}

class JoinToProjectInit extends JoinToProjectStates {}

class JoinToProjectSuccess extends JoinToProjectStates {}

class JoinToProjectLoding extends JoinToProjectStates {}

//اريدي  متطوع
class JoinToProjectAlreadyApplied extends JoinToProjectStates {}
// حالة انو مو مسجل
class JoinToProjectNoSurvey extends JoinToProjectStates {}
//مسجل بس طلبو قيد الدراسة
class JoinToProjectPendingApproval extends JoinToProjectStates {}
//المتطوع محظور
class JoinToProjectBlocked extends JoinToProjectStates {}
//طلب التطوع انرفض 
class JoinToProjectRejected extends JoinToProjectStates {}

//للاحتياط خخ
class JoinToProjectFailure extends JoinToProjectStates {}
