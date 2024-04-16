import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: Cambiar cuando este listo el endpoint cambiar info
final pictogramsProvider =
    StateNotifierProvider<PictogramsNotifier, PictogramsStatus>((ref) {
  //final patientRepository = PatientsRepositoryImp();
  return PictogramsNotifier();
});

typedef PictogramsCallBack = Future<List<String>> Function({
  required int idChild,
  required int indexPage,
  required String typePicto,
});

class PictogramsNotifier extends StateNotifier<PictogramsStatus> {
  final PictogramsCallBack? morePictograms;

  PictogramsNotifier({
    this.morePictograms,
  }) : super(PictogramsStatus());

  Future<void> loadMorePictograms() async {
    state.indexPage++;
    final List<String> pictograms = await morePictograms!(
        indexPage: state.indexPage,
        typePicto: state.typePicto!,
        idChild: state.idChild);
    state.listPictograms = [...state.listPictograms, ...pictograms];

    //state.lastPage = valorRespuesta; TODO : Cambiar cuando ya este el endpoint
  }

  void resetFilter() {
    state = state.copyWith(namePicto: '', typePicto: '');
  }

  void onNamePictoChange(String value) {
    final newNamePicto = value;
    state = state.copyWith(namePicto: newNamePicto);
  }

  void onTypePictoChange(String value) {
    final newTypePicto = value;
    state = state.copyWith(typePicto: newTypePicto);
  }
}

class PictogramsStatus {
  List<String> listPictograms;
  int indexPage;
  int lastPage;
  int idChild;
  String? typePicto;
  String namePicto;

  PictogramsStatus({
    this.listPictograms = const [],
    this.indexPage = 0,
    this.lastPage = 0,
    this.idChild = 0,
    this.typePicto,
    this.namePicto = '',
  });

  PictogramsStatus copyWith({
    List<String>? listPictograms,
    int? indexPage,
    int? lastPage,
    int? idChild,
    String? typePicto,
    String? namePicto,
  }) =>
      PictogramsStatus(
          listPictograms: listPictograms ?? this.listPictograms,
          indexPage: indexPage ?? this.indexPage,
          lastPage: lastPage ?? this.lastPage,
          idChild: idChild ?? this.idChild,
          namePicto: namePicto ?? this.namePicto,
          typePicto: typePicto == '' ? null : typePicto ?? this.typePicto);
}
