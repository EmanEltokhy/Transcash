abstract class UserStates{}

class InitialState extends UserStates{}

class DataLoadingState extends UserStates{}
class DataSuccessState extends UserStates{}
class DataErrorState extends UserStates{}

class OverviewLoadingState extends UserStates{}
class OverviewSuccessState extends UserStates{}
class OverviewErrorState extends UserStates{}

class HistoryLoadingState extends UserStates{}
class HistorySuccessState extends UserStates{}
class HistoryErrorState extends UserStates{}

class RecommendedLoadingState extends UserStates{}
class RecommendedSuccessState extends UserStates{}
class RecommendedErrorState extends UserStates{}

class AddAccountLoadingState extends UserStates{}
class AddAccountSuccessState extends UserStates{}
class AddAccountErrorState extends UserStates{}

class ChangeIndex extends UserStates{}
class DashboardState extends UserStates{}
class HistoryState extends UserStates{}
class ChangeDropDown extends UserStates{}
class ChangeSelectedState extends UserStates{}
class ChangeDataState extends UserStates{}
class LogoutState extends UserStates{}
