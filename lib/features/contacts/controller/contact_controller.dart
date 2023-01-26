import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_up/features/contacts/select_contact_repo.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectCountryRepo = ref.watch(selectContactRepoProvider);
  return selectCountryRepo.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  final selectContactRepo = ref.watch(selectContactRepoProvider);
  return SelectContactController(
    ref: ref,
    selectContactRepo: selectContactRepo,
  );
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepo selectContactRepo;

  SelectContactController({
    required this.ref,
    required this.selectContactRepo,
  });
}
