abstract class RechargeStates {}

class RechargeInitialState extends RechargeStates{}
class RechargeStartState extends RechargeStates{}
class ChangeSelectedState extends RechargeStates{}
class ChangeContentState extends RechargeStates{}

class RechargeLoadingState extends RechargeStates{}
class RechargeSuccessState extends RechargeStates{}
class RechargeErrorState extends RechargeStates{}