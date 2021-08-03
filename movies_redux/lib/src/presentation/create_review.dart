import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/models/index.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({Key? key}) : super(key: key);

  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final TextEditingController _review = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _review,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a review';
                }
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    if (!Form.of(context)!.validate()) {
                      return;
                    }

                    StoreProvider.of<AppState>(context).dispatch(CreateReview(_review.text));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
