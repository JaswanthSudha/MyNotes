//login  exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthExcepton implements Exception {}

//register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUsedAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generice Exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
