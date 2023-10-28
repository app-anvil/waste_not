/// Flavor to distinguish the running environment.
enum Flavor {
  /// Dev
  dev,

  /// Staging
  stg,

  /// Production
  prod;

  /// Returns the corresponding string value of the [Flavor].
  String get value {
    switch (this) {
      case dev:
        return 'dev';
      case stg:
        return 'staging';
      case prod:
        return 'prod';
    }
  }

  /// Returns if the flavor have to be shown or not.
  bool get show => this != prod;
}
