import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/foundation.dart';

// ignore: avoid_relative_lib_imports
import 'package:frontend/main.dart' as app;

void main()
{

  
  group('end-to-end test', (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("authentication feature test", (tester) async{
      app.main();
      await tester.pumpAndSettle();
    final Finder signInusernameField = find.byKey(Key('signInUsernameField'));
    final Finder signInPasswordField = find.byKey(Key('signInPasswordField'));
    final Finder signInSaveButton = find.byKey(Key('Sign in'));


  
    await tester.pumpAndSettle();
    
    await tester.tap(find.byKey(Key('signInUsernameField')));
    await tester.enterText(signInusernameField, "test");

    await tester.tap(signInPasswordField);
    await tester.enterText(signInPasswordField, "123456");

    await tester.tap(signInSaveButton);
   

    
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(1+1,equals(4));

    });
    testWidgets("Post feature test",(tester) async{
      app.main();
    await tester.pumpAndSettle();
    final Finder number = find.byKey(Key('number'));
    final Finder description = find.byKey(Key('description'));
    final Finder postedIN = find.byKey(Key('Posted'));

    await tester.pumpAndSettle();
    
    await tester.tap(find.byKey(Key('number')));
    await tester.enterText(number, "2");

    await tester.tap(description);
    await tester.enterText(description, "it is a blue color work");

    await tester.tap(postedIN);
   

    
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(1+1,equals(4));


    });
    

    testWidgets("Profile feature test",(tester) async{
      app.main();
    await tester.pumpAndSettle();
    final Finder number = find.byKey(Key('location'));
    final Finder bio = find.byKey(Key('bio'));
    final Finder editedIN = find.byKey(Key('Edited'));

    await tester.pumpAndSettle();
    
    await tester.tap(find.byKey(Key('location')));
    await tester.enterText(number, "Addis Abeba");

    await tester.tap(bio);
    await tester.enterText(bio, "it is a blue color work");

    await tester.tap(editedIN);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(1+1,equals(4));


    });
    

  });
}
