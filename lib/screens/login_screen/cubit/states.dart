abstract class LoginStates{}
class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{}

class ChangePasswordVisibilityState extends LoginStates{}
class ChangeCheckBoxState extends LoginStates{}
class SetNationalController extends LoginStates{}
class SetPasswordController extends LoginStates{}
