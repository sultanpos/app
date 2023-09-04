import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class AppSettingWidget extends StatefulWidget {
  const AppSettingWidget({super.key});

  @override
  State<AppSettingWidget> createState() => _AppSettingWidgetState();
}

class _AppSettingWidgetState extends State<AppSettingWidget> {
  double _scale = 1;

  @override
  void initState() {
    _scale = ScaledWidgetsFlutterBinding.instance.scaleFactor(Size.zero);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(STheme().padding * 2),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Aplikasi',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              SButton(
                onPressed: () async {
                  await Preference().setScale(_scale);
                  ScaledWidgetsFlutterBinding.instance.scaleFactor = (deviceSize) => _scale;
                  // ignore: use_build_context_synchronously
                  showSuccess(context, message: 'berhasil menyimpan');
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
          const SVSpaceDouble(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelField("Scale"),
                    Slider(
                      value: _scale,
                      max: 2,
                      min: 0.25,
                      divisions: 7,
                      label: _scale.toString(),
                      onChanged: (v) {
                        setState(() {
                          _scale = v;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SHSpaceDouble(),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
