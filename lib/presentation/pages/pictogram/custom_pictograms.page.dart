import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class CustomPictogramasPage extends StatelessWidget {
  final int idChild;
  const CustomPictogramasPage({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    final arregloImages = [
      'https://w0.peakpx.com/wallpaper/571/466/HD-wallpaper-angular-programming-computer.jpg',
      'https://d2nir1j4sou8ez.cloudfront.net/wp-content/uploads/2022/01/Frame-1.png',
      'https://wallpapercave.com/wp/wp7732979.jpg',
      'https://i.pinimg.com/736x/10/11/c6/1011c6f3ffcdfa8c2f3f57a78d35fe1f.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf_ruDEu-B64SJpwOXePAl73XsYZhJOca5Fh-2_klT6QEMEtvkKci11Q9BAsi-x-NSRT4&usqp=CAU',
      'https://cdn.hashnode.com/res/hashnode/image/upload/v1685077480777/1957f8b1-97d9-4699-ab42-92c5d1276861.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWBenGfs6dWhsrF2hdW3bLYb81ye9c-dRS7A&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRExSanWgjRZjQ9KxIQTodRcxeOMt1yiyi6VQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShwMTecQxZArr6b4XP1GD31er_CqtSthxvsQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN-XtAtwzrVmmtLOLP7QaZET7a0U2Dq-U7FQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvD-3Pc7FEeZtMPli6xc7GAJ2Sy0nlexJaTQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBuehSarqgYg9LIbMSrPX0UbuUKPoF1u3nFg&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVtSOCoBxJmgh8n2eo0pGnk1kyBkQ-W9-z4A&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ69AWEG2MbKUT9eWWQ_QsNVFDP51NKJI6TMw&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwTz6HdDqbmC0pirwAxT4odQjv2Svq6XSmyQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgeU5ob-DCVwSBAzJiqhhBTW_0pe788KMoMg&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS48Q6NmpHYyIN7ooo0CLKtze4vOlIeWme83w&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOOH3jIp2pxtL1DAPe11U6tJZPD7i-q5DfdA&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRLFEn5n5SQL1teGZE69e6RgqMPGwrkPKLaA&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPN4_2ZDFPOMYuXhPThgFFXtbKP0YncjYDzA&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShwZBY2VFyPBgMZ5Xoa5VKf-TkklSm8kyNOQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4znMf8MAfQc2ez-vpqmiOc92djdT0fFgYrA&usqp=CAU',
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(S.current.Pictogramas_personalizados),
      ),
      body: GridImages(
        isCustomized: true,
        images: arregloImages,
        // ignore: avoid_print
        loadNextImages: () => print('cargando nuevas imagenes'),
      ),
    );
  }
}
