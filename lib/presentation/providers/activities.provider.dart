import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';

final searchNameActivity = StateProvider<String>((ref) => '');

final activitiesProvider =
    StateNotifierProvider<ActivitiesNotifier, ActivityStatus>((ref) {
  //final activityRepository = ActivityRepositoryImp(); Aqui iran todos los metodos referente a las actividades
  return ActivitiesNotifier();
});

class ActivitiesNotifier extends StateNotifier<ActivityStatus> {
//final activityRepository = PatientsRepositoryImp(); Agregarlo a los parametros de la clase

  int page = 0;
  int totalPages = 10;
  int lastPage = 0;
  ActivitiesNotifier()
      : super(ActivityStatus(
            newActivities: [],
            totalActivities: [],
            lastPage: 0,
            indexPage: 0,
            pageCount: 0)) {
    _loadMoreActivities();
  }

  // Método para cargar más actividades
  Future<void> _loadMoreActivities() async {
    await Future.delayed(const Duration(seconds: 1));
    // Aquí agregarías la lógica para cargar más acividades, Por ahora, simplemente agregamos actividades de ejemplo
    final newActivity = List.generate(
      10,
      (index) => Patient(
        id: '${state.totalActivities.length + index}',
        fullName: 'Formar oracion con animales',
        edad: '${20 + index}',
        fase: '${(state.totalActivities.length + index) % 3}',
      ),
    );

    // Agregamos las nuevas actividades a la lista acumulativa
    state = state.copyWith(
      lastPage: lastPage, //Cambiar por la respuesta del endpoint
      pageCount: totalPages, //Cambiar por la respuesta del endpoint
      indexPage: page, //Cambiar por la respuesta del endpoint
      newActivities: newActivity,
      totalActivities: [...state.totalActivities, ...newActivity],
    );
    page++;
    lastPage = page;
  }

  void getPreviusActivities() {
    final indexPagina = state.indexPage - 1;
    if (indexPagina < 0) return;
    page--;
    _setState(indexPage: indexPagina);
  }

  void getNextActivities() {
    if (state.indexPage < state.lastPage) {
      _loadActivitiesCache();
    } else {
      if (state.indexPage == state.pageCount) return;
      _loadMoreActivities();
    }
  }

  void _loadActivitiesCache() {
    final indexPagina = state.indexPage + 1;
    if (indexPagina > state.pageCount) return;
    page++;
    _setState(indexPage: indexPagina);
  }

  void _setState({required int indexPage}) {
    final itemsByPage = state.pageCount;
    final newActivity = state.totalActivities.sublist(
        indexPage * itemsByPage, (indexPage * itemsByPage) + itemsByPage);

    state = state.copyWith(
        indexPage: indexPage,
        newActivities: newActivity,
        lastPage: state.lastPage,
        pageCount: state.pageCount,
        totalActivities: state.totalActivities);
  }
}

class ActivityStatus {
  //TODO: Cambiar cuando este listo el endpoint
  final List<Patient> newActivities;
  //TODO: Cambiar cuando este listo el endpoint
  final List<Patient> totalActivities;
  final int indexPage;
  final int lastPage;
  final int pageCount;

  ActivityStatus({
    required this.newActivities,
    required this.totalActivities,
    required this.lastPage,
    required this.indexPage,
    required this.pageCount,
  });

  ActivityStatus copyWith(
          {required List<Patient> newActivities,
          required List<Patient> totalActivities,
          required int indexPage,
          required int pageCount,
          required int lastPage}) =>
      ActivityStatus(
          newActivities: newActivities,
          totalActivities: totalActivities,
          lastPage: lastPage,
          indexPage: indexPage,
          pageCount: pageCount);
}
