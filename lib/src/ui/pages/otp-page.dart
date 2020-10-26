import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/no-scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/header-view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/waiting-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  OtpPage({this.phoneNumber});

  @override
  OtpPageState createState() => OtpPageState();
}

class _OtpField extends Container {
  _OtpField({
    String text,
  }): super(
      width: 30, height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Center(
        child: Text(text, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600
        )),
      )
  );
}

class OtpPageState extends State<OtpPage> {
  int resendToken;

  final _node = FocusNode();
  final _controller = TextEditingController();
  final _codes = List.filled(6, '', growable: false);

  static String verificationId;
  final _auth = FirebaseAuth.instance;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future verifyNumber(String inputNo, BuildContext context, resendToken) async{
    await _auth.verifyPhoneNumber(
        phoneNumber: inputNo,
        forceResendingToken: resendToken,
        codeAutoRetrievalTimeout: (String verID) {
          verificationId = verID;
        },
        codeSent: (String verID, [int forceCodeResend]) async {
          verificationId = verID;
          resendToken = forceCodeResend;
        },
        timeout: const Duration(minutes: 2),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.pop(context, true);
        },
        verificationFailed: (FirebaseAuthException exception){
          print('${exception.message}');
        }
    );
  }


  Future<bool> signInWithOTP(smsCode, verId) async {
    showDialog(
        context: context,
        builder: (context) => WaitingDialog(message :'Verifying OPT...')
    );

    // print('here');
    // print(verId);
    // print(verificationId);
    final credentials = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode
    );

    UserCredential result;

    try {
      result = await _auth.signInWithCredential(credentials);
    } catch (e) {
      Navigator.of(context).pop();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.message, style: TextStyle(color: Colors.white)),
      ));
    }
    if (result?.user != null) {
      Navigator.of(context).pop();

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    verifyNumber(widget.phoneNumber, context, resendToken);
  }

  @override
  Widget build(BuildContext context) {
    return NoScrollView(
      // key: _scaffoldKey,
      appBar: HaweyatiAppBar( hideHome: true),
      body: DottedBackgroundView(
        child: Column(children: [
          HeaderView(
            title: 'Verification',
            subtitle: 'Please type the verification code you received',
          ),

          RichText(text: TextSpan(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
              text: widget.phoneNumber,
              children: [TextSpan(
                  text: '  Change',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColor
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.of(context).pop();
                  }
              )]
          )),
          Container(
            width: 220,
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0,
                  child: TextFormField(
                    maxLength: 6,
                    maxLengthEnforced: true,
                    focusNode: _node,
                    controller: _controller,
                    onChanged: (val) {
                      final codes = val.split('');

                      for (var i = 0; i < _codes.length; ++i) {
                        if (i < codes.length) {
                          _codes[i] = codes[i];
                        } else {
                          _codes[i] = '';
                        }
                      }

                      setState(() {});
                      if (codes.length == 6) {
                        matchOtp();
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_node.hasFocus) {
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    } else {
                      _node.requestFocus();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(children: [
                      _OtpField(text: _codes[0]),
                      _OtpField(text: _codes[1]),
                      _OtpField(text: _codes[2]),
                      _OtpField(text: _codes[3]),
                      _OtpField(text: _codes[4]),
                      _OtpField(text: _codes[5]),
                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: _ResendTimer(onResend: () {
              verifyNumber(widget.phoneNumber, context, resendToken);
            }),
          )
        ]),
      ),
    );
  }

  void matchOtp() async {
    print(_controller.text);
    if (await signInWithOTP(_controller.text, verificationId)) {
      Navigator.of(context).pop(true);
    }
  }
}

class _ResendTimer extends StatefulWidget {
  final List<int> gaps;
  final Function onResend;

  _ResendTimer({this.gaps, this.onResend});

  @override
  __ResendTimerState createState() => __ResendTimerState();
}
class __ResendTimerState extends State<_ResendTimer> {
  var _allow = false;
  final _controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _startCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Text("Didn't receive a code?", style: TextStyle(
          color: Colors.grey.shade600
      )),
      SizedBox(height: 5),

      if (_allow)
        GestureDetector(
            onTap: () {
              widget.onResend();

              setState(() {
                _allow = false;
              });

              _startCounter();
            },
            child: Text('Resend Code', style: TextStyle(
                color: Theme.of(context).primaryColor
            ))
        )
      else
        StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Wait for ' + _buildTime(snapshot.data), style: TextStyle(
                  color: Theme.of(context).primaryColor
              ));
            } else {
              return Text('...');
            }
          },
        )
    ], direction: Axis.vertical, crossAxisAlignment: WrapCrossAlignment.center);
  }

  static _buildTime(int seconds) {
    final _seconds = seconds % 60;
    final _minutes = seconds ~/ 60;

    return _minutes.toString().padLeft(2, '0')
        + ':' + _seconds.toString().padLeft(2, '0');
  }

  void _startCounter() async {
    var len = 120;

    while (len >= 0) {
      if (_controller.isClosed) return;
      await Future.delayed(Duration(seconds: 1), () {
        if (_controller.isClosed) return;
        _controller.add(len--);
      });
    }

    setState(() { _allow = true; });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}