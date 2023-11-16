import 'package:flutter/material.dart';

class MesDemandes extends StatefulWidget {
  const MesDemandes({Key? key}) : super(key: key);

  @override
  State<MesDemandes> createState() => _MesDemandesState();
}

class _MesDemandesState extends State<MesDemandes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mes Demandes")
        ],
      ),
    );
  }
}
