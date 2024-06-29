abstract class TransferStates {}

class TransferInitialState extends TransferStates{}
class ChangeContentState extends TransferStates{}

class TransferLoadingState extends TransferStates{}
class TransferSuccessState extends TransferStates{}
class TransferErrorState extends TransferStates{}
class ChangeDropDown extends TransferStates{}