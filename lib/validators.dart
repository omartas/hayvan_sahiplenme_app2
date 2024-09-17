class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen adınızı girin';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Lütfen geçerli bir isim girin';
    }
    return null; // Hata yoksa null döndürülür
  }

  static String? registerValidatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen telefon numaranızı girin';
    }
    if (value.length != 10) {
      return 'Telefon numarası 10 haneli olmalıdır';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Lütfen geçerli bir telefon numarası girin';
    }
    return null;
  }

  static String? registerValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen e-posta adresinizi girin';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Lütfen geçerli bir e-posta adresi girin';
    }
    return null;
  }
  // Adres Doğrulama
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir adres giriniz.';
    }
    if (value.length < 10) {
      return 'Adres en az 10 karakter uzunluğunda olmalıdır.';
    }
    if (!_containsAlphanumeric(value)) {
      return 'Adres geçersiz karakterler içeriyor.';
    }
    return null; // Geçerli adres
  }

  // Alfanumerik karakter içerip içermediğini kontrol eden yardımcı fonksiyon
  static bool _containsAlphanumeric(String value) {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9\s,.-]+$');
    return alphanumeric.hasMatch(value);
  }

  static String? registerValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir şifre girin';
    }
    if (!validatePassword(value)) {
      return 'Şifre en az 6 karakter uzunluğunda, \nbüyük harf, küçük harf, sayı ve özel karakter içermelidir';
    }
    return null;
  }

  static String? registerValidateConfirmPassword(
      String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifrenizi tekrar girin ';
    }
    if (password != value) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  static String? registerValidateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir İl Seçin';
    }
    return null;
  }

  static String? registerValidateDistict(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir İlçe Seçin';
    }
    return null;
  }

  static String? loginrValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen e-posta adresinizi girin';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Lütfen geçerli bir e-posta adresi girin';
    }
    return null;
  }

  static String? loginValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir şifre girin';
    }
    return null;
  }

  static String? forgotPasswordValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen e-posta adresinizi girin';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Lütfen geçerli bir e-posta adresi girin';
    }
    return null;
  }

  static String? adoptValidateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir Tutar Seçin';
    }
    return null;
  }

  static String? donateValidateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir Tutar Seçin';
    }
    return null;
  }

  static String? validateTCKimlik(String? value) {
    if (value == null || value.isEmpty) {
      return 'TC Kimlik Numarası boş olamaz';
    }

    if (value.length != 11) {
      return 'TC Kimlik Numarası 11 haneli olmalıdır';
    }

    if (!RegExp(r'^[1-9][0-9]{10}$').hasMatch(value)) {
      return 'Geçersiz TC Kimlik Numarası';
    }

    int sumOdd = 0;
    int sumEven = 0;
    for (int i = 0; i < 9; i += 2) {
      sumOdd += int.parse(value[i]);
    }
    for (int i = 1; i < 8; i += 2) {
      sumEven += int.parse(value[i]);
    }

    int tenthDigit = ((sumOdd * 7) - sumEven) % 10;
    if (tenthDigit != int.parse(value[9])) {
      return 'Geçersiz TC Kimlik Numarası';
    }

    int sumAll = 0;
    for (int i = 0; i < 10; i++) {
      sumAll += int.parse(value[i]);
    }

    if (sumAll % 10 != int.parse(value[10])) {
      return 'Geçersiz TC Kimlik Numarası';
    }

    return null; // Geçerli TC Kimlik Numarası
  }

  // T.C. Kimlik Numarası Doğrulama
  static bool _validateTCKimlik(String tckn) {
    if (tckn.length != 11 || int.tryParse(tckn) == null || tckn[0] == '0') {
      return false;
    }
    List<int> digits = tckn.split('').map((e) => int.parse(e)).toList();

    int sumOdd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    int sumEven = digits[1] + digits[3] + digits[5] + digits[7];

    int digit10 = ((7 * sumOdd - sumEven) % 10).abs();
    int digit11 = (sumOdd + sumEven + digits[9]) % 10;

    return (digit10 == digits[9]) && (digit11 == digits[10]);
  }

  // Vergi Numarası Doğrulama
  static bool _validateVergiNo(String vergiNo) {
    if (vergiNo.length != 10 || int.tryParse(vergiNo) == null) {
      return false;
    }
    List<int> digits = vergiNo.split('').map((e) => int.parse(e)).toList();
    List<int> multipliers = [9, 8, 7, 6, 5, 4, 3, 2, 1];
    int sum = 0;

    for (int i = 0; i < 9; i++) {
      sum += (digits[i] * multipliers[i]) % 11;
    }
    int remainder = sum % 11;
    remainder = remainder == 10 ? 0 : remainder;

    return remainder == digits[9];
  }

  // T.C. Kimlik Numarası veya Vergi Numarası Doğrulayıcı
  static String? validateTcOrVergiNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen T.C. Kimlik No veya Vergi No girin.';
    }

    if (value.length == 11 && _validateTCKimlik(value)) {
      return null; // Geçerli T.C. Kimlik No
    }

    if (value.length == 10 && _validateVergiNo(value)) {
      return null; // Geçerli Vergi No
    }

    return 'Geçersiz T.C. Kimlik No veya Vergi No.';
  }
}

bool validatePassword(String password) {
  // Şifrenin en az 6 karakter uzunluğunda olup olmadığını kontrol et
  if (password.length < 6) return false;

  // Şifrede en az bir büyük harf var mı kontrol et
  if (!password.contains(RegExp(r'[A-Z]'))) return false;

  // Şifrede en az bir küçük harf var mı kontrol et
  if (!password.contains(RegExp(r'[a-z]'))) return false;

  // Şifrede en az bir sayı var mı kontrol et
  if (!password.contains(RegExp(r'[0-9]'))) return false;

  // Şifrede en az bir özel karakter var mı kontrol et
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;

  return true;
}
