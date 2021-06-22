extension StringExt on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isNumeric(){
    return double.tryParse(this) != null;
  }

  bool isNotNullOrEmpty() => this != null && this.isNotEmpty;

  bool isNullOrEmpty() => this == null || this.isEmpty;

}
