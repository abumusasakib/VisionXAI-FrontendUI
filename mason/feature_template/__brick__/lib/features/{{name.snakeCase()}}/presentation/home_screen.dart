import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'home_cubit.dart';
import 'home_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feature')),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final picker = ImagePicker();
          return Column(
            children: [
              if (state.imageFile != null)
                Image.file(File(state.imageFile!.path))
              else
                const SizedBox.shrink(),
              ElevatedButton(
                onPressed: () async {
                  final picked =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (picked != null) cubit.selectImage(picked);
                },
                child: const Text('Select image'),
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.uploadAndGenerateCaption(context);
                },
                child: const Text('Generate'),
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.stopCaptionGeneration();
                },
                child: const Text('Stop'),
              ),
              if (state.testOutput.isNotEmpty) Text(state.testOutput),
            ],
          );
        },
      ),
    );
  }
}
