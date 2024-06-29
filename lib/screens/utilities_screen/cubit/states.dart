abstract class UtilitiesStates {}

class UtilitiesInitialState extends UtilitiesStates{}
class UtilitiesStartState extends UtilitiesStates{}
class ChangeSelectedState extends UtilitiesStates{}
class ChangeContentState extends UtilitiesStates{}

class UtilitiesLoadingState extends UtilitiesStates{}
class UtilitiesSuccessState extends UtilitiesStates{}
class UtilitiesErrorState extends UtilitiesStates{}

class BillLoadingState extends UtilitiesStates{}
class BillSuccessState extends UtilitiesStates{}
class BillErrorState extends UtilitiesStates{}

class DeleteLoadingState extends UtilitiesStates{}
class DeleteSuccessState extends UtilitiesStates{}
class DeleteErrorState extends UtilitiesStates{}
class ChangeDropDown extends UtilitiesStates{}