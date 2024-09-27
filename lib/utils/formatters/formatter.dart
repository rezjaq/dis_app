class DisFormatter {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 12) {
      return phoneNumber;
    } else {
      if (phoneNumber.startsWith('+62')) {
        phoneNumber = phoneNumber.replaceFirst('+62', '0');
      }
      if (phoneNumber.startsWith('62')) {
        phoneNumber = phoneNumber.replaceFirst('62', '0');
      }
      return phoneNumber;
    }
  }
}