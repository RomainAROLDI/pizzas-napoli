import 'package:go_router/go_router.dart';
import 'screens/master_screen.dart';
import 'screens/details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MasterScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) =>
          DetailsScreen(pizzaId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
