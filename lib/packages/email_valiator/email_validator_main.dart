import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class EmailValidatorMain extends StatefulWidget {
  @override
  _EmailValidatorMainState createState() => _EmailValidatorMainState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _EmailValidatorMainState extends State<EmailValidatorMain> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final bool isValid = EmailValidator.validate(myController.text);
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(isValid ? 'Email is valid.' : 'Email is not valid.'),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}