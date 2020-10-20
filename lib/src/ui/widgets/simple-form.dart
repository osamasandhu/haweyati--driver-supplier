import 'package:flutter/material.dart';

class SimpleForm extends StatefulWidget {
  final bool autoValidate;
  final Function onSubmit;
  final Widget child;

  SimpleForm({
    @required Key key,
    this.child,
    this.onSubmit,
    this.autoValidate
  }): super(key: key);

  @override
  SimpleFormState createState() => SimpleFormState();
}

class SimpleFormState extends State<SimpleForm> {
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _validate,
      child: widget.child
    );
  }

  void reset() => _formKey.currentState.reset();
  void submit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      FocusScope.of(context).requestFocus(FocusNode());
      widget.onSubmit();
    } else {
      if (!this._validate) setState(() => this._validate = true);
    }
  }
}
