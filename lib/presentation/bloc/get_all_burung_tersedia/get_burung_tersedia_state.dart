// get_burung_tersedia_state.dart
import 'package:project_115/data/model/response/burung_semua_tersedia_model.dart'; // Tambahkan ini

sealed class GetBurungTersediaState implements Equatable {
  // Extend Equatable
  const GetBurungTersediaState(); // Tambahkan konstruktor const
  List<Object> get props => []; // Implementasikan props
}

class Equatable {}

final class GetBurungTersediaInitial extends GetBurungTersediaState {
  const GetBurungTersediaInitial(); // Tambahkan konstruktor const
}

final class GetBurungTersediaLoading extends GetBurungTersediaState {
  const GetBurungTersediaLoading(); // Tambahkan konstruktor const
}

final class GetBurungTersediaLoaded extends GetBurungTersediaState {
  final BurungSemuaTersediaModel burungTersedia;

  const GetBurungTersediaLoaded({
    // Ubah konstruktor
    required this.burungTersedia,
  });

  @override
  List<Object> get props => [burungTersedia];
}

// Perbaiki penulisan kelas: dari getBurungTersediaError menjadi GetBurungTersediaError
final class GetBurungTersediaError extends GetBurungTersediaState {
  final String message;

  const GetBurungTersediaError({
    required this.message,
  }); // Tambahkan konstruktor const

  @override
  List<Object> get props => [message];
}
