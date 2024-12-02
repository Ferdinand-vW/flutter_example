///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:provider/provider.dart';

class GeneratePoem {
  GeneratePoem(this.index);
  int index;
}

class GeneratePoemProgress {
  GeneratePoemProgress(this.peomText, this.isComplete);
  final String peomText;
  final bool isComplete;
}

class MyAppState extends ChangeNotifier {
  MyAppState(this.worker);
  final controller = GifController(
    autoPlay: false,
    loop: true,
    inverted: false,
    onStart: () {

    },
    onFinish:() {

    },
    onFrame:(int) {

    }
  );
  var rng = Random();
  var current = "";
  var gif = AssetImage("assets/images/SintGifV4.gif");
  var img = AssetImage("assets/images/SintStatic.png");
  var imgSource = AssetImage("assets/images/SintStatic.png");
  bool isGeneratingPoem = false;
  static final list = [
    poem1,
    poem2,
    poem3,
    poem4,
    poem5,
    poem6,
    poem7,
    poem8,
    poem9,
    poem10,
    poem11,
    poem12,
    poem13,
    poem14,
    poem15,
    poem16,
    poem17,
    poem18,
    poem19,
    poem20
  ];

  Worker worker;

  void onStart() {

  }

  void onFinish() {

  }

  void onFrame(int i) {
    // return i;
  }

  void progressHandler(dynamic data, SendPort isolateSendPort) {
    if (data is GeneratePoemProgress) {
      current = data.peomText;
      isGeneratingPoem = !data.isComplete;
      if (data.isComplete) {
        imgSource = img;
        controller.stop();
        controller.seek(0);
      }
      notifyListeners();
    }
  }

  static newPoemHandler(
      dynamic data, SendPort mainSendPort, SendErrorFunction sendError) async {
    if (data is GeneratePoem) {
      final fullText = list[data.index];
      final iterations = 5000 / 200;
      final charCount = (fullText.length / iterations).ceil();
      var count = 0;

      Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (count < fullText.length) {
          int textCount = min(count + charCount, fullText.length);

          bool isComplete = textCount == fullText.length;
          mainSendPort.send(GeneratePoemProgress(
              fullText.substring(0, textCount), isComplete));
          count = textCount;
        } else {
          timer.cancel();
        }
      });
    }
  }

  void getRandom() {
    worker.sendMessage(GeneratePoem(rng.nextInt(list.length)));
    controller.play();
  }
}

class NewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewScreenState();
}

