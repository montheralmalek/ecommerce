

### **Project Structure (MVVM)**
```plaintext
/lib
│
├── /core                     # Core utilities (shared across layers)
│   ├── /constants           # App-wide constants
│   ├── /network             # Dio, Retrofit, or GraphQL config
│   ├── /errors              # Custom exceptions (NetworkException, CacheException)
│   └── /extensions          # Helper extensions
│
├── /data                    # Data Layer (Services + Repositories)
│   ├── /models              # Data Transfer Objects (DTOs)
│   │   ├── api              # API response models (e.g., `BookingApiModel`)
│   │   └── local            # Local DB models (e.g., `BookingLocalModel`)
│   │
│   ├── /services            # Low-level data sources (Services)
│   │   ├── remote           # API clients (e.g., `ApiClient`)
│   │   └── local            # Local storage (e.g., `DatabaseService`)
│   │
│   ├── /repositories        # Repositories (combine services + business logic)
│   └── /mappers            # Convert DTOs ↔ Domain Entities
│
├── /domain                  # Domain Layer (Pure business logic)
│   ├── /entities            # Business entities (e.g., `Booking`)
│   ├── /repositories        # Abstract repository interfaces
│   └── /usecases            # Single-purpose logic units
│
├── /presentation            # Presentation Layer (MVVM)
│   ├── /features            # Feature modules
│   │   └── /booking         # Example: Booking feature
│   │       ├── /view        # Widgets (pages, components)
│   │       ├── /viewmodel   # ViewModel (business logic)
│   │       └── /state       # State classes (e.g., `BookingState`)
│   ├── /routes              # Navigation
│   └── /widgets             # Shared widgets
│
└── main.dart                # App entry point
```

---

### **Key Components Explained**

#### 1. **Services Layer** (Low-Level Data Sources)
- **Role**: Direct communication with APIs/databases. **Stateless** and **endpoint-focused**.
- **Example**:  
  ```dart
  // lib/data/services/remote/api_client.dart
  class ApiClient {
    final Dio _dio;

    ApiClient(this._dio);

    Future<Result<BookingApiModel>> getBooking(int id) async {
      try {
        final response = await _dio.get('/bookings/$id');
        return Result.ok(BookingApiModel.fromJson(response.data));
      } on DioException catch (e) {
        return Result.error(NetworkException.fromDioError(e));
      }
    }
  }
  ```

#### 2. **Repositories Layer** (Source of Truth)
- **Role**:  
  - Transform raw data (DTOs) → Domain entities.  
  - Handle caching, error recovery, and complex logic.  
- **Example**:  
  ```dart
  // lib/data/repositories/booking_repository_impl.dart
  class BookingRepositoryImpl implements BookingRepository {
    final ApiClient _apiClient;
    final DatabaseService _localDb;

    BookingRepositoryImpl(this._apiClient, this._localDb);

    @override
    Future<Result<Booking>> getBooking(int id) async {
      try {
        // Check cache first
        final cachedBooking = await _localDb.getBooking(id);
        if (cachedBooking != null) return Result.ok(cachedBooking);

        // Fetch from API if not cached
        final result = await _apiClient.getBooking(id);
        if (result.isError) return Result.error(result.asError.error);

        final booking = result.asOk.value.toEntity(); // Convert DTO → Entity
        await _localDb.cacheBooking(booking); // Cache for next time
        return Result.ok(booking);
      } catch (e) {
        return Result.error(CacheException('Failed to load booking'));
      }
    }
  }
  ```

#### 3. **Domain Layer** (Business Logic)
- **Interfaces**: Define contracts for repositories.  
  ```dart
  // lib/domain/repositories/booking_repository.dart
  abstract class BookingRepository {
    Future<Result<Booking>> getBooking(int id);
  }
  ```
- **Use Cases**: Encapsulate single actions.  
  ```dart
  // lib/domain/usecases/get_booking_usecase.dart
  class GetBookingUseCase {
    final BookingRepository _repository;

    GetBookingUseCase(this._repository);

    Future<Result<Booking>> execute(int id) => _repository.getBooking(id);
  }
  ```

#### 4. **Presentation Layer** (MVVM)
- **ViewModel**: Uses UseCases to fetch data and manage state.  
  ```dart
  // lib/presentation/features/booking/viewmodel/booking_viewmodel.dart
  class BookingViewModel with ChangeNotifier {
    final GetBookingUseCase _getBookingUseCase;
    BookingState _state = BookingInitial();

    BookingState get state => _state;

    BookingViewModel(this._getBookingUseCase);

    Future<void> fetchBooking(int id) async {
      _state = BookingLoading();
      notifyListeners();

      final result = await _getBookingUseCase.execute(id);
      result.fold(
        (error) => _state = BookingError(error.toString()),
        (booking) => _state = BookingLoaded(booking),
      );
      notifyListeners();
    }
  }
  ```

---

### **Flow of Data**
1. **View** → Calls `BookingViewModel.fetchBooking()`.  
2. **ViewModel** → Executes `GetBookingUseCase`.  
3. **UseCase** → Invokes `BookingRepository.getBooking()`.  
4. **Repository** →  
   - Checks local cache (`DatabaseService`).  
   - Falls back to `ApiClient` if needed.  
   - Converts `BookingApiModel` → `Booking` entity.  
5. **Data** flows back up the chain to update the UI.

---

### **Why This Structure?**
- **Separation of Concerns**: Each layer has a single responsibility.  
- **Testability**: Mock services/repositories easily for unit tests.  
- **Scalability**: Add new data sources (e.g., GraphQL) without breaking ViewModels.  

