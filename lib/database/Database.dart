/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


// Class definition
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  // Singleton Database instance
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  // Enable SQLITE foreign keys
  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  // Insert initial data

  _insertInitialData(Database db) async {
    String createdAt = DateTime.now().toIso8601String();


    // Insert Exercises
    await db.insert('exercise', {"id": 1, "name": "Sentadilla Estandar", "img_path": "sentadilla_estandar.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros y los dedos ligeramente hacia afuera.\nDesciende: Baja el cuerpo flexionando las rodillas, sin que estas sobrepasen las puntas de los pies y empujando las caderas hacia atrás como si fueras a sentarte. Mantén la espalda recta y el pecho levantado.\nSube: Vuelve a la posición inicial empujando con los talones y apretando los glúteos.", "created_at": createdAt});
    await db.insert('exercise', {"id": 2, "name": "Sentadilla Con Salto", "img_path": "sentadilla_con_salto.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros y los dedos ligeramente hacia afuera.\nDesciende: Baja el cuerpo flexionando las rodillas, sin que estas sobrepasen las puntas de los pies y empujando las caderas hacia atrás, como si fueras a sentarte. Mantén la espalda recta y el pecho levantado.\nSalta y aterriza: Desde la posición de sentadilla, impúlsate con fuerza a través de los talones y salta verticalmente lo más alto que puedas. Aterriza suavemente sobre las puntas de los pies y baja inmediatamente a la posición de sentadilla para repetir.", "created_at": createdAt});
    await db.insert('exercise', {"id": 3, "name": "Sentadilla Sumo", "img_path": "sentadilla_sumo.png", "description": "Posición inicial: Ponte de pie con los pies más  separados que el ancho de los hombros y los dedos apuntando hacia afuera.\nDesciende: Baja el cuerpo flexionando las rodillas, sin que estas sobrepasen las puntas de los pies y empujando las caderas hacia atrás como si fueras a sentarte. Mantén la espalda recta y el pecho levantado.\nSube: Vuelve a la posición inicial empujando con los talones y apretando los glúteos.", "created_at": createdAt});
    await db.insert('exercise', {"id": 4, "name": "Zancadas", "img_path": "zancadas.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Da un paso al frente con una pierna, manteniendo la espalda recta y el pecho levantado.\nDesciende: Baja el cuerpo flexionando ambas rodillas hasta que la rodilla de la pierna de atrás quede justo por encima del suelo y la rodilla de la pierna de adelante forme un ángulo de 90 grados.\nSube: Vuelve a la posición inicial empujando con el talón de la pierna de adelante. Repite con la otra pierna.", "created_at": createdAt});
    await db.insert('exercise', {"id": 5, "name": "Zancada Lateral", "img_path": "zancada_lateral.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros.\nDesciende: Da un paso hacia un lado con una pierna, flexionando esa rodilla mientras mantienes la otra pierna recta. Mantén la espalda recta y el pecho levantado.\nSube: Vuelve a la posición inicial empujando con el talón de la pierna que se flexionó. Repite hacia el otro lado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 6, "name": "Sentadilla Búlgara", "img_path": "sentadilla_bulgara.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de las caderas. Coloca un pie detrás de ti en un banco o superficie elevada, con los dedos apoyados.\nDesciende: Baja el cuerpo flexionando ambas rodillas hasta que la rodilla de la pierna de atrás quede justo por encima del suelo y la rodilla de la pierna de adelante forme un ángulo de 90 grados.\nSube: Vuelve a la posición inicial empujando con el talón de la pierna de adelante. Repite con la otra pierna.", "created_at": createdAt});
    await db.insert('exercise', {"id": 7, "name": "Elevación De Talon", "img_path": "elevacion_de_talon.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Puedes apoyarte ligeramente en una pared o silla para mantener el equilibrio.\nElevación: Levanta lentamente los talones del suelo, poniéndote de puntillas. Mantén el cuerpo recto y el abdomen contraído.\nDescenso: Baja lentamente los talones hasta el suelo. Repite el movimiento.", "created_at": createdAt});
    await db.insert('exercise', {"id": 8, "name": "Puente Femoral", "img_path": "puente_femoral.png", "description": "Posición inicial: Túmbate boca arriba con las rodillas flexionadas y los pies apoyados en el suelo, separados a la anchura de las caderas. Los brazos pueden estar a los lados del cuerpo con las palmas hacia abajo.\nElevación: Aprieta los glúteos y levanta las caderas del suelo hasta que tu cuerpo forme una línea recta desde los hombros hasta las rodillas. Mantén la posición por un momento, contrayendo los glúteos en la parte superior.\nDescenso: Baja lentamente las caderas hasta la posición inicial. Repite el movimiento.", "created_at": createdAt});
    await db.insert('exercise', {"id": 9, "name": "Plancha Lateral Con Elevación De Pierna", "img_path": "plancha_lateral_con_elevacion_de_pierna.png", "description": "Posición inicial: Túmbate de lado con las piernas extendidas y apiladas. Apoya el antebrazo debajo del hombro, asegurando que el cuerpo esté en línea recta.\nElevación: Contrae el abdomen y levanta las caderas del suelo, manteniendo el cuerpo en línea recta.\nElevación de pierna: Una vez en la plancha lateral, levanta la pierna superior hacia el techo, manteniendo la rodilla recta. Baja lentamente la pierna y repite. Luego, cambia de lado y repite los pasos con la otra pierna.", "created_at": createdAt});
    await db.insert('exercise', {"id": 10, "name": "Sentadilla Profunda", "img_path": "sentadilla_profunda.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Los dedos de los pies deben apuntar ligeramente hacia afuera. Mantén la espalda recta, el pecho levantado.\nDescenso: Flexiona las rodillas y baja las caderas como si fueras a sentarte, pero continúa descendiendo hasta que tus muslos queden por debajo del nivel de tus rodillas. Mantén la espalda recta y el pecho levantado durante todo el movimiento.\nAscenso: Empuja con los talones para volver a la posición inicial, extendiendo las rodillas y las caderas.", "created_at": createdAt});
    await db.insert('exercise', {"id": 11, "name": "Zancada Caminando", "img_path": "zancada_caminando.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Mantén la espalda recta y el pecho levantado.\nPaso y descenso: Da un paso largo hacia adelante con una pierna. Flexiona ambas rodillas hasta que la rodilla de la pierna de atrás quede justo por encima del suelo y la rodilla de la pierna de adelante forme un ángulo de 90 grados.\nContinuación: Impúlsate con el talón de la pierna de adelante para volver a la posición inicial y luego repite el movimiento con la otra pierna, alternando los pasos.", "created_at": createdAt});
    await db.insert('exercise', {"id": 12, "name": "Sentadilla Con Pies Juntos", "img_path": "sentadilla_con_pies_juntos.png", "description": "Posición inicial: Ponte de pie con los pies juntos y los brazos extendidos hacia adelante para ayudarte a mantener el equilibrio. Mantén la espalda recta y el pecho levantado.\nDescenso: Flexiona las rodillas y baja lentamente el cuerpo como si fueras a sentarte. Mantén la espalda recta y el pecho levantado durante todo el movimiento.\nAscenso: Empuja con los talones para volver a la posición inicial, extendiendo las rodillas y las caderas.", "created_at": createdAt});
    await db.insert('exercise', {"id": 13, "name": "Salto En Caja", "img_path": "salto_en_caja.png", "description": "Posición inicial: Ponte de pie frente a un cajón o plataforma resistente. Los pies deben estar separados a la anchura de los hombros y los brazos a los lados del cuerpo. La distancia entre tú y el cajón debe ser tal que puedas saltar cómodamente sin golpearte las rodillas al subir.\nSalto: Flexiona ligeramente las rodillas y balancea los brazos hacia atrás para generar impulso. Luego, impúlsate con fuerza con ambos pies y salta hacia el cajón. Intenta aterrizar suavemente en el centro del cajón con las rodillas ligeramente flexionadas como en sentadilla.\nDescenso: Una vez que estés sobre el cajón, ponte de pie completamente. Luego, baja del cajón y repites el ejercicio.", "created_at": createdAt});
    await db.insert('exercise', {"id": 14, "name": "Flexiones Normales", "img_path": "flexiones_normales.png", "description": "Posición inicial: Colócate boca abajo en el suelo con las manos apoyadas a la anchura de los hombros y los dedos apuntando hacia adelante. Eleva el cuerpo extendiendo los brazos y apoyando solo las manos y los dedos de los pies. Mantén el cuerpo recto desde la cabeza hasta los talones.\nDescenso: Flexiona los codos y baja el cuerpo hacia el suelo hasta que tu pecho casi toque el suelo. Mantén la espalda recta y el abdomen contraído durante todo el movimiento.\nAscenso: Empuja con las manos para volver a la posición inicial, estirando los brazos completamente.\n\nConsejos:\nSi te resulta difícil hacer flexiones normales, puedes hacerlas apoyando las rodillas al suelo.", "created_at": createdAt});
    await db.insert('exercise', {"id": 15, "name": "Flexiones Diamante", "img_path": "flexiones_diamante.png", "description": "Posición inicial: Colócate boca abajo en el suelo. Con las manos juntas formando un triángulo o diamante justo debajo de tu pecho. Apoya las manos en el suelo, separadas a la anchura de los hombros. Estira los brazos y levanta el cuerpo del suelo, apoyando solo las manos y los dedos de los pies. Mantén el cuerpo recto desde la cabeza hasta los talones.\nDescenso: Flexiona los codos y baja el cuerpo hacia el suelo hasta que tu pecho toque el diamante formado con tus manos. Mantén la espalda recta y el abdomen contraído durante todo el movimiento.\nAscenso: Empuja con las manos para volver a la posición inicial, estirando los brazos completamente.\n\nConsejos:\nSi te resulta difícil hacer flexiones diamante, puedes hacerlas apoyando las rodillas en el suelo.", "created_at": createdAt});
    await db.insert('exercise', {"id": 16, "name": "Flexiones Inclinadas", "img_path": "flexiones_inclinadas.png", "description": "Posición inicial: Busca una superficie elevada y estable, como un banco o una caja. Coloca las manos en el borde de la superficie, separadas a la anchura de los hombros. Inclina el cuerpo hacia adelante, apoyando los pies en el suelo y manteniendo el cuerpo recto desde la cabeza hasta los talones.\nDescenso: Flexiona los codos y baja el cuerpo hacia la superficie hasta que tu pecho casi la toque. Mantén la espalda recta y el abdomen contraído durante el movimiento.\nAscenso: Empuja con las manos para volver a la posición inicial, estirando los brazos completamente.", "created_at": createdAt});
    await db.insert('exercise', {"id": 17, "name": "Flexiones Declinadas", "img_path": "flexiones_declinadas.png", "description": "Posición inicial: Busca una superficie elevada y estable, como un banco o una caja. Apoya los pies en la superficie, manteniendo el cuerpo recto desde la cabeza hasta los talones.  Coloca las manos en el suelo, separadas a la anchura de los hombros.\nDescenso: Flexiona los codos y baja el cuerpo hasta que tu pecho casi toque el suelo. Mantén la espalda recta y el abdomen contraído durante el movimiento.\nAscenso: Empuja con las manos  para volver a la posición inicial, estirando los brazos completamente.\n\nConsejos:\nSi te resulta difícil hacer flexiones declinadas, puedes comenzar con una superficie menos elevada", "created_at": createdAt});
    await db.insert('exercise', {"id": 18, "name": "Dominadas", "img_path": "dominadas.png", "description": "Agarre: Sujeta la barra con las manos separadas a la anchura de los hombros o un poco más anchas.\nElevación: Cuélgate de la barra con los brazos extendidos. Luego, levanta el cuerpo hasta que la barbilla sobrepase la barra, flexionando los codos y contrayendo los músculos de la espalda.\nDescenso: Baja lentamente el cuerpo hasta la posición inicial, estirando los brazos por completo.\n\nConsejos\nSi te resulta difícil hacer dominadas, puedes comenzar con dominadas con banda elástica o negativas (bajando lentamente el cuerpo desde la posición superior).\nSi no posees barra para hacer este ejercicio puedes cambiarlo por flexiones normales", "created_at": createdAt});
    await db.insert('exercise', {"id": 19, "name": "Fondos De Triceps", "img_path": "fondos_de_triceps.png", "description": "Posición inicial: Siéntate en el suelo con las piernas estiradas y los pies apoyados en el suelo. Coloca las manos  en el borde de una superficie como un banco o una caja detrás de ti, con los dedos apuntando hacia delante y separadas a la anchura de los hombros. Levanta las caderas del suelo, manteniendo el cuerpo recto.\nDescenso: Flexiona los codos y baja el cuerpo hacia el suelo hasta que tus brazos formen un ángulo de 90 grados. Mantén la espalda recta y el abdomen contraído durante el movimiento.\nAscenso: Empuja con las manos para volver a la posición inicial, estirando los brazos completamente.\n\nConsejo:\nSi te resulta difícil, puedes hacer los fondos de triceps con las rodillas flexionadas en vez de tener las piernas estiradas", "created_at": createdAt});
    await db.insert('exercise', {"id": 20, "name": "Superman", "img_path": "superman.png", "description": "Posición inicial: Túmbate boca abajo en el suelo con los brazos extendidos hacia  delante y las piernas estiradas hacia atrás.\nElevación: Levanta simultáneamente los brazos y las piernas del suelo, como si estuvieras volando. Mantén la posición elevada durante unos segundos, contrayendo los músculos de la espalda baja y los glúteos.\nDescenso: Baja lentamente los brazos y las piernas hasta la posición inicial, y repites el ejercicio.", "created_at": createdAt});
    await db.insert('exercise', {"id": 21, "name": "Curl De Biceps", "img_path": "curl_de_biceps.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Sujeta una mancuerna en cada mano con las palmas mirando hacia adelante. Deja que los brazos cuelguen a los lados del cuerpo.\nFlexión: Dobla los codos y levanta las mancuernas hacia los hombros. Mantén los codos pegados a los costados y no uses el impulso del cuerpo para levantar las pesas.\nExtensión: Baja lentamente las mancuernas a la posición inicial, estirando completamente los brazos.\n\nConsejo:\nElige un peso que te permita completar el número de repeticiones deseado con buena forma. Si no tienes mancuernas puedes usar botellas de agua.", "created_at": createdAt});
    await db.insert('exercise', {"id": 22, "name": "Flexiones En Pica", "img_path": "flexiones_en_pica.png", "description": "Posición inicial: Ponte en posición de plancha con las manos apoyadas en el suelo a la anchura de los hombros y los dedos apuntando hacia adelante. Levanta las caderas hacia arriba, formando una \"V\" invertida con tu cuerpo. Mantén las piernas estiradas y los pies apoyados en el suelo.\nDescenso: Flexiona los codos y baja la cabeza hacia el suelo, dirigiendo la frente hacia el punto donde se unen las manos. Mantén las caderas elevadas y el cuerpo en línea recta.\nAscenso: Empuja con las manos para volver a la posición inicial, estirando los brazos completamente.\n\nConsejos:\nSi te resulta difícil hacer flexiones en pica, puedes comenzar apoyando las rodillas en el suelo.", "created_at": createdAt});
    await db.insert('exercise', {"id": 23, "name": "Elevaciones Laterales", "img_path": "elevaciones_laterales.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Sujeta una mancuerna en cada mano con las palmas mirando hacia el cuerpo. Deja que los brazos cuelguen a los lados del cuerpo, manteniendo una ligera flexión en los codos.\nElevación: Levanta los brazos hacia los lados hasta que queden a la altura de los hombros. Mantén los codos ligeramente flexionados y las muñecas firmes. No uses el impulso del cuerpo para levantar las pesas; concéntrate en usar los músculos de los hombros.\nDescenso: Baja lentamente los brazos hasta la posición inicial.\n\nConsejos:\nElige un peso que te permita completar el número de repeticiones deseado con buena forma. Si no tienes mancuernas puedes usar botellas de agua", "created_at": createdAt});
    await db.insert('exercise', {"id": 24, "name": "Flexiones Con Palmada", "img_path": "flexiones_con_palmada.png", "description": "Posición inicial: Ponte en posición de plancha con las manos apoyadas en el suelo a la anchura de los hombros y los dedos apuntando hacia adelante. Mantén el cuerpo recto desde la cabeza hasta los talones.\nDescenso y explosión: Baja el cuerpo flexionando los codos como si fueras a hacer una flexión normal. Cuando estés cerca del suelo, impúlsate con fuerza hacia arriba para levantar las manos del suelo.\nPalmada y aterrizaje: Mientras estás en el aire, junta las manos y da una palmada. Luego, vuelve a apoyar las manos en el suelo y aterriza suavemente para continuar con la siguiente repeticion.\n\nConsejos:\nSi no puedes hacer una palmada completa, puedes comenzar con palmadas más pequeñas o incluso simplemente levantar las manos del suelo sin llegar a juntarlas.", "created_at": createdAt});
    await db.insert('exercise', {"id": 25, "name": "Martillo", "img_path": "martillo.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Sujeta una mancuerna en cada mano con las palmas mirando hacía el cuerpo. Deja que los brazos cuelguen a los lados del cuerpo.\nFlexión: Dobla los codos y levanta la mancuerna hacia los hombros. Mantén los codos pegados a los costados del cuerpo y no uses el impulso del cuerpo para levantar las pesas.\nExtensión: Baja lentamente las mancuernas a la posición inicial, estirando completamente los brazos.\nConsejo:\nElige un peso que te permita completar el número de repeticiones deseado con buena forma. Si no tienes mancuernas puedes usar botellas de agua.", "created_at": createdAt});
    await db.insert('exercise', {"id": 26, "name": "Burpees", "img_path": "burpees.png", "description": "Posición inicial: Ponte de pie con los pies separados a la anchura de los hombros. Baja el cuerpo hasta quedar en cuclillas, apoyando las manos en el suelo delante de ti.\nMovimiento: Lanza los pies hacia atrás, estirando las piernas y quedando en posición de plancha. Haz una flexión. Vuelve a la posición de cuclillas recogiendo las piernas.\nSalto: Salta verticalmente desde la posición de cuclillas, levantando los brazos por encima de la cabeza. Aterriza suavemente y vuelve a la posición inicial para repetir el movimiento.\n\nConsejo:\nPuedes modificar los burpees para adaptarlos a tu nivel de condición física. Omitiendo la flexión o el salto.", "created_at": createdAt});
    await db.insert('exercise', {"id": 27, "name": "Abdominales Básicos", "img_path": "abdominales_basicos.png", "description": "Posición inicial: Acuéstate boca arriba con las rodillas flexionadas y los pies apoyados en el suelo. Coloca las manos detrás de la cabeza sin ejercer presión en el cuello, o en el pecho.\nElevación: Contrae los músculos abdominales y levanta la parte superior del torso del suelo, llevándolo hasta las rodillas. Mantén la espalda baja apoyada en el suelo.\nDescenso: Baja lentamente la parte superior del torso hasta la posición inicial.", "created_at": createdAt});
    await db.insert('exercise', {"id": 28, "name": "Tijeras", "img_path": "tijeras.png", "description": "Posición inicial: Túmbate boca arriba en el suelo con las piernas estiradas y los brazos a los lados del cuerpo. Levanta ligeramente las piernas del suelo. Manteniendo la espalda baja apoyada en el suelo.\nMovimiento: Cruza una pierna sobre la otra, como si estuvieras haciendo tijeras. Alterna el cruce de piernas, manteniendo las piernas estiradas y el abdomen contraído.\nRepeticion: Continúa alternando el cruce de piernas durante el número de repeticiones deseado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 29, "name": "Giros Rusos", "img_path": "giros_rusos.png", "description": "Posición inicial: Siéntate en el suelo con las rodillas flexionadas y los pies apoyados en el suelo o levantados. Inclina el torso hacia atrás en un ángulo de 45 grados, manteniendo la espalda recta. Puedes juntar las manos frente a ti o sostener una mancuerna ligera o balón medicinal para aumentar la dificultad.\nGiro: Gira el torso de un lado a otro, llevando los brazos o el peso de un lado al otro del cuerpo. Mantén el control del movimiento y evita balancearte bruscamente.\nRepetición: Continúa girando el torso de un lado a otro durante el número de repeticiones deseado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 30, "name": "Elevación De Piernas", "img_path": "elevacion_de_piernas.png", "description": "Posición inicial: Túmbate boca arriba en el suelo con las piernas estiradas y los brazos a los lados del cuerpo. Levanta ligeramente las piernas del suelo, manteniendo la espalda baja apoyada en el suelo.\nElevación: Levanta las piernas del suelo, manteniendo las rodillas estiradas y los pies juntos. Continúa levantando las piernas hasta que formen un ángulo de 90 grados con el torso.\nDescenso: Baja lentamente las piernas hasta la posición inicial, controlando el movimiento. Repite el movimiento durante el número de repeticiones deseado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 31, "name": "Elevación En V", "img_path": "elevacion_en_v.png", "description": "Posición inicial: Acuéstate boca arriba con las piernas estiradas y los brazos extendidos por encima de la cabeza. Mantén la espalda baja apoyada en el suelo y el abdomen contraído.\nElevación: Levanta simultáneamente las piernas y la parte superior del cuerpo, intentando tocar los dedos de los pies con las manos. Mantén las piernas rectas y los brazos extendidos durante todo el movimiento. El cuerpo debe formar una \"V\" al final del movimiento.\nDescenso: Baja lentamente las piernas y la parte superior del cuerpo hasta la posición inicial. Repite el movimiento durante el número de repeticiones deseado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 32, "name": "Flexiones En T", "img_path": "flexiones_en_t.png", "description": "Posición inicial: Ponte en posición de plancha con las manos apoyadas en el suelo a la anchura de los hombros y los dedos apuntando hacia adelante. Mantén el cuerpo recto desde la cabeza hasta los talones.\nDescenso y rotación: Baja el cuerpo flexionando los codos como si fueras a hacer una flexión normal. Cuando estés cerca del suelo, gira el torso hacia un lado y extiende un brazo hacia arriba, formando una \"T\" con tu cuerpo. Mantén la posición durante un segundo o dos, contrayendo los músculos del core.\nRegreso y repetición: Vuelve a la posición de plancha y repite el movimiento hacia el otro lado, extendiendo el otro brazo hacia arriba. Continúa alternando los lados en cada repetición.", "created_at": createdAt});
    await db.insert('exercise', {"id": 33, "name": "Abdominales Cortos", "img_path": "abdominales_cortos.png", "description": "Posición inicial: Acuéstate boca arriba con las rodillas flexionadas y los pies apoyados en el suelo. Coloca las manos detrás de la cabeza sin ejercer presión en el cuello, o coloca las manos en el pecho.\nElevación: Contrae los músculos abdominales y levanta la parte superior del torso del suelo, Mantén la espalda baja apoyada en el suelo. El movimiento debe ser corto y controlado.\nDescenso: Baja lentamente la parte superior del torso hasta la posición inicial.", "created_at": createdAt});
    await db.insert('exercise', {"id": 34, "name": "Escaladores", "img_path": "escaladores.png", "description": "Posición inicial: Colócate en posición de plancha con las manos apoyadas en el suelo a la anchura de los hombros y los dedos apuntando hacia adelante. Mantén el cuerpo recto desde la cabeza hasta los talones.\nMovimiento: Lleva una rodilla hacia el pecho, como si estuvieras escalando una montaña. Alterna las piernas, llevando una rodilla hacia el pecho y luego la otra. Mantén un ritmo constante y controlado.\nRepetición: Continúa alternando las piernas durante el número de repeticiones deseado.", "created_at": createdAt});
    await db.insert('exercise', {"id": 35, "name": "Levantamiento De Piernas En Suspensión", "img_path": "levantamiento_de_piernas_en_suspension.png", "description": "Posición inicial:sujeta la barra con las manos, separadas a la anchura de los hombros. Cuélgate de la barra, manteniendo los brazos extendidos y el cuerpo suspendido en el aire.\nElevación: Contrae los músculos abdominales y levanta las piernas hacia arriba, manteniendo las rodillas juntas y las piernas estiradas o ligeramente flexionadas. Eleva las piernas hasta que tus músculos formen un ángulo de 90 grados con tu torso.\nDescenso: Baja lentamente las piernas hasta la posición inicial\n\nConsejos:\nSi no tienes barra puedes cambiar este ejercicio y hacer abdominales básicos", "created_at": createdAt});
    await db.insert('exercise', {"id": 36, "name": "Roll Up", "img_path": "roll_up.png", "description": "Posición inicial: Siéntate en el suelo con las piernas estiradas hacia adelante y separadas a la anchura de las caderas. Extiende los brazos hacia adelante a la altura de los hombros, con las palmas enfrentadas. Mantén la espalda recta.\nDescenso: Inhala y comienza a redondear la columna vertebral hacia atrás. Mantén los brazos extendidos hacia adelante y las piernas estiradas en el suelo. Continúa bajando hasta que la espalda toque el suelo.\nAscenso: Exhala y comienza a levantar el torso del suelo, volviendo a la posición inicial. Utiliza los músculos abdominales para levantar el cuerpo y no te impulses con los brazos. Mantén las piernas estiradas en el suelo durante todo el movimiento.", "created_at": createdAt});
    await db.insert('exercise', {"id": 37, "name": "Abdominales Con Toque De Talon", "img_path": "abdominales_con_toque_de_talon.png", "description": "Posición inicial: Acuéstate boca arriba en el suelo. Flexiona las rodillas y apoya los pies en el suelo. Extiende los brazos a los lados del cuerpo, con las palmas mirando hacia abajo.\nElevación y rotación: Contrae los músculos abdominales y levanta ligeramente la parte superior del torso del suelo, despegando los omóplatos del suelo. Inclina el torso hacia un lado, intentando tocar el talón de ese pie con la mano de ese mismo lado. Mantén la posición durante un segundo o dos.\nRegreso y repetición: Vuelve a la posición inicial y repite el movimiento hacia el otro lado, intentando tocar el talón del otro pie con la mano correspondiente. Continúa alternando los lados en cada repetición.", "created_at": createdAt});
    await db.insert('exercise', {"id": 38, "name": "Abdominales Mariposa", "img_path": "abdominales_mariposa.png", "description": "Posición inicial: Acuéstate boca arriba en el suelo. Flexiona las rodillas y junta las plantas de los pies, dejando q las rodillas caigan hacia los lados, en forma de mariposa, y los brazos extendidos por encima de la cabeza.\nElevación: Contrae los músculos abdominales y levanta el torso del suelo, con los brazos extendidos lleva las manos hasta los pies. El movimiento debe ser corto y controlado.\nDescenso: Baja lentamente el torso hasta la posición inicial.", "created_at": createdAt});


    // Insert Biotypes
    await db.insert('biotype', {"id": 1, "name": "Ectomorfo", "description": "Personas delgadas, con extremidades largas y dificultad para ganar peso o masa muscular.\nSuelen tener un metabolismo rápido y necesitan una dieta rica en calorías para ganar músculo.", "created_at": createdAt});
    await db.insert('biotype', {"id": 2, "name": "Endomorfo", "description": "Tienden a tener una constitución más robusta, con mayor facilidad para acumular grasa.\nSu metabolismo suele ser más lento y deben tener una dieta equilibrada para controlar el peso.",  "created_at": createdAt});
    await db.insert('biotype', {"id": 3, "name": "Mesomorfo", "description": "Suelen tener una apariencia atlética, y facilidad para ganar músculo y perder grasa.\nSu metabolismo es eficiente. Responden bien a una variedad de entrenamientos y dietas, pero deben mantener un equilibrio para optimizar su físico.", "created_at": createdAt});


    // Insert Muscle Groups
    await db.insert('muscle_group', {"id": 1, "name": "Tren Superior", "created_at": createdAt});
    await db.insert('muscle_group', {"id": 2, "name": "Tren Inferior", "created_at": createdAt});
    await db.insert('muscle_group', {"id": 3, "name": "Abdomen", "created_at": createdAt});


    // Insert Training Plans Info
    await db.insert('training_plan_info', {"id": 1, "name": "Plan de Tren Superior", "biotype_id": 1, "genre": "F", "muscle_group_id": 1, "reps": 7, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 2, "name": "Plan de Tren Superior", "biotype_id": 1, "genre": "M", "muscle_group_id": 1, "reps": 10, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 3, "name": "Plan de Tren Superior", "biotype_id": 2, "genre": "F", "muscle_group_id": 1, "reps": 9, "series": 2, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 4, "name": "Plan de Tren Superior", "biotype_id": 2, "genre": "M", "muscle_group_id": 1, "reps": 12, "series": 2, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 5, "name": "Plan de Tren Superior", "biotype_id": 3, "genre": "F", "muscle_group_id": 1, "reps": 8, "series": 2, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 6, "name": "Plan de Tren Superior", "biotype_id": 3, "genre": "M", "muscle_group_id": 1, "reps": 12, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 7, "name": "Plan de Abdomen", "biotype_id": 1, "genre": "F", "muscle_group_id": 3, "reps": 10, "series": 3, "rest": 1.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 8, "name": "Plan de Abdomen", "biotype_id": 1, "genre": "M", "muscle_group_id": 3, "reps": 12, "series": 3, "rest": 1.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 9, "name": "Plan de Abdomen", "biotype_id": 2, "genre": "F", "muscle_group_id": 3, "reps": 10, "series": 2, "rest": 1.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 10, "name": "Plan de Abdomen", "biotype_id": 2, "genre": "M", "muscle_group_id": 3, "reps": 12, "series": 2, "rest": 1.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 11, "name": "Plan de Abdomen", "biotype_id": 3, "genre": "F", "muscle_group_id": 3, "reps": 10, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 12, "name": "Plan de Abdomen", "biotype_id": 3, "genre": "M", "muscle_group_id": 3, "reps": 12, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 13, "name": "Plan de Tren Inferior", "biotype_id": 1, "genre": "F", "muscle_group_id": 2, "reps": 10, "series": 3, "rest": 1.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 14, "name": "Plan de Tren Inferior", "biotype_id": 1, "genre": "M", "muscle_group_id": 2, "reps": 12, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 15, "name": "Plan de Tren Inferior", "biotype_id": 2, "genre": "F", "muscle_group_id": 2, "reps": 10, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 16, "name": "Plan de Tren Inferior", "biotype_id": 2, "genre": "M", "muscle_group_id": 2, "reps": 12, "series": 3, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 17, "name": "Plan de Tren Inferior", "biotype_id": 3, "genre": "F", "muscle_group_id": 2, "reps": 7, "series": 4, "rest": 2.0, "created_at": createdAt});
    await db.insert('training_plan_info', {"id": 18, "name": "Plan de Tren Inferior", "biotype_id": 3, "genre": "M", "muscle_group_id": 2, "reps": 10, "series": 4, "rest": 2.0, "created_at": createdAt});


    // Insert Training Exercises
    await db.insert('training_plan_exercise', {"id": 1, "training_plan_info_id": 1, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 2, "training_plan_info_id": 1, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 3, "training_plan_info_id": 1, "exercise_id": 16, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 4, "training_plan_info_id": 1, "exercise_id": 18, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 5, "training_plan_info_id": 1, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 6, "training_plan_info_id": 1, "exercise_id": 17, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 7, "training_plan_info_id": 1, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 8, "training_plan_info_id": 1, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 9, "training_plan_info_id": 1, "exercise_id": 22, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 10, "training_plan_info_id": 1, "exercise_id": 23, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 11, "training_plan_info_id": 2, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 12, "training_plan_info_id": 2, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 13, "training_plan_info_id": 2, "exercise_id": 16, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 14, "training_plan_info_id": 2, "exercise_id": 18, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 15, "training_plan_info_id": 2, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 16, "training_plan_info_id": 2, "exercise_id": 17, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 17, "training_plan_info_id": 2, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 18, "training_plan_info_id": 2, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 19, "training_plan_info_id": 2, "exercise_id": 22, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 20, "training_plan_info_id": 2, "exercise_id": 23, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 21, "training_plan_info_id": 3, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 22, "training_plan_info_id": 3, "exercise_id": 24, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 23, "training_plan_info_id": 3, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 24, "training_plan_info_id": 3, "exercise_id": 16, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 25, "training_plan_info_id": 3, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 26, "training_plan_info_id": 3, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 27, "training_plan_info_id": 3, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 28, "training_plan_info_id": 3, "exercise_id": 25, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 29, "training_plan_info_id": 3, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 30, "training_plan_info_id": 4, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 31, "training_plan_info_id": 4, "exercise_id": 24, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 32, "training_plan_info_id": 4, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 33, "training_plan_info_id": 4, "exercise_id": 16, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 34, "training_plan_info_id": 4, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 35, "training_plan_info_id": 4, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 36, "training_plan_info_id": 4, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 37, "training_plan_info_id": 4, "exercise_id": 25, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 38, "training_plan_info_id": 4, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 39, "training_plan_info_id": 5, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 40, "training_plan_info_id": 5, "exercise_id": 24, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 41, "training_plan_info_id": 5, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 42, "training_plan_info_id": 5, "exercise_id": 18, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 43, "training_plan_info_id": 5, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 44, "training_plan_info_id": 5, "exercise_id": 17, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 45, "training_plan_info_id": 5, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 46, "training_plan_info_id": 5, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 47, "training_plan_info_id": 5, "exercise_id": 23, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 48, "training_plan_info_id": 6, "exercise_id": 14, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 49, "training_plan_info_id": 6, "exercise_id": 24, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 50, "training_plan_info_id": 6, "exercise_id": 15, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 51, "training_plan_info_id": 6, "exercise_id": 18, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 52, "training_plan_info_id": 6, "exercise_id": 19, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 53, "training_plan_info_id": 6, "exercise_id": 17, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 54, "training_plan_info_id": 6, "exercise_id": 20, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 55, "training_plan_info_id": 6, "exercise_id": 21, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 56, "training_plan_info_id": 6, "exercise_id": 23, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 57, "training_plan_info_id": 7, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 58, "training_plan_info_id": 7, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 59, "training_plan_info_id": 7, "exercise_id": 28, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 60, "training_plan_info_id": 7, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 61, "training_plan_info_id": 7, "exercise_id": 30, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 62, "training_plan_info_id": 7, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 63, "training_plan_info_id": 7, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 64, "training_plan_info_id": 7, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 65, "training_plan_info_id": 7, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 66, "training_plan_info_id": 7, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 67, "training_plan_info_id": 8, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 68, "training_plan_info_id": 8, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 69, "training_plan_info_id": 8, "exercise_id": 28, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 70, "training_plan_info_id": 8, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 71, "training_plan_info_id": 8, "exercise_id": 30, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 72, "training_plan_info_id": 8, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 73, "training_plan_info_id": 8, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 74, "training_plan_info_id": 8, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 75, "training_plan_info_id": 8, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 76, "training_plan_info_id": 8, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 77, "training_plan_info_id": 9, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 78, "training_plan_info_id": 9, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 79, "training_plan_info_id": 9, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 80, "training_plan_info_id": 9, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 81, "training_plan_info_id": 9, "exercise_id": 37, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 82, "training_plan_info_id": 9, "exercise_id": 36, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 83, "training_plan_info_id": 9, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 84, "training_plan_info_id": 9, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 85, "training_plan_info_id": 9, "exercise_id": 38, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 86, "training_plan_info_id": 9, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 87, "training_plan_info_id": 10, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 88, "training_plan_info_id": 10, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 89, "training_plan_info_id": 10, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 90, "training_plan_info_id": 10, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 91, "training_plan_info_id": 10, "exercise_id": 37, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 92, "training_plan_info_id": 10, "exercise_id": 36, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 93, "training_plan_info_id": 10, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 94, "training_plan_info_id": 10, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 95, "training_plan_info_id": 10, "exercise_id": 38, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 96, "training_plan_info_id": 10, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 97, "training_plan_info_id": 11, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 98, "training_plan_info_id": 11, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 99, "training_plan_info_id": 11, "exercise_id": 36, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 100, "training_plan_info_id": 11, "exercise_id": 28, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 101, "training_plan_info_id": 11, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 102, "training_plan_info_id": 11, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 103, "training_plan_info_id": 11, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 104, "training_plan_info_id": 11, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 105, "training_plan_info_id": 11, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 106, "training_plan_info_id": 11, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 107, "training_plan_info_id": 12, "exercise_id": 27, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 108, "training_plan_info_id": 12, "exercise_id": 33, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 109, "training_plan_info_id": 12, "exercise_id": 36, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 110, "training_plan_info_id": 12, "exercise_id": 28, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 111, "training_plan_info_id": 12, "exercise_id": 29, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 112, "training_plan_info_id": 12, "exercise_id": 32, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 113, "training_plan_info_id": 12, "exercise_id": 31, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 114, "training_plan_info_id": 12, "exercise_id": 34, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 115, "training_plan_info_id": 12, "exercise_id": 26, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 116, "training_plan_info_id": 12, "exercise_id": 35, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 117, "training_plan_info_id": 13, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 118, "training_plan_info_id": 13, "exercise_id": 2, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 119, "training_plan_info_id": 13, "exercise_id": 3, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 120, "training_plan_info_id": 13, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 121, "training_plan_info_id": 13, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 122, "training_plan_info_id": 13, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 123, "training_plan_info_id": 13, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 124, "training_plan_info_id": 13, "exercise_id": 8, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 125, "training_plan_info_id": 13, "exercise_id": 9, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 126, "training_plan_info_id": 14, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 127, "training_plan_info_id": 14, "exercise_id": 2, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 128, "training_plan_info_id": 14, "exercise_id": 3, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 129, "training_plan_info_id": 14, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 130, "training_plan_info_id": 14, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 131, "training_plan_info_id": 14, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 132, "training_plan_info_id": 14, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 133, "training_plan_info_id": 14, "exercise_id": 8, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 134, "training_plan_info_id": 14, "exercise_id": 9, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 135, "training_plan_info_id": 15, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 136, "training_plan_info_id": 15, "exercise_id": 10, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 137, "training_plan_info_id": 15, "exercise_id": 2, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 138, "training_plan_info_id": 15, "exercise_id": 12, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 139, "training_plan_info_id": 15, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 140, "training_plan_info_id": 15, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 141, "training_plan_info_id": 15, "exercise_id": 11, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 142, "training_plan_info_id": 15, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 143, "training_plan_info_id": 15, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 144, "training_plan_info_id": 15, "exercise_id": 13, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 145, "training_plan_info_id": 16, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 146, "training_plan_info_id": 16, "exercise_id": 10, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 147, "training_plan_info_id": 16, "exercise_id": 2, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 148, "training_plan_info_id": 16, "exercise_id": 12, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 149, "training_plan_info_id": 16, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 150, "training_plan_info_id": 16, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 151, "training_plan_info_id": 16, "exercise_id": 11, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 152, "training_plan_info_id": 16, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 153, "training_plan_info_id": 16, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 154, "training_plan_info_id": 16, "exercise_id": 13, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 155, "training_plan_info_id": 17, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 156, "training_plan_info_id": 17, "exercise_id": 10, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 157, "training_plan_info_id": 17, "exercise_id": 12, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 158, "training_plan_info_id": 17, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 159, "training_plan_info_id": 17, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 160, "training_plan_info_id": 17, "exercise_id": 11, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 161, "training_plan_info_id": 17, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 162, "training_plan_info_id": 17, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 163, "training_plan_info_id": 17, "exercise_id": 13, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 164, "training_plan_info_id": 17, "exercise_id": 9, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 165, "training_plan_info_id": 18, "exercise_id": 1, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 166, "training_plan_info_id": 18, "exercise_id": 10, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 167, "training_plan_info_id": 18, "exercise_id": 12, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 168, "training_plan_info_id": 18, "exercise_id": 4, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 169, "training_plan_info_id": 18, "exercise_id": 5, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 170, "training_plan_info_id": 18, "exercise_id": 11, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 171, "training_plan_info_id": 18, "exercise_id": 6, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 172, "training_plan_info_id": 18, "exercise_id": 7, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 173, "training_plan_info_id": 18, "exercise_id": 13, "created_at": createdAt});
    await db.insert('training_plan_exercise', {"id": 174, "training_plan_info_id": 18, "exercise_id": 9, "created_at": createdAt});

  }

  // DB initializer
  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'enlanados_app_mobile.db'), onConfigure: _onConfigure,
        onCreate: (db, version) async {

          await db.execute('''
          CREATE TABLE exercise (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          img_path TEXT NOT NULL,
          DESCRIPTION TEXT
          created_at TEXT 
          );
          ''');

          await db.execute('''
          CREATE TABLE biotype (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          description TEXT NOT NULL,
          created_at TEXT,
        );
        ''');

          await db.execute('''
          CREATE TABLE muscle_group (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          created_at TEXT 
          );
          ''');

          await db.execute('''
          CREATE TABLE profile (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          genre TEXT NOT NULL,
          biotype_id INTEGER NOT NULL,
          height REAL NOT NULL,
          weight REAL NOT NULL,
          arm_measure REAL NOT NULL,
          leg_measure REAL NOT NULL,
          created_at TEXT,
          FOREIGN KEY (biotype_id) REFERENCES biotype(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan_info (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          biotype_id INTEGER NOT NULL,
          genre TEXT NOT NULL,
          muscle_group_id INTEGER NOT NULL,
          reps INTEGER NOT NULL,
          series INTEGER NOT NULL,
          rest REAL NOT NULL,
          created_at TEXT,
          FOREIGN KEY (biotype_id) REFERENCES biotype(id),
          FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan_exercise (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_info_id INTEGER NOT NULL,
          exercise_id INTEGER NOT NULL,
          created_at TEXT,
          FOREIGN KEY (training_plan_info_id) REFERENCES training_plan_info(id),
          FOREIGN KEY (exercise_id) REFERENCES exercise(id) 
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_info_id INTEGER NOT NULL,
          micro_goal INTEGER NOT NULL,
          meso_goal INTEGER NOT NULL,
          macro_goal INTEGER NOT NULL,
          due_date TEXT NOT NULL,
          active INTEGER,
          created_at TEXT,
          FOREIGN KEY (training_plan_info_id) REFERENCES training_plan_info(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_session (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_id INTEGER NOT NULL,
          duration REAL NOT NULL,
          reps_avg INTEGER NOT NULL,
          done INTEGER NOT NULL,
          created_at TEXT,
          FOREIGN KEY (training_plan_id) REFERENCES training_plan(id)
          );
          ''');

          await _insertInitialData(db);

        },
        version: 2
    );
  }

}