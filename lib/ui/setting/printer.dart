import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultanpos/model/appconfig.dart';
import 'package:sultanpos/state/printer.dart';
import 'package:sultanpos/ui/theme.dart';
import 'package:sultanpos/ui/util/textformatter.dart';
import 'package:sultanpos/ui/widget/button.dart';
import 'package:sultanpos/ui/widget/labelfield.dart';
import 'package:sultanpos/ui/widget/showerror.dart';
import 'package:sultanpos/ui/widget/space.dart';

class PrinterSettingWidget extends StatefulWidget {
  const PrinterSettingWidget({super.key});

  @override
  State<PrinterSettingWidget> createState() => _PrinterSettingWidgetState();
}

class _PrinterSettingWidgetState extends State<PrinterSettingWidget> {
  late AppConfigPrinter _config;
  @override
  void initState() {
    super.initState();
    final state = context.read<PrinterState>();
    _config = state.getConfigPrinter() ?? AppConfigPrinter();
    state.discover();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PrinterState>();
    return Padding(
      padding: EdgeInsets.all(STheme().padding * 2),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Printer kasir',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              SButton(
                onPressed: () {
                  state.saveChasierPrinter(_config);
                  showSuccess(context, message: "Setting berhasil disimpan");
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
          const SVSpaceDouble(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelField("Printer"),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: _config.name,
                        items: state.printers.isEmpty
                            ? null
                            : state.printers
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.name,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) {
                          _config = _config.copyWith(type: AppConfigPrinterType.usb, name: v);
                          setState(() {});
                        },
                      ),
                    ),
                    const SVSpace(),
                    const LabelField("Tipe kertas"),
                    DropdownButton(
                      isExpanded: true,
                      value: _config.paperSize,
                      items: [
                        DropdownMenuItem(
                          value: AppConfigPrinterPaperSize.paper58,
                          child: Text(AppConfigPrinterPaperSize.paper58.text),
                        ),
                        DropdownMenuItem(
                          value: AppConfigPrinterPaperSize.paper80,
                          child: Text(AppConfigPrinterPaperSize.paper80.text),
                        ),
                      ],
                      onChanged: (v) {
                        _config = _config.copyWith(paperSize: v);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SHSpaceDouble(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelField("Judul"),
                  TextFormField(
                    initialValue: _config.title ?? "Sultan POS",
                    decoration: const InputDecoration(hintText: "Masukkan judul nota"),
                  ),
                  const SVSpace(),
                  const LabelField("Sub Judul"),
                  TextFormField(
                    initialValue: _config.subtitles?.join("\n") ?? 'Jln. Tambangan 1\nPurwosari Bojonegoro',
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Masukkan sub judul nota",
                      helperText: "Gunakan enter untuk multi sub title",
                    ),
                    onChanged: (v) {
                      _config = _config.copyWith(subtitles: v.split("\n"));
                    },
                  ),
                  const SVSpace(),
                  const LabelField("Catatan Kaki"),
                  TextFormField(
                    initialValue: _config.footnotes?.join("\n") ?? 'Terima kasih sudah berbelanja',
                    maxLines: 4,
                    onChanged: (v) {
                      _config = _config.copyWith(footnotes: v.split("\n"));
                    },
                    decoration: const InputDecoration(
                      hintText: "Masukkan catatan kaki",
                      helperText: "Gunakan enter untuk multi catatan kaki",
                    ),
                  ),
                  const SVSpace(),
                  const LabelField("Feed"),
                  TextFormField(
                    initialValue: '${_config.feed ?? 2}',
                    inputFormatters: [MoneyTextFormatter()],
                    onChanged: (v) {
                      _config = _config.copyWith(feed: int.parse(v));
                    },
                    decoration: const InputDecoration(
                      hintText: "Masukkan feed",
                      helperText: "Feed printer pada akhir",
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
