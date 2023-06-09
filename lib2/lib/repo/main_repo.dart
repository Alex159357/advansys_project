

import '../model/widget_model.dart';
import '../model/hub_id_model.dart';
import '../model/module_id.dart';

abstract class MainRepo {


  Future<List<WidgetModel>?> fetchWidgets();

  Future<bool> passAction({required String hubid, required String id, required bool state, required String paramOut});

  Future<List<HubIdModel>?> fetchHubs();

  Future<List<WidgetModel>?> addDevice(Map<String, dynamic> req);

  Future<List<ModuleModel>?> fetchModuleList(int objectId);

  Future<void> widgetMoved(WidgetModel widgetModel);

  Future<List<WidgetModel>?> deleteWidget(int id);

}