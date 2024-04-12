import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';

final searchPatients = StateProvider<String>((ref) => '');

final patientsProvider =
    StateNotifierProvider<PatientsNotifier, PatientsStatus>((ref) {
  //final patientRepository = PatientsRepositoryImp(); Aqui iran todos los metodos referente a los pacientes
  return PatientsNotifier();
});

class PatientsNotifier extends StateNotifier<PatientsStatus> {
//final patientRepository = PatientsRepositoryImp(); Agregarlo a los parametros de la clase

  int page = 0;
  int totalPages = 10;
  int lastPage = 0;
  PatientsNotifier()
      : super(PatientsStatus(
            newPatients: [],
            totalPatients: [],
            lastPage: 0,
            indexPage: 0,
            pageCount: 0)) {
    _loadMorePatients();
  }

  // Método para cargar más pacientes
  Future<void> _loadMorePatients() async {
    await Future.delayed(const Duration(seconds: 1));
    // Aquí agregarías la lógica para cargar más pacientes, Por ahora, simplemente agregamos pacientes de ejemplo
    final newPatients = List.generate(
      10,
      (index) => Patient(
        id: '${state.totalPatients.length + index}',
        fullName: 'Maria de Concepcion Ramos Mejia',
        edad: '${20 + index}',
        fase: '${(state.totalPatients.length + index) % 3}',
      ),
    );

    // Agregamos los nuevos pacientes a la lista acumulativa
    state = state.copyWith(
      lastPage: lastPage, //Cambiar por la respuesta del endpoint
      pageCount: totalPages, //Cambiar por la respuesta del endpoint
      indexPage: page, //Cambiar por la respuesta del endpoint
      newPatients: newPatients,
      totalPatients: [...state.totalPatients, ...newPatients],
    );
    page++;
    lastPage = page;
  }

  void getPreviusPatients() {
    final indexPagina = state.indexPage - 1;
    if (indexPagina < 0) return;
    page--;
    _setState(indexPage: indexPagina);
  }

  void getNextPatients() {
    if (state.indexPage < state.lastPage) {
      _loadPatientsCache();
    } else {
      if (state.indexPage == state.pageCount) return;
      _loadMorePatients();
    }
  }

  void _loadPatientsCache() {
    final indexPagina = state.indexPage + 1;
    if (indexPagina > state.pageCount) return;
    page++;
    _setState(indexPage: indexPagina);
  }

  void _setState({required int indexPage}) {
    final itemsByPage = state.pageCount;
    final newPatients = state.totalPatients.sublist(
        indexPage * itemsByPage, (indexPage * itemsByPage) + itemsByPage);

    state = state.copyWith(
        indexPage: indexPage,
        newPatients: newPatients,
        lastPage: state.lastPage,
        pageCount: state.pageCount,
        totalPatients: state.totalPatients);
  }
}

class PatientsStatus {
  final List<Patient> newPatients;
  final List<Patient> totalPatients;
  final int indexPage;
  final int lastPage;
  final int pageCount;

  PatientsStatus({
    required this.newPatients,
    required this.totalPatients,
    required this.lastPage,
    required this.indexPage,
    required this.pageCount,
  });

  PatientsStatus copyWith(
          {required List<Patient> newPatients,
          required List<Patient> totalPatients,
          required int indexPage,
          required int pageCount,
          required int lastPage}) =>
      PatientsStatus(
          newPatients: newPatients,
          totalPatients: totalPatients,
          lastPage: lastPage,
          indexPage: indexPage,
          pageCount: pageCount);
}