class NewScreenState extends State<NewScreen> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      backgroundColor: Color(0xff30325b),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: 330,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child:

                    ///***If you have exported images you must have to copy those images in assets/images directory.
                    Image(
                  image: AssetImage("assets/images/SintGPTV5.png"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
                padding: EdgeInsets.all(0),
                width: 300,
                height: 125,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: Text(
                  "Hey Meinte!\nJe bent nog niet lang in ons midden, dus er valt nog veel over je te leren. Daarom heb ik de rest van dit gedicht, met ChatGPT laten automatiseren:",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xfffef4d1),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                padding: EdgeInsets.all(0),
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (!appState.isGeneratingPoem) {
                      appState.getRandom();
                      // appState.imgSource = appState.gif;
                      appState.controller.play();
                    }
                  },
                  color: Color(0xffea313a),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Color(0xffffd76d), width: 3),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "GENERATE",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: Color(0xffffffff),
                  height: 40,
                  minWidth: 140,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                padding: EdgeInsets.all(0),
                width: 155,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child:
                  GifView.asset("assets/images/SintGifV5.gif",
                  height: 180,
                  width: 140,
                  fit: BoxFit.cover,
                  controller: appState.controller
                    ///***If you have exported images you must have to copy those images in assets/images directory.
                  //   Image(
                  // image: appState.imgSource,
                  // height: 100,
                  // width: 140,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                padding: EdgeInsets.all(0),
                width: 300,
                height: 265,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: Text(
                  appState.current,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xfffef5d2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final poem1 =
    "Je hoofd draait altijd, nooit stil,\nMet een creatief brein dat alles kan.\nAls studio lead ben je de baas,\nMet je plannen geef jij gas.\n\nFietsen door Haarlem, zo fijn,\nJe houdt van de vrijheid, altijd klein.\nSkiën in de bergen geeft je rust,\nEn camperen is jouw ultieme lust.\n\nMet veel liefs gemaakt door SintGPT";
final poem2 =
    "In Haarlem woon je, stijlvol en snel,\nMet het yuppenleven voel je je wel.\nFietsen door de stad, altijd in de weer,\nSkiën en camperen maakt alles keer op keer.\n\nAls studio lead geef je de richting aan,\nMet je creatief brein ga jij vooraan.\nMooie dingen maken, dat is je kracht,\nMet passie en energie tot diep in de nacht.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem3 =
    "Je leeft in Haarlem, het yuppenleven is fijn,\nMet de fiets door de stad, altijd op je eigen lijn.\nSkiën en camperen zijn je ultieme vreugd,\nAltijd op zoek naar avontuur, altijd geheugd.\n\nAls studio lead stuur je mensen met flair,\nJe hoofd blijft draaien, ideeën keer op keer,\nMooie dingen maken, dat is jouw doel,\nMet creativiteit ben jij altijd in je rol.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem4 =
    "Je hoofd nooit stil, altijd in actie,\nAls studio lead is het jouw tactiek.\nMooie dingen maken is je kracht,\nMet passie die nooit uit het zicht is gebracht.\n\nFietsen en skiën, dat is jouw flow,\nCamperend voel je je een pro.\nHaarlem is jouw thuis, jouw domein,\nAltijd in beweging, nooit alleen.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem5 =
    "Je creativiteit kent geen grens,\nAls studio lead leid je altijd met een sens.\nMet een hoofd vol ideeën, altijd in de weer,\nJe blijft scherp, keer op keer.\n\nFietsen door Haarlem, zo heerlijk licht,\nSkiën en camperen zijn jouw gezicht.\nMooie dingen maken, dat is wat je doet,\nEn met passie geef je altijd moed.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem6 =
    "Mooie dingen maken, dat is jouw gave,\nCreatief en gedreven, altijd in je nave.\nAls studio lead geef je de toon aan,\nMet een hoofd dat nooit in rust kan gaan.\n\nFietsen door Haarlem, altijd op tijd,\nSkiën en camperen geven je vrijheid.\nJij blijft vooruitgaan, altijd in de vaart,\nJe energie en passie zijn nooit gekaard.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem7 =
    "Jij leeft in Haarlem, een stad zo fijn,\nFietsen en skiën, altijd in je lijn.\nAls studio lead ben jij de kracht,\nLeiderschap dat altijd goed wacht.\n\nCreatieve ideeën komen snel,\nMet de camper zoek je de natuur wel.\nMooie dingen maken, dat is jouw rol,\nAltijd met passie, altijd met goal.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem8 =
    "Creatief en vol passie, dat ben jij,\nAls studio lead ben je altijd blij.\nMensen sturen doe je met flair,\nJij weet altijd het juiste klaar.\n\nFietsen door Haarlem, zo rustig en fijn,\nSkiën in de bergen, met de juiste lijn.\nCamperen maakt je vrij, zo puur,\nJe leeft je leven met een avontuurlijke muur.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem9 =
    "Haarlem is waar je woont, vol yuppenleven,\nMet fietsen door de stad voel je je verheven.\nSkiën in de bergen geeft je vrijheid,\nCamperen maakt je gelukkig, zonder spijt.\n\nAls studio lead leid je met stijl,\nMet creativiteit blijf je altijd in de wijl.\nMooie dingen maken is jouw ding,\nMet passie en werk weet je altijd te brengen.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem10 =
    "Jij maakt mooie dingen, dat is zeker,\nMet een creatief brein, altijd de maker.\nAls studio lead stuur jij je team,\nMet visie, daadkracht en een heldere stream.\n\nFietsen door Haarlem is jouw fijne rit,\nSkiën en camperen geven je pit.\nJe hoofd blijft draaien, nooit in rust,\nMet passie creëer je altijd een must.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem11 =
    "In Haarlem voel je je altijd fijn,\nMet je fiets en ski’s, ben je altijd in lijn.\nDe camper brengt je overal heen,\nMet avontuur voel je je nooit alleen.\n\nAls studio lead ben je altijd scherp,\nJe leidt je team met heel veel werk.\nMooie dingen maken is jouw talent,\nEn met passie blijf je altijd relevant.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem12 =
    "Jouw yuppenleven in Haarlem is fijn,\nAltijd in beweging, nooit in de lijn.\nSkiën in de bergen, de lucht zo fris,\nCamperen in de natuur, echt je bliss.\n\nAls studio lead stuur jij het schip,\nMet ideeën die vloeien als een dynamisch ritme.\nMooie dingen maken, dat is jouw kracht,\nCreatief en gedreven, naar een nieuw idee op jacht.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem13 =
    "Haarlem is de plek waar je woont,\nMet je fiets en ski’s voel je je groot.\nJe hoofd draait altijd, nooit te moe,\nMet passie maak je alles goed.\n\nAls studio lead ben je een aanvoerder,\nJe stuurt mensen met kracht, als een broeder.\nMooie dingen maken is waar je voor leeft,\nCreatief en gedreven, altijd verheft.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem14 =
    "Het yuppenleven is waar jij voor leeft,\nIn Haarlem voel je je echt verheven.\nFietsen en skiën maken je gelukkig,\nCamperen in de natuur is je beste truc.\n\nAls studio lead ben je een professional,\nMet visie en daadkracht blijft alles altijd normaal.\nMooie dingen maken is waar je van houdt,\nCreatief en gedreven, met een hart nooit koud.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem15 =
    "In Haarlem, het yuppenleven is fijn,\nMet fiets en ski’s voel je je nooit klein.\nSkiën in de bergen maakt je gelukkig,\nCamperen brengt je rust, keer op keer, zo verrukkelijk.\n\nAls studio lead ben je altijd in actie,\nLeidinggeven met passie, nooit zonder tactie.\nMooie dingen maken is waar je van houdt,\nCreatief blijven, dat maakt je altijd vertrouwd.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem16 =
    "Je hoofd zit vol, altijd in de weer,\nAls studio lead stuur je mensen keer op keer.\nCreatieve ideeën brengen jou ver,\nMooie dingen maken, ben jij de ster.\n\nSkiën in de bergen geeft je veel kracht,\nFietsen door Haarlem, dag en nacht.\nMet de camper voel je je vrij,\nAltijd op avontuur, dat maakt je blij.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem17 =
    "Als studio lead ben jij de baas,\nMet je hoofd vol ideeën, nooit in de haak.\nMensen aansteken is wat jij goed doet,\nMet creativiteit en energie, zin in je bloed.\n\nFietsen door Haarlem geeft je rust,\nSkiën en camperen zijn jouw lust.\nMooie dingen maken is jouw taak,\nMet passie werken doe jij vaak.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem18 =
    "Je woont in Haarlem, een stad zo fijn,\nMet je fiets voel je je nooit klein.\nSkiën en camperen zijn je grote dromen,\nAvontuur zoeken, altijd in de komen.\n\nAls studio lead stuur jij je team,\nMet creativiteit en een helder systeem.\nMooie dingen maken is waar je van houdt,\nMet passie en energie blijf je altijd vertrouwt.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem19 =
    "Haarlem is jouw thuis, je voelt je daar fijn,\nMet fiets en ski’s, altijd in de lijn.\nCreatieve ideeën stromen door je brein,\nAls studio lead leid jij altijd het sein.\n\nMooie dingen maken is jouw drive,\nMet passie blijf je altijd alive.\nCamperen in de natuur geeft je rust,\nAltijd op zoek naar avontuur, altijd een lust.\n\nMet veel liefs gemaakt door SintGPT\n";
final poem20 =
    "In Haarlem voel jij je thuis, het yuppenleven is hier,\nFietsen door de stad, altijd in je sfeer.\nSkiën in de bergen, dat is jouw ding,\nCamperen maakt je gelukkig, dat is wat je brengt.\n\nAls studio lead geef jij de richting aan,\nMet creativiteit maak je alles waar.\nMooie dingen maken, dat is jouw drive,\nMet passie voor werk blijf je altijd alive.\n\nMet veel liefs gemaakt door SintGPT\n";
