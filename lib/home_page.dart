import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Validações
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  String _validName;

  String addUserSucess;

  List<String> listParticipantes = [];
  List<int> listMarcados = [];

  CollectionReference formulario =
      FirebaseFirestore.instance.collection('formulario');

  Future<void> addUser() {
    // Add User
    return formulario
        .add({
          'nome': '$nome',
          'mensagem': '$mensagem',
          'numero': numeroEscolhido,
          'presente': '$presente',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  List<ListNumbers> listNumber = [];

  initNumbers() {
    for (var i = 0; i < 80; i++) {
      listNumber.add(
        ListNumbers(
          number: i + 1,
        ),
      );
    }

    setState(() {});
  }

  attNumbers() {
    for (var m in listMarcados) {
      listNumber[m - 1].marker = false;
    }
  }

  bool participacao = false;
  String nome = "";
  String mensagem = "";
  int numeroEscolhido;
  String presente = "";
// Recuperar participantes
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _participantes() async {
    db.collection('formulario').get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              listParticipantes.add(doc.data()['nome']);
            }));
    await _numerosSelecionados();

    setState(() {});
  }

  Future<void> _numerosSelecionados() async {
    await db.collection('formulario').get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              listMarcados.add(doc.data()['numero']);
            }));
    initNumbers();
    attNumbers();
  }

  @override
  void initState() {
    super.initState();
    _musicPlayer();

    _participantes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'images/casamento.jpg',
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          child: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              )
            ],
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            centerTitle: true,
            title: Text(
              'Chá de cozinha Keh e Mah',
              style: GoogleFonts.dancingScript(fontSize: 20),
            ),
          ),
          preferredSize: Size.fromHeight(
            50,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 255, 240, 0.5),
                      border: Border.all(
                        color: Colors.lightBlue[50],
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      'Seja bem-vindo(a)!  \nAo nosso chá de cozinha virtual para amigos e família!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                          fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 255, 240, 0.5),
                    border: Border.all(
                      color: Colors.lightBlue[50],
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    'Em meio a esses tempos difíceis que o Brasil '
                    'e o mundo estão vivendo, não poderemos nos '
                    'reunir para comemorar esse momento tão importante '
                    'em nossas vidas, pensando nisso, resolvemos inovar '
                    'e criar um chá de cozinha virtual para que você '
                    'familiar ou amigo, mesmo de longe, possa nos ajudar '
                    'a deixar nosso lar ainda mais completo. Convidamos '
                    'você a participar da nossa rifa e nos presentear '
                    'com um mimo de sua escolha',

                    // 'Em meio a esses tempos turbulentos que o Brasil e o mundo '
                    // 'estão vivendo, não poderiamos reunir vocês para comemorarmos'
                    // ' esse momento tão importante para nós, mas tambem não '
                    // 'queremos deixar isso passar em branco. Então resolvemos '
                    // 'inovar, e fazer algo diferente!'
                    // 'Se você é casado(a) sabe que o começo de um casamento começa '
                    // 'com dificuldades'
                    // ' pois é um fase nova, de responsabilidades e nem sempre o '
                    // 'casal pode ter tudo de início, então tudo que recebermos '
                    // 'será de muita ajuda!',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 255, 240, 0.5),
                    border: Border.all(
                      color: Colors.lightBlue[50],
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    ' Veja como vai funcionar:',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 255, 240, 0.5),
                    border: Border.all(
                      color: Colors.lightBlue[50],
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            '01) Escolha um número de 1 a 80 da rifa abaixo e preencha o formulário para participação.\n\n'
                            '02) Você tem até o dia 20/09/2020 para nos entregar um mimo de presente de chá de cozinha.\n\n'
                            '03) Você pode preencher opcionalmente a caixa de presente somente se quiser que saibamos o que você dará,\n'
                            'para nosso controle, dessa forma todos os itens que já ganhamos estarão anotados em um painel abaixo para '
                            'que as outras pessoas não comprem duas vezes a mesma coisa.\n\n'
                            '04) Se você não sabe o que comprar pode escolher uma das opções que colocamos no painel de idéias de presente, '
                            'que são todas as coisas que ainda não temos, tem coisas básicas, coisas mais caras, mas você pode comprar '
                            'conforme suas condições, pois tudo é necessário.\n\n'
                            '05) Você pode entregar via correio ou pessoalmente, na segunda opção faça o uso de máscara.\n\n'
                            '06) Os números em rosa já foram escolhidos por outra pessoa.\n\n'
                            '07) Ao escolher um número seu nome irá aparecer no painel de participantes confirmando sua participação.\n\n'
                            '08) No dia 20/09/2020 às 19hrs Faremos o Sorteio ao vivo da cesta, através do link: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black)),
                    TextSpan(
                        text: 'http://bit.ly/chaMaheKeh .\n\n ',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('http://bit.ly/chaMaheKeh');
                          }),
                    TextSpan(
                      text:
                          '09) Irei disponibilizar também um vídeo de abertura dos presentes e agradecimentos no dia do sorteio.\n\n',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    )
                  ])),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Numerações Rifa',
                      style: GoogleFonts.dancingScript(
                          fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 10,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    children: listNumber
                        .map((item) => item.botton())
                        .toList()
                        .cast<Widget>(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Formulário para participação',
                              style: GoogleFonts.dancingScript(
                                  fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedCrossFade(
                    firstChild: _formulario(),
                    secondChild: _sucessCadastro(),
                    crossFadeState: participacao == false
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(seconds: 1)),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Idéias de Presente',
                      style: GoogleFonts.dancingScript(
                          fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  color: Color.fromRGBO(239, 242, 249, 0.5),
                  child: Column(
                    children: [
                      Text(
                        '0. SURPRESAS !\n'
                        '1. Escorredor arroz/macarrão\n'
                        '2̶.̶ ̶C̶o̶p̶o̶ ̶m̶e̶d̶i̶d̶o̶r̶\n'
                        '3. Jogo de panelas\n'
                        '4. Jogo de Canecas\n'
                        '5̶̶̶.̶̶̶ ̶J̶̶̶o̶̶̶g̶̶̶o̶̶̶ ̶d̶̶̶e̶̶̶ ̶p̶̶̶r̶̶̶a̶̶̶t̶̶̶o̶̶̶s̶̶̶\n'
                        '6. Assadeiras\n'
                        '7. Lasanheira\n'
                        '8̶.̶ ̶B̶a̶t̶e̶d̶o̶r̶ ̶m̶a̶n̶u̶a̶l̶\n'
                        '9̶.̶ ̶C̶o̶l̶h̶e̶r̶ ̶d̶e̶ ̶p̶a̶u̶\n'
                        '1̶0̶.̶ ̶P̶a̶n̶e̶l̶a̶ ̶d̶e̶ ̶p̶r̶e̶s̶s̶ã̶o̶\n'
                        '1̶1̶.̶ ̶C̶o̶n̶j̶u̶n̶t̶o̶ ̶d̶e̶ ̶c̶o̶l̶h̶e̶r̶e̶s̶\n'
                        '12. Cortador de pizza\n'
                        '13. Concha de sorvete\n'
                        '14. Descascador de legumes\n'
                        '15. Escorredor de louça de metal\n'
                        '16. Escumadeiras anti-aderente\n'
                        '17. Frigideira anti-aderente\n'
                        '1̶8̶.̶ ̶G̶a̶r̶r̶a̶f̶a̶ ̶t̶é̶r̶m̶i̶c̶a̶\n'
                        '19. Jogos americanos\n'
                        '20. Varal de peças pequenas\n'
                        '2̶1̶.̶ ̶L̶u̶v̶a̶ ̶t̶é̶r̶m̶i̶c̶a̶\n'
                        '2̶2̶.̶ ̶P̶r̶a̶t̶o̶s̶ ̶d̶e̶ ̶s̶o̶b̶r̶e̶m̶e̶s̶a̶\n'
                        '23. Batedeira\n'
                        '2̶4̶.̶ ̶P̶o̶r̶t̶a̶ ̶f̶r̶i̶o̶s̶\n'
                        '25. Porta temperos\n'
                        '26. Puxa saco\n'
                        '2̶7̶.̶ ̶E̶s̶p̶r̶e̶m̶e̶d̶o̶r̶ ̶d̶e̶ ̶f̶r̶u̶t̶a̶s̶\n'
                        '2̶8̶.̶ ̶S̶a̶n̶d̶u̶i̶c̶h̶e̶i̶r̶a̶\n'
                        '29. Taças\n'
                        '3̶0̶.̶ ̶T̶a̶b̶o̶a̶ ̶d̶e̶ ̶c̶a̶r̶n̶e̶\n'
                        '31. Tigela de vidro\n'
                        '32. Jarra de água/suco\n'
                        '33. Lixeiras\n'
                        '34. Ralador\n'
                        '35. Faqueiro\n'
                        '3̶6̶.̶ ̶F̶r̶u̶t̶e̶i̶r̶a̶\n'
                        '3̶7̶.̶ ̶J̶o̶g̶o̶ ̶d̶e̶ ̶p̶o̶t̶e̶s̶\n'
                        '38. Pipoqueira\n'
                        '39. Passadeira de roupa\n'
                        '40. Tapower\n'
                        '41. Peneiras\n'
                        '4̶2̶.̶ ̶S̶a̶l̶e̶i̶r̶o̶\n'
                        '43. Airfryer\n',
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Informações Importantes',
                      style: GoogleFonts.dancingScript(
                          fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Color.fromRGBO(239, 242, 249, 0.5),
                  margin: EdgeInsets.fromLTRB(40, 20, 40, 30),
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
                  child: Center(
                    child: Text(
                      'Data limite de entrega: 20/09/2020\n'
                      'Data dos sorteios: 20/09/2020\n'
                      'Prêmios: 1 sorteios de 1 cestas de café da manhã no '
                      'valor de 80 reais ou o valor em dinheiro.\n'
                      'Endereço para entrega: Rua Mariano Ravali'
                      ' nº 164 - Residencial Vila Romana - Londrina PR. CEP: 86031826',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text(
                      'Participantes',
                      style: GoogleFonts.dancingScript(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height * .4,
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                  color: Color.fromRGBO(239, 242, 249, 0.5),
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
                  child: ListView.builder(
                    itemCount: listParticipantes.length,
                    itemBuilder: (context, index) {
                      return Center(child: Text('${listParticipantes[index]}'));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sucessCadastro() {
    return AnimatedContainer(
      height: 290,
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.center,
      duration: Duration(seconds: 4),
      color: Color.fromRGBO(239, 242, 249, 0.8),
      margin: EdgeInsets.fromLTRB(40, 20, 40, 30),
      padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
      child: Center(
        child: Text(
          'PARTICIPAÇÃO REGISTRADA !\n'
          'Matheus e Kemily Agradece sua participação <3',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      color: Color.fromRGBO(239, 242, 249, 0.5),
      margin: EdgeInsets.fromLTRB(40, 20, 40, 30),
      padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
      child: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerNome,
                onChanged: (value) => nome = value,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  labelText: 'Nome',
                ),
                validator: (value) => _validName,
              ),
              TextFormField(
                controller: _controllerNumero,
                keyboardType: TextInputType.number,
                onChanged: (value) => numeroEscolhido = int.parse(value),
                decoration: InputDecoration(
                  hintText: 'Número',
                  labelText: 'Número',
                ),
              ),
              TextFormField(
                onChanged: (value) => mensagem = value,
                decoration: InputDecoration(
                  hintText: 'Mensagem/Comentário: (opcional)',
                  labelText: 'Mensagem',
                ),
              ),
              TextFormField(
                onChanged: (value) => presente = value,
                decoration: InputDecoration(
                  hintText: 'Pressente: (opcional)',
                  labelText: 'Presente(opcional)',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  5,
                ),
                child: FlatButton(
                  color: Colors.pinkAccent[100],
                  onPressed: () {
                    if (_controllerNome.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("Erro"),
                              content: Text("Você deve Preencher o Nome"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ]);
                        },
                      );
                    } else if (_controllerNumero.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("Erro"),
                              content: Text('É preciso escolher uma número\n'
                                  'que não esteja em rosa'),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ]);
                        },
                      );
                    } else if (_controllerNumero.text != '' &&
                        // ignore: unrelated_type_equality_checks
                        _controllerNome != '') {
                      addUser();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text(
                                "Parabéns",
                                style: TextStyle(color: Colors.green),
                              ),
                              content: Text(
                                "Participação Cadastrada",
                                style: TextStyle(color: Colors.green),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      _controllerNome.clear();
                                      _controllerNumero.clear();
                                      setState(() {
                                        participacao = true;
                                      });

                                      Navigator.pop(context);
                                    })
                              ]);
                        },
                      );
                    }
                  },
                  child: Text('Participar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListNumbers {
  int number;
  bool marker;
  ListNumbers({this.number, this.marker});

  botton() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: marker == false ? Colors.pink : Colors.white,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

Future<void> _musicPlayer() {
  AudioElement()
    ..src =
        'https://drive.google.com/u/0/uc?id=1IfQcX82T9XVtCJJFyi9qh0FSH6m7ZYUa&export=download'
    ..autoplay = true;
}
