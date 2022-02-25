import 'package:flutter/widgets.dart';
import 'package:motokar/models/rating.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  static final RatingService _instance = RatingService._constructor();
  factory RatingService() {
    return _instance;
  }

  RatingService._constructor();

  final CollectionReference _ratingsRef =
      FirebaseFirestore.instance.collection('ratings');

  Future<Rating> getRating({String id}) async {
    final json = await Rest.get('ratings/$id');
    return Rating.fromJson(json);
  }

  Future<List<Rating>> getRatings() async {
    final jsonList = await Rest.get('ratings');
    final ratingList = <Rating>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Rating rating = Rating.fromJson(json);
        ratingList.add(rating);
      }
    }

    return ratingList;
  }

  Future createRating(Rating rating) async {
    await Rest.post(
      'ratings/',
      data: {
        'profileId': rating.profileId,
        'vehicleId': rating.vehicleId,
        'rate': rating.rate
      },
    );
  }
}
