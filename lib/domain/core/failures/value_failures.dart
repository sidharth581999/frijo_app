/// Represents validation failures for values
class ValueFailure<T> {
  final String errorMsg;

  ValueFailure._(this.errorMsg);

  /// Factory for invalid value
  factory ValueFailure.invalidValue(String errorMsg) {
    return ValueFailure._(errorMsg);
  }

  @override
  String toString() => 'ValueFailure.invalidValue(errorMsg: $errorMsg)';
}
