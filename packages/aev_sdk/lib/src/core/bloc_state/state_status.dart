enum StateStatus {
  initial,
  progress,
  failure,
  success;

  bool get isInitial => this == initial;
  bool get isProgress => this == progress;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}
