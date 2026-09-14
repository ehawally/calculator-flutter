import 'package:flutter/material.dart';
import 'botoes.dart';
class CalculadoraHomepage extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const CalculadoraHomepage({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<CalculadoraHomepage> createState() => _CalculadoraHomepageState();
}

class _CalculadoraHomepageState extends State<CalculadoraHomepage> {
  String numero1= "";
  String operador = "";
  String numero2= "";
  
  
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
         children: [
          Align(
           alignment: Alignment.topRight,
            child: IconButton(
        onPressed: widget.onThemeChanged,
        icon: const Icon(Icons.light_mode),
      ),
    ),

    // resultado[
          // resultado
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "$numero1$operador$numero2".isEmpty? "0": "$numero1$operador$numero2",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // botoes
          Wrap(
            children: Botoes.buttonValues.map(
              (value) => SizedBox(
                width: value == Botoes.n0? screenSize.width/2: (screenSize.width/4),
                height: screenSize.height/8,
                child: buildButton(value)))
                .toList(),
          )
        ]),
      ),
    );
  }


  
  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: Color(0x3CFFFFFF),width: 1)),
        child: InkWell(
          onTap:() =>onBtnpTap(value),
          child: Center(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
        ),
      ),
    );
  }
 void onBtnpTap(String value) {
  if (value== Botoes.del){
    delete();
    return;
  }
  if(value == Botoes.clr){
    clearAll();
    return;
  }
  if (value== Botoes.per){
    convertToPercentage();
    return;
  }
  if(value==Botoes.calculate){
    calculate();
    return;
  }
  appendValue(value);
}

void calculate(){
  if (numero1.isEmpty) return;
   if (operador.isEmpty) return;
   if (numero2.isEmpty) return;

  final double num1 = double.parse(numero1);
  final double num2 = double.parse(numero2);
  var resultado= 0.0;
  switch (operador) {
    case Botoes.add:
      resultado = num1 + num2;
      break;
      case Botoes.subtract:
      resultado= num1 - num2;
      break;
       case Botoes.multiply:
      resultado= num1 * num2;
      break;
      case Botoes.divide:
      resultado= num1 / num2;
      break;
      default:
  }
  setState((){
    numero1 = "$resultado";
    if(numero1.endsWith(".0")){
      numero1= numero1.substring(0, numero1.length-2);
    }
    operador ="";
    numero2 ="";
  });
}
void convertToPercentage(){
  if (numero1.isNotEmpty&&operador.isNotEmpty&&numero2.isNotEmpty){
    calculate();
  }
  if (operador.isNotEmpty){
    return;
  }
  final numero= double.parse(numero1);
  setState(() {
    numero1= "${(numero/100).toString()}";
    operador="";
    numero2="";
  });
}

void clearAll(){
  setState((){
    numero1="";
    operador="";
    numero2="";
  });
}

void delete(){
  if(numero2.isNotEmpty){
    numero2=numero2.substring(0, numero2.length-1);
  } else if(operador.isNotEmpty){
    operador= "";
  }else if (numero1.isNotEmpty){
    numero1=numero1.substring(0, numero1.length-1);
  }
  setState(() {});
}
void appendValue( String value){
  
  if (value != Botoes.dot && int.tryParse(value) == null) {

    if (operador.isNotEmpty && numero2.isNotEmpty) {
    calculate();
    }

    setState(() {
      operador = value;
    });

  } else if (numero1.isEmpty || operador.isEmpty) {

    if (value == Botoes.dot && numero1.contains(Botoes.dot)) return;

    if (value == Botoes.dot &&
        (numero1.isEmpty || numero1 == Botoes.n0)) {
      value = "0.";
    }

    setState(() {
      numero1 += value;
    });

  } else {

    if (value == Botoes.dot && numero2.contains(Botoes.dot)) return;

    if (value == Botoes.dot &&
        (numero2.isEmpty || numero2 == Botoes.n0)) {
      value = "0.";
    }

    setState(() {
      numero2 += value;
    });
  }
  
}
  Color getButtonColor(value){
  return[Botoes.del, Botoes.clr].contains(value)
        ?Color(0xFFC5A7FF):
        [Botoes.per ,
        Botoes.multiply ,
        Botoes.add,
        Botoes.subtract,
        Botoes.divide,
        Botoes.calculate]
        .contains(value)
        ?Color(0xFF83CFFF): Color(0xFF1A1A26);
  }

}