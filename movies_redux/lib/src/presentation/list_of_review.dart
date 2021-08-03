import 'package:flutter/material.dart';
import 'package:movies_redux/src/container/reviews_container.dart';
import 'package:movies_redux/src/models/index.dart';

class ListOfReview extends StatelessWidget {
  const ListOfReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ReviewsContainer(builder: (BuildContext context, List<Review> reviews) {
              return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Review review = reviews[index];
                    return ListTile(
                      title: Text(review.comment),
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
