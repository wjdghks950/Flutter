import 'package:flutter/material.dart';

void main() => runApp(FormDemo());

class FormDemo extends StatelessWidget{
  final appName = 'Form Validation demo';
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: appName,
      home: Scaffold(
        appBar:AppBar(
          title: Text(appName),
        ),
      body:FormDemoWidget(),
      ),
    );
  }
}

class FormDemoWidget extends StatefulWidget{
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormDemoWidget>{
  // create a global key that will uniquely identify the Form widget
  // and allow us to validate the form

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build (BuildContext context){
    // Build a Form widget with the `_formKey` created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value){
              if (value.isEmpty){
                return 'Please enter some text';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: (){
                if(_formKey.currentState.validate()){
                  // If the form (i.e. email entered) is valid, we show a SnackBar
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            )
          )
        ],
      ),
    );
  }
}