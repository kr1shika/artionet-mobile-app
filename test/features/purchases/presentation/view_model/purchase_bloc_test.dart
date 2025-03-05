import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/use_case/get_artwork_usecase.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/create_purchase_usecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/getArtist_sales_usecase.dart';
import 'package:tryproject/features/purchases/domain/use_case/update_status_usecase.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

class MockGetPurchasesByUserIdUsecase extends Mock
    implements GetPurchasesByUserIdUsecase {}

class MockCreatePurchaseUsecase extends Mock implements CreatePurchaseUsecase {}

class MockGetArtworkByIdUsecase extends Mock implements GetArtworkByIdUsecase {}

class MockGetArtistSalesUsecase extends Mock implements GetArtistSalesUsecase {}

class MockUpdatePurchaseStatusUseCase extends Mock
    implements UpdatePurchaseStatusUseCase {}

void main() {
  late GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase;
  late CreatePurchaseUsecase createPurchaseUsecase;
  late GetArtworkByIdUsecase getArtworkByIdUsecase;
  late GetArtistSalesUsecase getArtistSalesUsecase;
  late UpdatePurchaseStatusUseCase updatePurchaseStatusUseCase;
  late PurchaseBloc purchaseBloc;

  setUp(() {
    getPurchasesByUserIdUsecase = MockGetPurchasesByUserIdUsecase();
    createPurchaseUsecase = MockCreatePurchaseUsecase();
    getArtworkByIdUsecase = MockGetArtworkByIdUsecase();
    getArtistSalesUsecase = MockGetArtistSalesUsecase();
    updatePurchaseStatusUseCase = MockUpdatePurchaseStatusUseCase();
    purchaseBloc = PurchaseBloc(
        getPurchasesByUserIdUsecase: getPurchasesByUserIdUsecase,
        createPurchaseUsecase: createPurchaseUsecase,
        getArtworkByIdUsecase: getArtworkByIdUsecase,
        getArtistSalesUsecase: getArtistSalesUsecase,
        updatePurchaseStatusUseCase: updatePurchaseStatusUseCase);
  });

  const String testUserId = 'user123';
  final List<PurchaseEntity> testPurchases = [
    PurchaseEntity(
      // purchaseId: '1',
      art_id: 'art123',
      buyer_id: 'user123',
      address: '123 Art Street',
      status: 'Completed',
      title: 'Abstract Painting',
      imageUrl: 'http://example.com/image.jpg',
      totalAmount: '200',
      orderDate: DateTime.now(),
    ),
    PurchaseEntity(
      purchaseId: '2',
      art_id: 'art456',
      buyer_id: 'user123',
      address: '456 Art Avenue',
      status: 'Pending',
      title: 'Landscape Painting',
      imageUrl: 'http://example.com/image2.jpg',
      totalAmount: '350',
      orderDate: DateTime.now(),
    ),
  ];

  group('PurchaseBloc Tests', () {
//  1. Emits [PurchaseState] with purchases when getpurchasesbyId is successful----------------
    blocTest<PurchaseBloc, PurchaseState>('getpurchases by id',
        build: () {
          when(() => getPurchasesByUserIdUsecase.call(testUserId))
              .thenAnswer((_) async => Right(testPurchases));
          return purchaseBloc;
        },
        act: (bloc) =>
            bloc.add(const FetchPurchasesByUserId(userId: testUserId)),
        expect: () => [
              PurchaseState.initial().copyWith(isLoading: true),
              PurchaseState.initial().copyWith(
                  purchases: testPurchases,
                  isLoading: false,
                  purchaseId: testPurchases[0].purchaseId)
            ],
        verify: (_) {
          verify(() => getPurchasesByUserIdUsecase.call(testUserId)).called(1);
        });

// 2. Emits [PurchaseState] with error when getpurchasesbyId fails---------------------
    blocTest<PurchaseBloc, PurchaseState>(
        'Emits [PurchaseState] with error when getpurchasesbyId fails',
        build: () {
          when(() => getPurchasesByUserIdUsecase.call(testUserId)).thenAnswer(
              (_) async => const Left(ApiFailure(message: 'Server Error')));
          return purchaseBloc;
        },
        act: (bloc) =>
            bloc.add(const FetchPurchasesByUserId(userId: testUserId)),
        expect: () => [
              PurchaseState.initial().copyWith(isLoading: true),
              PurchaseState.initial().copyWith(
                  purchases: [], isLoading: false, errorMessage: 'Server Error')
            ],
        verify: (_) {
          verify(() => getPurchasesByUserIdUsecase.call(testUserId)).called(1);
        });

// 3. Emits [PurchaseState] with artwork details when getArtworkById is successful----------------
    blocTest<PurchaseBloc, PurchaseState>(
      'Emits [PurchaseState] with artwork details when getArtworkById is successful',
      build: () {
        const mockArtwork = ArtworkEntity(
            artworkId: 'art123',
            title: 'Abstract Painting',
            creatorsNote: 'A beautiful abstract painting',
            images: 'http://example.com/image.jpg',
            price: '200',
            artistId: "1",
            dimensions: '20x30',
            categories: 'Abstract',
            medium_used: 'Oil',
            isLiked: false);
        when(() => getArtworkByIdUsecase.call(testPurchases[0].art_id))
            .thenAnswer((_) async => const Right(mockArtwork));
        return purchaseBloc;
      },
      act: (bloc) => bloc.add(FetchArtworkById(id: testPurchases[0].art_id)),
      expect: () => [
        PurchaseState.initial().copyWith(isLoading: true),
        PurchaseState.initial().copyWith(
          artworkTitle: 'Abstract Painting',
          artworkPrice: 200,
          artworkImages: ['http://example.com/image.jpg'],
          isLoading: false,
        ),
      ],
    );

// 4. Emits [PurchaseState] with error when getArtworkById fails---------------------
    final List<PurchaseEntity> testSales = [
      PurchaseEntity(
        purchaseId: '1',
        art_id: 'art123',
        buyer_id: 'user123',
        address: '123 Art Street',
        status: 'Completed',
        title: 'Abstract Painting',
        imageUrl: 'http://example.com/image.jpg',
        totalAmount: '200',
        orderDate: DateTime.now(),
      ),
      PurchaseEntity(
        purchaseId: '2',
        art_id: 'art456',
        buyer_id: 'user123',
        address: '456 Art Avenue',
        status: 'Pending',
        title: 'Landscape Painting',
        imageUrl: 'http://example.com/image2.jpg',
        totalAmount: '350',
        orderDate: DateTime.now(),
      ),
    ];

    blocTest<PurchaseBloc, PurchaseState>(
      'Emits sales when getArtistsales method',
      build: () {
        when(() => getArtistSalesUsecase.call('1'))
            .thenAnswer((_) async => Right(testSales));
        return purchaseBloc;
      },
      act: (bloc) => bloc.add(const FetchArtistSales(artistId: '1')),
      expect: () => [
        PurchaseState.initial().copyWith(isLoading: true),
        PurchaseState.initial().copyWith(
          artistSales: testSales,
          isLoading: false,
        ),
      ],
    );
  });


  // 5
  
}
