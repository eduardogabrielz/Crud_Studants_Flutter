bool isValidName(String name) {
  return name.isEmpty ||
      RegExp(r'[0-9!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(name);
}

bool isValidAge(String age) {
  return age.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(age) ||
      age.length > 2;
}

bool isValidCpf(String cpf) {
  return cpf.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(cpf) ||
      cpf.length < 11;
}

bool isValidRa(String ra) {
  return ra.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(ra) ||
      ra.length < 5;
}

bool isValidAvatar(String avatar) {
  return avatar.isEmpty;
}
