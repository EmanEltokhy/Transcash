abstract class DonationStates {}

class DonationInitialState extends DonationStates{}
class DonationStartState extends DonationStates{}
class ChangeSelectedState extends DonationStates{}
class ChangeContentState extends DonationStates{}

class DonationLoadingState extends DonationStates{}
class DonationSuccessState extends DonationStates{}
class DonationErrorState extends DonationStates{}