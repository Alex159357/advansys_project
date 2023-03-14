
import '../../helpers/constaints.dart';

class AddWidgetState {
  final String name;
  final String widgetOutput;
  final String widgetType;
  final String widgetTag;
  final String selectedModule;
  final String selectedHub;

  bool get didFieldsValid =>
      name.isNotEmpty && widgetTag.isNotEmpty && selectedHub.isNotEmpty && selectedHub.isNotEmpty;

  const AddWidgetState(
      {this.name = "",
      this.widgetOutput = "",
        this.widgetType = "",
      this.widgetTag = "",
      this.selectedModule = "",
      this.selectedHub = ""});

  AddWidgetState clone(
          {String? name,
          String? widgetOutput,
          String? widgetTag,
          String? selectedModule, String? selectedHub, String? widgetType}) =>
      AddWidgetState(
        name: name ?? this.name,
        widgetOutput: widgetOutput ?? this.widgetOutput,
        widgetTag: widgetTag ?? this.widgetTag,
          widgetType: widgetType ?? this.widgetType,
        selectedModule: selectedModule ?? this.selectedModule,
          selectedHub: selectedHub ?? this.selectedHub
      );
}
