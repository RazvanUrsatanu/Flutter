part of actions;

@freezed
class GetReviews with _$GetReviews implements AppAction {
  const factory GetReviews() = GetReviewsStart;

  const factory GetReviews.successful(List<Review> reviews) = GetReviewsSuccessful;

  @Implements(ErrorAction)
  const factory GetReviews.error(Object error, StackTrace stackTrace) = GetReviewsError;
}
