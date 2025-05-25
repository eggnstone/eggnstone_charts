import 'package:flutter_test/flutter_test.dart';

void main()
{
    test('Dart Dummy', ()
        {
            expect(true, isTrue);
        }
    );

    testWidgets('Flutter Dummy', (WidgetTester tester)
        async
        {
            expect(true, isTrue);
        }
    );
}
