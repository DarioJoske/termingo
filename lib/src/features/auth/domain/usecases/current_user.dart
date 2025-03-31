import 'package:termingo/src/core/common/entities/app_user.dart';
import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UsecaseWithoutParams<AppUser> {
  final AuthRepository authRepository;
  const CurrentUser({required this.authRepository});

  @override
  ResultFuture<AppUser> call() async {
    return await authRepository.currentUser();
  }
}
