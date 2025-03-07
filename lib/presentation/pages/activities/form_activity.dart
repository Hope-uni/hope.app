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
            label: S.current.Descripcion,
            linesDynamic: true,
            maxLength: 100,
          ),
          SelectBox(
            //TODO: Cambiar cuando este listo el endpoint
            listItems: const ['Fase 1', 'Fase 2', 'Fase 3', 'Fase 4'],
            enable: isEdit,
            valueInitial: 'Fase 3',
            label: S.current.Fase_del_autismo,
          ),
          InputForm(
            //TODO: Cambiar cuando este listo el endpoint
            value: '10',
            enable: isEdit,
            label: S.current.Puntaje,
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
                  child: Text(
                    S.current.Seleccione_pictogramas_de_la_solucion,
                    style: const TextStyle(fontSize: 14.5),
                  ),
                ),
                //TODO: Cambiar cuando este listo el endpoint
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
                //TODO: Cambiar cuando este listo el endpoint
                const ImageListVIew(
                  images: [],
                  nameImages: [],
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
            child:
                Text(S.current.Solucion, style: const TextStyle(fontSize: 15)),
          ),
          //TODO: Cambiar cuando este listo el endpoint
          ImageListVIew(
            images: const [],
            nameImages: const [],
            backgroundDecoration: $colorPrimary50,
            isDecoration: true,
            isSelect: isVisibleSeleccion || isEdit,
            backgroundColorIcon: $colorError,
            iconSelect: const Icon(Icons.delete),
          ),
          const SizedBox(height: 15),
          InputForm(
            //TODO: Cambiar cuando este listo el endpoint
            value: 'Yo quiero una manzana',
            enable: false,
            label: S.current.Oracion,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
