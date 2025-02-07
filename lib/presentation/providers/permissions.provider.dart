import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/entities/me.entities.dart';
import 'package:hope_app/infrastructure/mappers/me_permissions.mapper.dart';
import 'package:hope_app/infrastructure/repositories/key_value_storage.repository.impl.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(KeyValueStorageRepositoryImpl());
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  final KeyValueStorageRepositoryImpl _storageProfile;

  ProfileNotifier(this._storageProfile) : super(ProfileState());

  Future<void> loadProfileAndPermmisions() async {
    final storedPermissions =
        await _storageProfile.getValueStorage<List<String>>('permissions') ??
            [];

    final storedProfile =
        await _storageProfile.getValueStorage<String>('profile');

    final storedUserName =
        await _storageProfile.getValueStorage<String>('userName');

    final storedEmail = await _storageProfile.getValueStorage<String>('email');

    state = state.copyWith(
        userName: storedUserName,
        email: storedEmail,
        permmisions: storedPermissions,
        profile:
            MePermissionsMapper.fromJsonProfile(jsonDecode(storedProfile!)),
        isLoading: false);
  }

  void resetProfile() {
    state = ProfileState();
  }

  void updateBirthday(DateTime newDate) {
    if (state.profile == null) return; // Evita errores si profile es null
    state.profile!.birthday = "${newDate.year}-${newDate.month}-${newDate.day}";
  }
}

class ProfileState {
  final Profile? profile;
  final String? userName;
  final String? email;
  final List<String>? permmisions;
  final bool isLoading;

  ProfileState(
      {this.profile,
      this.userName,
      this.email,
      this.permmisions,
      this.isLoading = true});

  ProfileState copyWith(
          {Profile? profile,
          String? userName,
          String? email,
          bool? isLoading,
          List<String>? permmisions}) =>
      ProfileState(
          profile: profile ?? this.profile,
          userName: userName ?? this.userName,
          email: email ?? this.email,
          isLoading: isLoading ?? this.isLoading,
          permmisions: permmisions ?? this.permmisions);
}
