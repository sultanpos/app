import 'package:flutter/material.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/ui/root.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/tileselect.dart';

class SelectCacheDatabaseWidget extends StatefulWidget {
  const SelectCacheDatabaseWidget({super.key});

  @override
  State<SelectCacheDatabaseWidget> createState() => _SelectCacheDatabaseWidgetState();
}

class _SelectCacheDatabaseWidgetState extends State<SelectCacheDatabaseWidget> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Fitur Offline?",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  TileSelect<int>(
                    onSelected: (value) {
                      _index = value;
                      setState(() {});
                    },
                    current: _index,
                    items: [
                      TileSelectData(
                          id: 0,
                          title: "Nyala",
                          description:
                              "Keperluan data untuk berjualan akan di download ke lokal. Sehingga akan tetap bisa berjualan lewat kasir meski internet mati."),
                      TileSelectData(
                          id: 1,
                          title: "Mati",
                          description: "Jika internet mati maka tidak dapat berjualan melalui kasir"),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SButton(
                    width: double.infinity,
                    label: 'Simpan dan lanjutkan',
                    onPressed: () async {
                      Preference().setShouldCacheToLocal(_index == 0);
                      if (_index == 0) {
                        AppState().startSync();
                      }
                      Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RootWidget(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
