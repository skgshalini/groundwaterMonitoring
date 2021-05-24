import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groundwater_monitoring/components/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groundwater_monitoring/components/customdialog.dart';
import '../constants.dart';
import 'NavigationPage.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_STATE,
}

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  bool showLoading = false;
  String phoneNo;
  String smsOTP;
  String errorMessage = '';
  FocusNode focusNode = FocusNode();
  String hintText = 'Enter phone number';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      }
      setState(() {});
    });
  }

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {
        showLoading = false;
        currentState = MobileVerificationState.SHOW_OTP_STATE;
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 0),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('{$exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  handleError(error) {
    Navigator.of(context).pop();
    print(error);
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Error",
        description: error.message,
        buttonText: "Okay",
      ),
    );
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.pushNamed(context, NavigationScreen.id);
    } on PlatformException catch (err) {
      // Handle err
      handleError(err);
    } catch (e) {
      handleError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: showLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: currentState ==
                        MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context)),
      ),
    );
  }

  getMobileFormWidget(context) {
    return <Widget>[
      Column(
        children: [
          Container(
            height: 150,
            child: Image.asset('images/water.png'),
          ),
          TextField(
            focusNode: focusNode,
            onChanged: (value) {
              phoneNo = '+91' + value;
            },
            decoration: kTextFieldDecoration.copyWith(
                hintText: hintText, prefixText: '+91'),
          ),
          RoundedButton(
              onPressed: () async {
                print(phoneNo);
                setState(() {
                  showLoading = true;
                });
                verifyPhone();
              },
              colour: Colors.black,
              title: 'Send'),
        ],
      ),
    ];
  }

  getOtpFormWidget(context) {
    return <Widget>[
      Column(
        children: [
          Container(
            height: 150,
            child: Image.asset('images/water.png'),
          ),
          TextField(
            onChanged: (value) {
              smsOTP = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter the OTP'),
          ),
          RoundedButton(
              onPressed: () async {
                setState(() {
                  showLoading = true;
                });

                signIn();
              },
              colour: Colors.black,
              title: 'Verify'),
        ],
      ),
    ];
  }
}
