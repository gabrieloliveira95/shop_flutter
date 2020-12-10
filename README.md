# shop_flutter

## Application Focus:

### Data

- /Data/store.dart -> Using lib shared_preferences to save auth info locally

### Exceptions

- /Exceptions/auth_exception.dart -> Personalize Auth exceptions.
- /Exceptions/http_exception.dart -> Personalize API and Connection exceptions.

### Providers (Acess variables anywhere)

- /Providers/auth.dart -> Provider of user authenticate;
- /Providers/cart.dart -> Provider of items in cart;
- /Providers/orderes.dart -> Provider of orders;
- /Providers/product.dart -> Provider of product class;
- /Providers/products.dart -> Class Product receive product list and generate a copy of this list and notify when something change with Provider. Using Observer pattern;

### Utils

- /Utils/app_routes.dart -> Constants Routes to main.dart deal it;
- /Utils/constants.dart -> Constant URL to acess firebase;

### Views

- /Views/Auth_Home_Screen.dart -> FutureBuilder to select witch screen will be showed based on Auth Provider;
- /Views/Auth_Card.dart -> Subbmit User info to firebase;
- /Views/Badge.dart -> Badge to filter Products
- /Views/Cart_Item_Widget.dart -> Widget to create items in cart
- /Views/Order_Widget.dart -> Orders List Widget;
- /Views/Product_Grid_Item.dart -> Grid With Items to Edit Products;
- /Views/Product_Grid.dart -> Grid to Shop Products;
- /Views/Product_Item -> Product Widget; 

### Main

- /Main.dart -> Init Application and Define theme; 