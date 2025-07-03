import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class CustomPictogramasPage extends StatelessWidget {
  final int idChild;
  const CustomPictogramasPage({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Tooltip(
          message: S
              .current.Pictogramas_personalizados, // Muestra el nombre completo
          waitDuration:
              const Duration(milliseconds: 100), // Espera antes de mostrarse
          showDuration: const Duration(seconds: 2), // Tiempo visible
          child: Text(S.current.Pictogramas_personalizados),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: $colorBlueGeneral,
                        ),
                        padding: const EdgeInsets.only(
                            left: 22, top: 20, bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.current.Ayuda,
                          style: const TextStyle(
                            color: $colorTextWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      titlePadding: EdgeInsets.zero,
                      content: SingleChildScrollView(
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current
                                    .Si_el_nombre_del_pictograma_no_se_muestra_completo_puede,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Mantener_el_dedo_sobre_el_nombre_durante_1_segundo_para_verlo_completo,
                              ),
                              const SizedBox(height: 5),
                              Text(S.current.Hacer_clic_en_el_boton_de_editar),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Para_ver_la_imagen_con_mas_detalle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current.Hacer_doble_clic_sobre_la_imagen,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                S.current
                                    .Si_el_titulo_de_la_pantalla_no_se_muestra_completo_puede,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Mantener_el_dedo_sobre_el_titulo_durante_1_segundo_para_verlo_completo,
                              ),
                            ],
                          ),
                        ),
                      ),
                      insetPadding: EdgeInsets.zero,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: GridImages(isCustomized: true, idChild: idChild),
    );
  }
}
