import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:provider/provider.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:vision_xai/core/utils/error_message_mapper.dart';

import '../../cubit/settings_feature_cubit.dart';
import '../../../domain/entity/settings_entity.dart';

class IpSettingsScreen extends StatefulWidget {
  const IpSettingsScreen({super.key});

  @override
  State<IpSettingsScreen> createState() => _IpSettingsScreenState();
}

class _IpSettingsScreenState extends State<IpSettingsScreen> {
  late final TextEditingController _ipController;
  late final TextEditingController _portController;

  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController();
    _portController = TextEditingController();
    final cubit = context.read<SettingsFeatureCubit>();
    final s = cubit.state;
    if (s != null) {
      _ipController.text = s.ip;
      _portController.text = s.port;
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsFeatureCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(context.tr.settingsScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key('ipField'),
              controller: _ipController,
              decoration: InputDecoration(labelText: context.tr.ip),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('portField'),
              controller: _portController,
              decoration: InputDecoration(labelText: context.tr.port),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    String ip = _ipController.text;
                    String port = _portController.text;
                    final ns = context.read<NotificationService>();
                    if (ip.isNotEmpty && port.isNotEmpty) {
                      final entity = SettingsEntity(
                          ip: ip,
                          port: port,
                          locale: cubit.state?.locale ?? 'en');
                      final successMsg = context.tr.ipPortUpdated;
                      final result = await runWithErrorHandling<void>(
                          () => cubit.save(entity),
                          showSnackOnError: true,
                          notificationService: ns,
                          context: context,
                          successMessage: successMsg,
                          showSuccessOnSuccess: true);
                      if (result.isSuccess) {
                        // Close only when the widget is still mounted
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    } else {
                      ns.showSnackBar(
                        context,
                        context.tr.enterIpAndPort,
                      );
                    }
                  },
                  icon: const Icon(Icons.file_upload_outlined),
                  label: Text(context.tr.updateIp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
