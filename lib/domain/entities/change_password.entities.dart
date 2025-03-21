class ChangePassword {
  String password;
  String newPassword;
  String confirmNewPassword;

  ChangePassword({
    required this.password,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  ChangePassword copyWith({
    String? password,
    String? newPassword,
    String? confirmNewPassword,
  }) =>
      ChangePassword(
        password: password ?? this.password,
        newPassword: newPassword ?? this.newPassword,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      );
}
