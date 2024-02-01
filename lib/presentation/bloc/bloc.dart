import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_test_task/data/network/api_work.dart';
import 'package:jwt_test_task/data/tools/tool_navigator.dart';
import 'package:jwt_test_task/data/tools/tool_show_toast.dart';
import 'package:jwt_test_task/presentation/authorized_screen.dart';

class LaunchBloc extends Bloc<LaunchBlocEvent, LaunchBlocState> {
  LaunchBloc()
      : super(LaunchBlocState(
          screenMod: LaunchScreenMod.start,
          userCode: '',
          userEmail: '',
          codeSent: false,
        )) {
    on<ChangeScreenModEvent>((event, emit) {
      emit(state.copyWith(screenMod: event.screenMod));
    });
    on<ConfirmUserEmailEvent>((event, emit) async {
      if (event.userEmail.trim() == '') {
        ToolShowToast.showError('Email is empty');
        return;
      }
      if (await ApiWork().requestCodeByEmail(user_email: event.userEmail)) {
        emit(state.copyWith(codeSent: true, userEmail: event.userEmail));
      }
      ;
    });
    on<ConfirmSecretCodeEvent>((event, emit) async {
      if (event.secretCode.trim() == '') {
        ToolShowToast.showError('Code is empty');
        return;
      }
      if (await ApiWork().requestJWTbyCode(code: event.secretCode, user_email: state.userEmail)) {
        ToolNavigator.set(AuthorizedScreen());
      }
    });
  }
}

enum LaunchScreenMod {
  start,
  singUp;
}

class LaunchBlocState {
  LaunchScreenMod screenMod;
  String userEmail;
  String userCode;
  bool codeSent;

  LaunchBlocState({
    required this.screenMod,
    required this.userEmail,
    required this.userCode,
    required this.codeSent,
  });

  LaunchBlocState copyWith({
    LaunchScreenMod? screenMod,
    String? userEmail,
    String? userCode,
    bool? codeSent,
  }) {
    return LaunchBlocState(
      screenMod: screenMod ?? this.screenMod,
      userEmail: userEmail ?? this.userEmail,
      userCode: userCode ?? this.userCode,
      codeSent: codeSent ?? this.codeSent,
    );
  }
}

class LaunchBlocEvent {}

class ChangeScreenModEvent extends LaunchBlocEvent {
  LaunchScreenMod screenMod;
  ChangeScreenModEvent(this.screenMod);
}

class ConfirmUserEmailEvent extends LaunchBlocEvent {
  String userEmail;
  ConfirmUserEmailEvent({
    required this.userEmail,
  });
}

class ConfirmSecretCodeEvent extends LaunchBlocEvent {
  String secretCode;
  ConfirmSecretCodeEvent({
    required this.secretCode,
  });
}
