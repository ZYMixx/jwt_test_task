import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_test_task/data/network/api_work.dart';
import 'package:jwt_test_task/data/tools/tool_navigator.dart';
import 'package:jwt_test_task/presentation/authorized_screen.dart';
import 'package:jwt_test_task/presentation/my_widgets/my_launch_button.dart';
import 'package:jwt_test_task/presentation/my_widgets/my_text_input_field.dart';

import 'bloc/bloc.dart';
import 'my_widgets/my_launch_bg_widget.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF1E1E24),
      body: FutureBuilder(
          future: ApiWork().authenticateUserWithJWT(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                children: [
                  MyLaunchBGWidget(),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.hasError || snapshot.data == false) {
              return BlocProvider(
                create: (_) {
                  return LaunchBloc();
                },
                child: Stack(
                  children: [
                    MyLaunchBGWidget(),
                    UserInputBox(),
                  ],
                ),
              );
            } else {
              return AuthorizedScreen();
            }
          }),
    );
  }
}

class UserInputBox extends StatefulWidget {
  const UserInputBox({Key? key}) : super(key: key);

  @override
  State<UserInputBox> createState() => _UserInputBoxState();
}

class _UserInputBoxState extends State<UserInputBox> {
  @override
  Widget build(BuildContext context) {
    var screenMod = context.select((LaunchBloc bloc) => bloc.state.screenMod);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: buildBoxTitle(screenMod),
          ),
        ),
        Flexible(
          flex: 7,
          child: AnimatedContainer(
            curve: Curves.easeInSine,
            duration: Duration(milliseconds: 400),
            width: double.infinity,
            height: screenMod == LaunchScreenMod.start ? 350 : 500,
            decoration: ShapeDecoration(
              color: Color(0xFFBFCDE0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
              ),
            ),
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeOutCubic,
              duration: Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: buildBoxContent(screenMod),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBoxTitle(LaunchScreenMod screenMod) {
    switch (screenMod) {
      case LaunchScreenMod.start:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo_aveds.svg',
                width: 60,
                height: 60,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Помогаем развитию ваших бизнес-целей',
                style: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 40),
            ],
          ),
        );
      case LaunchScreenMod.singUp:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              'Please enter your email to create account',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        );
    }
  }

  Widget buildBoxContent(LaunchScreenMod screenMod) {
    switch (screenMod) {
      case LaunchScreenMod.start:
        return LaunchStartBox();
      case LaunchScreenMod.singUp:
        return LaunchSingUpBox();
    }
  }
}

class LaunchStartBox extends StatelessWidget {
  const LaunchStartBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LaunchBloc bloc = context.select((LaunchBloc bloc) => bloc);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              color: Color(0xFF26203A),
              fontSize: 45,
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          Column(
            children: [
              MyLaunchButton(
                text: 'Sign in',
                textColor: Colors.white,
                callBack: () {},
                color: Color(0xFF3B3355),
              ),
              SizedBox(height: 15),
              MyLaunchButton(
                text: 'Sign up',
                callBack: () {
                  bloc.add(ChangeScreenModEvent(LaunchScreenMod.singUp));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LaunchSingUpBox extends StatefulWidget {
  LaunchSingUpBox({Key? key}) : super(key: key);

  @override
  State<LaunchSingUpBox> createState() => _LaunchSingUpBoxState();
}

class _LaunchSingUpBoxState extends State<LaunchSingUpBox> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerCode;

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerCode = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    LaunchBloc bloc = context.select((LaunchBloc bloc) => bloc);
    bool codeSent = context.select((LaunchBloc bloc) => bloc.state.codeSent);
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 9),
              MyTextInputField(
                hintText: 'Email',
                controller: controllerEmail,
              ),
              AnimatedSwitcher(
                switchOutCurve: Curves.slowMiddle,
                duration: Duration(milliseconds: 400),
                child: codeSent
                    ? Column(
                        children: [
                          SizedBox(height: 9),
                          MyTextInputField(
                            hintText: 'Code',
                            controller: controllerCode,
                          ),
                        ],
                      )
                    : null,
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                ),
              ),
              SizedBox(height: 15),
              if (!codeSent)
                MyLaunchButton(
                  text: 'Send Code',
                  callBack: () {
                    bloc.add(ConfirmUserEmailEvent(userEmail: controllerEmail.text.trim()));
                  },
                  color: Color(0xFF26203A),
                  textColor: Colors.white,
                ),
              if (codeSent)
                MyLaunchButton(
                  text: 'Sing In',
                  callBack: () {
                    bloc.add(ConfirmSecretCodeEvent(secretCode: controllerCode.text.trim()));
                  },
                  color: Color(0xFF26203A),
                  textColor: Colors.white,
                ),
              SizedBox(height: 15),
              Divider(
                height: 2,
                color: Color(0xFF26203A),
              ),
              SizedBox(height: 15),
              MyLaunchButton(
                  text: 'Continue with Google',
                  iconPath: 'assets/google_logo.png',
                  callBack: () {
                    bloc.add(ChangeScreenModEvent(LaunchScreenMod.start));
                  }),
              SizedBox(height: 10),
              MyLaunchButton(
                text: 'Continue with meta',
                iconPath: 'assets/meta_logo.png',
                callBack: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
