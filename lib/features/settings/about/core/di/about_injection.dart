import '../../data/repository/about_repo_impl.dart';
import '../../presentation/cubit/about_cubit.dart';
import '../../domain/use_case/about_uc.dart';
import '../../data/datasource/about_local_data_source.dart';
import '../../data/mapper/about_mapper.dart';

/// Simple container returned by the About feature DI helper.
class AboutDependencies {
  final AboutUC aboutUC;
  final AboutCubit aboutCubit;

  AboutDependencies({required this.aboutUC, required this.aboutCubit});
}

/// Create About feature dependencies and return both the use-case and cubit.
AboutDependencies createAboutDependencies() {
  const local = AboutLocalDataSourceImpl();
  const mapper = AboutMapper();
  final repo = AboutRepoImpl(local, mapper);
  final uc = AboutUC(repo);
  final cubit = AboutCubit(uc);
  return AboutDependencies(aboutUC: uc, aboutCubit: cubit);
}

/// Helper that only returns the cubit.
AboutCubit createAboutCubit() => createAboutDependencies().aboutCubit;
