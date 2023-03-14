import 'package:flutter/foundation.dart';
import '../helpers/states/api_values.dart';
import '../home_screen.dart';
import '../model/action_response.dart';
import '../model/hub_id_model.dart';
import '../model/module_id.dart';
import '../model/widget_model.dart';
import 'client.dart';
import 'client_impl.dart';
import 'main_repo.dart';

class MainRepoImpl implements MainRepo {


  @override
  Future<bool> passAction(
      {required String hubid, required String id, required bool state}) async {
    final outState = state ? 1 : 0;
    var req = {
      "hubid": "$hubid",
      "value":
          "{\"action\":\"setManual\",\"data\":{\"idOut\":\"$id\",\"paramOut\":\"DO3\",\"setValue\":\"$outState\"}}"
    };
    Client client = ClientImpl<ActionResponse, void>("");
    ActionResponse actionResponse =
        await client.callPost(data: req, apiValues: ApiValues.DEVICE_ACTION);
    return actionResponse.status == "true";
  }

  @override
  Future<List<HubIdModel>?> fetchHubs() async {
    var req = {"object_id": "1"};
    Client client = ClientImpl<HubIdModel, List<HubIdModel>>("hubs");
    try {
      return await client.callPost(data: req, apiValues: ApiValues.HUB_LIST);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }


  @override
  Future<List<ModuleModel>?> fetchModuleList(int objectId) async {
    Client client = ClientImpl<ModuleModel, List<ModuleModel>>("result");
    try {
      return await client.callPost(data: {
        "object_id": "$objectId",
      }, apiValues: ApiValues.MODULES);
    } catch (e) {
      if (kDebugMode) {
        print("ModulesList -> $e");
      }
    }
    return null;
  }



  @override
  Future<void> widgetMoved(WidgetModel widgetModel) async {
    // Client client = ClientImpl<ActionResponse, void>("");
    // var req = {
    //   "widget_id": widgetModel.id,
    //   "panel_id": panelId,
    //   "x": widgetModel.dx.toString(),
    //   "y": widgetModel.dy.toString()
    // };
    // try {
    //   ActionResponse actionResponse = await client.callPost(
    //       data: req, apiValues: ApiValues.ON_WIDGEET_POSITION_CHANGED);
    //   if (kDebugMode) {
    //     print(actionResponse.status);
    //   }
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }

  @override
  Future<List<WidgetModel>?> deleteWidget(int id) async {
    Client client = ClientImpl<ActionResponse, void>("");
    var req = {"widget_id": id.toString(), "panel_id": panelId};
    try {
      await client.callPost(data: req, apiValues: ApiValues.DELETE_WIDGET);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return await fetchWidgets();
  }

  @override
  Future<List<WidgetModel>?> fetchWidgets() async {
    //1
    Client client = ClientImpl<WidgetModel, List<WidgetModel>>("widgets");
    var res = await client.callPost(data: {
      "panel_id": panelId,
    }, apiValues: ApiValues.DEVICE_LIST) as List<WidgetModel>?;
    return res;
  }

  @override
  Future<List<WidgetModel>?> addDevice(Map<String, dynamic> req) async {
    // TODO: implement addDevice
    Client client = ClientImpl<ActionResponse, void>("");
    try {
      req.addAll({"panel_id": panelId, "parameter": parameter});
      ActionResponse actionResponse =
          await client.callPost(data: req, apiValues: ApiValues.ADD_DEVICE);
      if (actionResponse.status == "Success") {
        return fetchWidgets();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
