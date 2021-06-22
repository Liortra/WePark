abstract class WeParkExceptions extends ArgumentError{
  final String message;

  WeParkExceptions({this.message}){
    print("~~~~~~~~~~~ WeParkExceptions: something went wrong error: $message ");
  }
}


class UserNotExistsInCache extends WeParkExceptions {
  UserNotExistsInCache({String message}):super(message: message);
}

class LocationErrorException extends WeParkExceptions {
  LocationErrorException({String message}):super(message: message);
}