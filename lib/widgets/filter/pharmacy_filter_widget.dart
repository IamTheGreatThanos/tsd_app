import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/vmodel/pharmacy_filter_vmodel.dart';
import 'package:provider/provider.dart';

class PharmacyFilterWidget extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback trailingCloseTap;
  const PharmacyFilterWidget({
    super.key,
    required this.onTap,
    required this.trailingCloseTap,
  });

  @override
  State<PharmacyFilterWidget> createState() => _PharmacyFilterWidgetState();
}

class _PharmacyFilterWidgetState extends State<PharmacyFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PharmacyFilterVmodel>(
      builder: (context, model, child) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onTap: () {
              widget.onTap();
            },
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            leading: const Icon(
              Icons.filter_alt_outlined,
              color: ColorPalette.grey400,
            ),
            title: Transform.translate(
              offset: const Offset(-20, 0),
              child: Row(
                children: [
                  const Text(
                    'Фильтр',
                    style: TextStyle(
                      color: ColorPalette.grey400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.filterCount != 0)
                    Container(
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 107, 246, 179),
                      ),
                      child: Center(
                        child: Text(
                          "${model.filterCount}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 19, 123, 15),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            trailing: model.filterCount == 0
                ? const IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorPalette.grey400,
                    ),
                    onPressed: null,
                  )
                : IconButton(
                    onPressed: () {
                      widget.trailingCloseTap();
                    },
                    icon: const Icon(Icons.close),
                  ),
          ),
        );
      },
    );
  }
}
