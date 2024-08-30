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
