import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_4/main.dart';
void main() {
  testWidgets('campo monetário repassa a entrada ao cálculo', (tester) async {
    final controller=TextEditingController();
    addTearDown(controller.dispose);
    String received='';
    await tester.pumpWidget(MaterialApp(home:Scaffold(body:buildTextField('Reais','R\$',controller,(text)=>received=text))));
    await tester.enterText(find.byType(TextField),'12.50');
    expect(received,'12.50');
    expect(controller.text,'12.50');
  });
}
