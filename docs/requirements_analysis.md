
# E-Commerce Mobile App Technical Specification

## 1. Core Requirements

### User Interface (UI) Flow
1. **Authentication Flow**:
   - Onboarding screen (app introduction)
   - Sign up screen (email, password, basic info)
   - Login screen
   - Verification screen (email/OTP verification)
   - Forgot password screen
   - Reset password screen
   - Success screen (post successful actions)

2. **Main App Flow**:
   - Home screen (featured products, categories)
   - Product listing (grid/list view toggle)
   - Product details screen
   - Shopping cart screen
   - Checkout and invoice screen
   - Order status (Timeline) screen
   - Notification screen

## 2. Technical Architecture

### Frontend (Flutter)
**Recommended Packages**:
- `provider` or `flutter_bloc` for state management
- `dio` for API calls (with interceptors)
- `hive` for local storage (lightweight NoSQL)
- `intl` for formatting dates/currencies
- `cached_network_image` for image caching
- `flutter_svg` for vector assets

**Design Pattern**:
- MVVM (Model-View-ViewModel) architecture:
  - **Models**: Data structures/entities
  - **Views**: UI components
  - **ViewModels**: Business logic, state management
  - **Repositories**: Data layer abstraction

## 3. Platform-Specific Implementations

### Android:
- Material Design 3 components (`material3` flag enabled)
- Back button navigation handling (WillPopScope)
- Deep linking (Android App Links)
- Play Store billing integration (`in_app_purchase` package)

### iOS:
- Cupertino widgets for native feel
- Swipe-back gesture support (custom navigation)
- Apple Pay integration (`pay` package)
- App Store Connect compliance (privacy manifests)


---

## 4. Key Screens Implementation Details  

### **1. Authentication Flow**  

#### **1.1 Onboarding Screen**  
- **UI**:  
    - Horizontal `PageView` with 3-5 onboarding slides  
    - Animated illustrations (Lottie or SVG)  
    - Skip button (top-right) and dot indicators  
- **Functionality**:  
    - `shared_preferences` to track first-launch status  
    - Smooth page transitions with `PageController`  

#### **1.2 Sign Up Screen**  
- **Fields**:  
    - Email (with validation)  
    - Password (strength meter)  
    - Optional: Name, phone number  
- **UI**:  
    - Form validation (real-time)  
    - "Sign up with Google/Apple" buttons  
    - Link to Login screen  

#### **1.3 Login Screen**  
- **Fields**: 
    - Email
    - Password  
- **UI**:  
    - "Forgot Password?" link  
    - Social login options  
    - Error banners for invalid credentials  

#### **1.4 Verification Screen**  
- **OTP Input**:  
    - 6-digit `PinCodeTextField`  
    - Resend OTP button (with countdown timer)  
- **UI**:  
    - Success/error toast messages  
    - Auto-redirect on successful verification  

#### **1.5 Forgot Password Screen**  
- **Fields**: 
    - Email input  
- **UI**:  
  - "Send Reset Link" button  
  - Back-to-login link  

#### **1.6 Reset Password Screen**  
- **Fields**: 
    - New password + confirmation  
- **Validation**:  
  - Minimum length  
  - Match confirmation  

#### **1.7 Success Screen**  
- **UI**:  
  - Checkmark animation (Lottie)  
  - "Continue to Home" button  
  - Optional: Order confirmation for checkout flow  

---

### **2. Main App Flow**  

#### **2.1 Home Screen**  
- **Sections**:  
  - AppBar with search icon & cart badge  
  - Hero carousel (auto-scrolling banners)  
  - Category grid (2x4 layout)  
  - "Featured Products" horizontal list  
- **State**:  
  - `FutureBuilder` for async data loading  
  - `Bloc` for user preferences (e.g., dark mode)  

#### **2.2 Product Listing (Grid/List View)**  
- **Toggle**: Grid (2 columns) ↔ List (1 column)  
- **Filters**:  
  - Sort by (price, popularity)  
  - Price range slider  
- **Performance**:  
  - `ListView.builder` with lazy loading  
  - Image caching (`cached_network_image`)  

#### **2.3 Product Details Screen**  
- **Sections**:  
  - Image gallery (horizontal scroll)  
  - Title, price, ratings  
  - Variant selector (color/size)  
  - "Add to Cart" FAB  
  - TabBar: Description/Reviews  
- **UI**:  
  - `SliverAppBar` (collapsible header)  
  - Snackbar on cart addition  

#### **2.4 Shopping Cart Screen**  
- **List Items**:  
  - Swipe-to-delete (`Dismissible`)  
  - Quantity stepper (min/max limits)  
- **Summary**:  
  - Subtotal, shipping, taxes  
  - "Proceed to Checkout" button (disabled if empty)  

#### **2.5 Checkout & Invoice Screen**  
- **Steps**:  
  1. Shipping address (Google Places autocomplete)  
  2. Payment method (Card/Apple Pay/Google Pay)  
  3. Order review  
- **Invoice**:  
  - Printable PDF generation (`pdf` package)  
  - "Track Order" button  

#### **2.6 Order Status (Timeline)**  
- **UI**:  
  - `Stepper` widget with order stages  
  - Estimated delivery date  
  - Contact support button  

#### **2.7 Notification Screen**  
- **Types**:  
  - Order updates (real-time via Firebase)  
  - Promotions (time-bound)  
- **UI**:  
  - Group by date  
  - "Mark all as read" action  

---

### **Platform-Specific Enhancements**  

| **Component**          | **Android**                          | **iOS**                          |  
|-------------------------|--------------------------------------|----------------------------------|  
| **AppBar**              | Material 3 (dynamic color)           | CupertinoNavigationBar           |  
| **Back Navigation**     | Hardware back button                 | Swipe gesture                    |  
| **Dialogs**             | AlertDialog                         | CupertinoAlertDialog             |  
| **Payment**             | Google Pay                          | Apple Pay                        |  

---

## 5. State Management Approach

**Recommended Solution**: BLoC Pattern
- **ProductBloc**: Manages product listing, search, filtering
- **CartBloc**: Handles cart operations (add/remove/update)
- **AuthBloc**: Authentication state and user session
- **OrderBloc**: Checkout process and order tracking

**State Persistence**:
- Hydrate BLoCs from local storage on app start
- Sync with server when online

## 6. Data Storage Strategy

### Offline Mode:
- **Hive** boxes for:
  - Product cache (TTL 24 hours)
  - User cart (persistent)
  - Order history
- Connectivity-aware UI (offline banner)

### Online Mode (API Contracts):
```
GET /products
Params: page, limit, search, category
Response: {products: [], total: number}

POST /checkout
Body: {items: [], shippingAddress: {}, paymentMethod: string}
Response: {orderId: string, invoiceUrl: string}

GET /orders/:id
Response: {status: string, timeline: []}
```

## 7. Advanced Features Implementation

### Payment Integration:
- **Stripe**: `stripe_sdk` package
  - Card input form
  - Payment intent flow
- **Apple Pay/Google Pay**: Platform-specific implementations

### Real-time Sync:
- Firebase Firestore for:
  - Order status updates
  - Inventory changes
  - Admin notifications

## Development Milestones

1. **Week 1-2**: Auth flow + core UI components
2. **Week 3-4**: Product listing + cart functionality
3. **Week 5**: Checkout process + basic API integration
4. **Week 6**: Platform-specific polish + testing
5. **Week 7**: Advanced features (if time permits)
6. **Week 8**: QA, performance optimization, store submission

## Testing Strategy
- Widget tests for all UI components
- Integration tests for critical user flows
- Mock API responses for development
- Platform-specific testing on multiple devices