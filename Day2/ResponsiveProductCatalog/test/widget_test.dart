import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_product_catalog/main.dart';

void main() {
  testWidgets('Catalog app shows title and search', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResponsiveProductCatalogApp());

    expect(find.text('Product Catalog'), findsOneWidget);
    expect(find.text('Products found: 6'), findsOneWidget);
    expect(find.text('Search products'), findsOneWidget);
  });
}
