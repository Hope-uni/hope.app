import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class FormActivity extends StatelessWidget {
  final bool isVisibleSeleccion;
  final bool isEdit;

  const FormActivity(
      {super.key, required this.isVisibleSeleccion, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          InputForm(
            //TODO: Cambiar cuando este listo el endpoint
            value: 'Actividad con animales',
            enable: isEdit,
            label: S.current.Nombre,
            maxLength: 50,
          ),
          InputForm(
            value:
                'El niño debe de seleccionar al menos 7 pictogramas de animales',
            enable: isEdit,
            //TODO: Crear variable de internacionalizacion,
            label: 'Descripcion',
            maxLines: 5,
            maxLength: 100,
          ),
          SelectBox(
            //TODO: Cambiar cuando este listo el endpoint
            listItems: ['Fase 1', 'Fase 2', 'Fase 3', 'Fase 4'],
            enable: isEdit,
            valueInitial: 'Fase 3',
            //TODO: Crear variable de internacionalizacion,
            label: 'Fase del autismo',
          ),
          InputForm(
            //TODO: Cambiar cuando este listo el endpoint
            value: '10',
            enable: isEdit,
            //TODO: Crear variable de internacionalizacion,
            label: 'Puntaje',
            isNumber: true,
          ),
          Visibility(
            visible: isVisibleSeleccion || isEdit,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 15,
                    bottom: 20,
                  ),
                  child: const Text(
                    //TODO: Crear variable de internacionalizacion,
                    'Seleccione pictogramas de la solucion',
                    style: TextStyle(fontSize: 14.5),
                  ),
                ),
                SelectBox(
                  valueInitial: 'Casa',
                  label: S.current.Categoria_de_pictogramas,
                  enable: true,
                  onSelected: (value) {},
                  listItems: const ['Casa', 'Escuela'],
                ),
                InputForm(
                  isSearch: true,
                  label: S.current.Busqueda_por_nombre,
                  value: '',
                  enable: true,
                  onChanged: (value) {},
                ),
                const ImageListVIew(
                  isDecoration: true,
                  isSelect: true,
                  backgroundColorIcon: $colorSuccess,
                  iconSelect: Icon(Icons.check),
                ),
                const SizedBox(height: 14.5),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 30, right: 15, bottom: 12.5),
            //TODO: Crear variable de internacionalizacion,
            child: const Text('Solucion', style: TextStyle(fontSize: 15)),
          ),
          ImageListVIew(
            backgroundDecoration: $colorPrimary50,
            isDecoration: true,
            isSelect: isVisibleSeleccion || isEdit,
            backgroundColorIcon: $colorError,
            iconSelect: const Icon(Icons.delete),
          ),
          const SizedBox(height: 15),
          const InputForm(
            //TODO: Cambiar cuando este listo el endpoint
            value: 'Yo quiero una manzana',
            enable: false,
            //TODO: Crear variable de internacionalizacion,
            label: 'Oracion',
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
