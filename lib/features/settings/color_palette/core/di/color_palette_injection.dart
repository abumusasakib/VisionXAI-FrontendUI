import 'package:vision_xai/features/settings/color_palette/data/repository/palette_repo_impl.dart';
import 'package:vision_xai/features/settings/color_palette/domain/use_case/palette_uc.dart';

/// Simple DI helper for the color palette feature.
PaletteUC createPaletteUseCase() {
  final repo = PaletteRepoImpl();
  return PaletteUC(repo);
}
