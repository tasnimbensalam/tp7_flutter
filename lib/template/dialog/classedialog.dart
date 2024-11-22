import 'package:flutter/material.dart';
import 'package:tp7_test/entities/classe.dart';
import 'package:tp7_test/service/classeservice.dart';

class ClassDialog extends StatefulWidget {
  final Function()? notifyParent;
  Classe? classe;

  ClassDialog({super.key, @required this.notifyParent, this.classe});
  @override
  State<ClassDialog> createState() => _ClassDialogState();
}

class _ClassDialogState extends State<ClassDialog> {
  TextEditingController nomCtrl = TextEditingController();

  TextEditingController nbrCtrl = TextEditingController();

  String title = "Ajouter Classe";
  String action = "Ajouter";
  bool modif = false;

  late int idClasse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print(widget.departement!.toJson());

    if (widget.classe != null) {
      modif = true;
      title = "Modifier Classe";
      action = "Modifier";
      nomCtrl.text = widget.classe!.nomClass;
      nbrCtrl.text = (widget.classe!.nbreEtud).toString();
      idClasse = widget.classe!.codClass!;
    }
    //getAlldepartementss();
  }

/*
  Future<void> getAlldepartementss() async {
    List<dynamic> result = await getAlldepartements();
    setState(() {
      print("get all departements");
      print(result);

      result.forEach((element) {
        departements
            .add(Departement(element['nomDepartement'], element['code']));
      });
    });

    if (widget.departement != null) {
      print("widget.departement");
      print(widget.departement);
      departements.forEach((element) {
        if (element.code == widget.departement!.code) {
          selectedDepartement = element;
        }
      });
    } else if (widget.classe != null) {
      print("widget.classe");
      print(widget.classe);
      departements.forEach((element) {
        if (element.code == widget.classe!.departement!.code) {
          selectedDepartement = element;
        }
      });
    } else {
      print("first departement");
      selectedDepartement = departements[0];
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller: nomCtrl,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: "nom"),
            ),
            TextFormField(
              controller: nbrCtrl,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration:
                  const InputDecoration(labelText: "Nombre des etudiants"),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (modif == false) {
                    Classe c = Classe(int.parse(nbrCtrl.text), nomCtrl.text);

                    print(c.toJson());
                    await addClass(c);
                    Navigator.of(context).pop();

                    widget.notifyParent!();
                  } else {
                    Classe c =
                        Classe(int.parse(nbrCtrl.text), nomCtrl.text, idClasse);
                    print(c.toJson());
                    await updateClasse(c);
                    Navigator.of(context).pop();

                    widget.notifyParent!();
                  }
                },
                child: Text(action))
          ],
        ),
      ),
    );
  }
}
