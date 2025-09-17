/// Represents main failures (like custom or generic errors)
class MainFailure {
  final String errorMsg;
  final FailureKind kind;

  const MainFailure._({
    required this.errorMsg,
    required this.kind,
  });

  /// Factory for custom error
  factory MainFailure.customError({required String errorMsg}) {
    return MainFailure._(
      errorMsg: errorMsg,
      kind: FailureKind.customError,
    );
  }

  /// Factory for generic error
  factory MainFailure.genericError({required String errorMsg}) {
    return MainFailure._(
      errorMsg: errorMsg,
      kind: FailureKind.genericError,
    );
  }

  /// Helper getters
  bool get isCustom => kind == FailureKind.customError;
  bool get isGeneric => kind == FailureKind.genericError;

  @override
  String toString() => 'MainFailure(kind: $kind, errorMsg: $errorMsg)';
}

/// Enum to define failure types
enum FailureKind {
  customError,
  genericError,
}
