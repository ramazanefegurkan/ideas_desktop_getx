import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop/view/_utility/screen_keyboard/screen_keyboard_view.dart';
import 'package:ideas_desktop/view/menu/condiment-groups/condiment_groups_table.dart';
import 'package:ideas_desktop/view/menu/condiment-groups/condiment_groups_view_model.dart';

import '../../../locale_keys_enum.dart';

class CondimentGroupsPage extends StatelessWidget {
  const CondimentGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CondimentGroupsController controller = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: !controller.showLoading.value &&
                  controller.condimentGroupDataSource.value != null
              ? buildBody(controller)
              : const LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(CondimentGroupsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Grup ara',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    controller: controller.searchCtrl,
                    onTap: () async {
                      if (controller.localeManager
                          .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                        var res = await Get.dialog(
                          const ScreenKeyboard(),
                        );
                        if (res != null) {
                          controller.searchCtrl.text = res;
                          controller.filterCondimentGroups();
                        }
                      }
                    },
                    onChanged: (v) => {
                          controller.filterCondimentGroups(),
                        }),
              ),
            ),
            GestureDetector(
              onTap: () => controller.openNewCondimentGroupDialog(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Yeni Ekseçim Grubu',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Kapat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: buildCancelReportTable(controller),
          ),
        ),
      ],
    );
  }

  Widget buildCancelReportTable(CondimentGroupsController controller) {
    return Obx(() {
      return CondimentGroupsTable(
        source: controller.condimentGroupDataSource.value!,
      );
    });
  }
}
