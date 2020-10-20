
String emailValidator(String value){
  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
    return 'Please provide a valid email';
  }
  return null;
}

String emptyValidator(String value,String label){
  return value.isEmpty ? 'Please provide $label' :null;
}

String phoneValidator(String value){
  if(value.isEmpty){
    return "Please provide phone number";
  }
  if(!value.contains('+')){
    return "Country code missing";
  }
  if(value.length<4){
    return "Phone number too short";
  }
  if(value.length>15){
    return "Phone number too long";
  }
  return null;
}

String passwordValidator(String value){
  return value.isEmpty ? 'Please provide password' : (value.length < 6) ? 'Password must be at least 6 characters' : null;
}