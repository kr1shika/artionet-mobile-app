import 'package:equatable/equatable.dart';

class ArtworkEntity extends Equatable {
  final String? artworkId;
  final String artworkName;

  const ArtworkEntity({
    this.artworkId,
    required this.artworkName,
  });

  @override
  List<Object?> get props => [artworkId, artworkName];
}
