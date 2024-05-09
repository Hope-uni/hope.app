import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class RemoveAcivityPage extends StatelessWidget {
  const RemoveAcivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.Quitar_asignacion_de_actividad)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(children: [
          const SizedBox(height: 25),
          InputForm(
            value: '',
            enable: true,
            label: S.current.Busqueda_por_nombre,
            marginBottom: 0,
            isSearch: true,
            //TODO: Implementar condicional con provider cuando este listo el endpoint
            suffixIcon: true
                ? const Icon(
                    Icons.search,
                  )
                : IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
          ),
          Expanded(
            child: ListView.builder(
              //TODO: Cambiar  cuando este listo el endpoint
              itemCount: 15,
              itemBuilder: (context, index) {
                //TODO: Cambiar el 14 cuando este listo el endpoint
                if (index < 14) {
                  return ListTileCustom(
                    //TODO: Cambiar cuando este listo el endpoint
                    subTitle: 'Fase 4 | 7 años',
                    //TODO: Cambiar cuando este listo el endpoint
                    image: '',
                    //TODO: Cambiar cuando este listo el endpoint
                    title: 'Alexandra de concepcion gutierrez largaespada',
                    iconButton: IconButton(
                      //TODO: Cambiar cuando este listo el endpoint. implementar metodo
                      onPressed: () {
                        modalDialogConfirmation(
                            context: context,
                            onClic: () {},
                            question: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${S.current.Esta_seguro_de_quitarle_la_actividad}\n\n',
                                    style:
                                        const TextStyle(color: $colorTextBlack),
                                  ),
                                  const TextSpan(
                                    text: 'Forma oraciones con animales\n\n',
                                    style: TextStyle(
                                        color: $colorTextBlack,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '${S.current.A}\n\n',
                                    style:
                                        const TextStyle(color: $colorTextBlack),
                                  ),
                                  const TextSpan(
                                    text:
                                        'Alexandra de Concepcion Gutierrez Largaespada',
                                    style: TextStyle(
                                        color: $colorTextBlack,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                            titleButtonConfirm: S.current.Si_Quitar);
                      },
                      icon: const Icon(Icons.delete, color: $colorError),
                    ),
                  );
                } else {
                  return const SizedBox(height: 75);
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
