bool isValidName(String name) {
  return name.isEmpty ||
      RegExp(r'[0-9!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(name);
}

bool isValidAge(String age) {
  return age.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(age);
}

bool isValidCpf(String cpf) {
  return cpf.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(cpf);
}

bool isValidRa(String ra) {
  return ra.isEmpty ||
      RegExp(r'[a-z!@#\$%^&*()_+={}\[\]:;<>,.?~\\/\|°]').hasMatch(ra);
}

bool isValidAvatar(String avatar) {
  return avatar.isEmpty;
}

bool isValidEmail(String email) {
  return email.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
}

bool isValidPassword(String password) {
  return password.isEmpty;
}
