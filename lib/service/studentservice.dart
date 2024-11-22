import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tp7_test/entities/student.dart';

Future getAllStudent() async {
  Response response =
      await http.get(Uri.parse("http://10.0.2.2:8081/etudiant/all"));
  return jsonDecode(response.body);
}

Future getStudentsByClasseId(int? id) async {
  Response response = await http
      .get(Uri.parse("http://10.0.2.2:8081/etudiant/findByClasseId/${id}"));
  return jsonDecode(response.body);
}

Future deleteStudent(int id) {
  return http
      .delete(Uri.parse("http://10.0.2.2:8081/etudiant/delete?id=${id}"));
}

Future addStudent(Student student) async {
  // print(student.classe!.toJson());
  // print(jsonEncode(<String, dynamic>{
  //   "nom": student.nom,
  //   "prenom": student.prenom,
  //   "dateNais":
  //       DateFormat("yyyy-MM-dd").format(DateTime.parse(student.dateNais)),
  //   "classe": student.classe!.toJson()
  // }));
  Response response =
      await http.post(Uri.parse("http://10.0.2.2:8081/etudiant/add"),
          headers: {"Content-type": "Application/json"},
          body: jsonEncode(<String, dynamic>{
            "nom": student.nom,
            "prenom": student.prenom,
            "dateNais": DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(student.dateNais)),
            "classe": student.classe!.toJson()
          }));
  return response.body;
}

Future updateStudent(Student student) async {
  Response response =
      await http.put(Uri.parse("http://10.0.2.2:8081/etudiant/update"),
          headers: {"Content-type": "Application/json"},
          body: jsonEncode(<String, dynamic>{
            "id": student.id,
            "nom": student.nom,
            "prenom": student.prenom,
            "classe": student.classe!.toJson(),
            "dateNais": DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(student.dateNais))
          }));
  return response.body;
}
