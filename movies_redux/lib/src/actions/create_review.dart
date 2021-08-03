part of actions;

@freezed
class CreateReview with _$CreateReview implements AppAction {
  const factory CreateReview(String comment) = CreateReviewStart;

  const factory CreateReview.successful() = CreateReviewSuccessful;

  @Implements(ErrorAction)
  const factory CreateReview.error(Object error, StackTrace stackTrace) = CreateReviewError;
}

