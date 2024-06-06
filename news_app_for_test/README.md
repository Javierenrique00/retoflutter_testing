# news_app_for_test

Esta es un aplicación de noticias para aprender el desarrllo de pruebas unitarias, de widgets y de integración.

## Unit Test

- El desarrollo de las pruebas se empezó por las pruebas unitarias, las cuales se enfocaron en mockear los datos para poder probar el caso de uso `getNewsUsecase()`.

En este caso se probó el caso exitoso con datos correctos y el caso que genera la excepción, como se ve a continuación.

```dart
class MockNewsApiSerice extends Mock implements NewsApiService{}

void main(){

  test('News Apiservice.fetchTopHeadlines success', () async {

    // Arrange
    final newsApiserviceMock = MockNewsApiSerice();
    final news = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    when(()=> newsApiserviceMock.fetchTopHeadlines()).thenAnswer((invocation) => Future(() => [news]),); 
    final getNewsUsecase = GetNewsUsecase(newsApiserviceMock);

    // act
    final result = await getNewsUsecase.execute();

    //assert
    final newsEntity = NewsEntity(title: news.title, description: news.description, url: news.url, urlToImage: news.urlToImage, sourceName: news.sourceName);
    expect(result.first, newsEntity);

  });

    test('News Apiservice.fetchTopHeadlines failure', () async {

    // Arrange
    final newsApiserviceMock = MockNewsApiSerice();
    when(()=> newsApiserviceMock.fetchTopHeadlines()).thenThrow(Exception()); 

    //act //assert
    expect( () async => await GetNewsUsecase(newsApiserviceMock).execute(), throwsException);

  });
}

```

También las clases de datos newsEntity y newsModel, las cuales es necesario probar la serialización a nivel Json y las funciones auxiliares de igualdad y hashCode, las cuales es necesario hacer las pruebas. Aquí no hice las pruebas de todos los campos, porque se alarga mucho, pero en la realidad hay que encontrar una manera de probar los campos de la serialización de una manera mas automática y no tan manual.

## Pruebas de Widgets

Se probó el Widget 'NewsCardWidget', para que muestre la información básica del contenido como es el título y la descripción. Aquí el problema viene dado, porque hay un Widget que muestra una imagen de acuerdo a la URL. Afortumadamente si la URL está vacía no intenta traer la imagen y se puede completar las pruebas unitarias. Con esto se observa que no se puede tener una cobertura del 100% dado que este widget de imagen no se puede probar con los test unitarios o los de Widget.

A nivel de Screen, se probaron las 4 pantallas principales y su navegación así:

- SplashScreen
- NewsListScreen
- NewsSearchScreen

De aquí hay que resaltar que tuve varios inconvenientes, poque por ejemplo para probar el SplashScreen, quería hacer un mock para que no navegara a la siguiente pantalla, por medio de un Mock, e intenté usar una librería externa para mockear la navegación, llamada 'Mockingjay', pero finalmente no me funcionó con los timers y los futuros que maneja esta pantalla.

Otro inconveniente viene dado porque al mismo splashScreen hay que inyectarle el provider del caso de uso, porque tarde o temprano va a navegar hacia la pantalla newsListScreen que lo requiere.

También hay un timer que queda abierto, y si uno termina el widgetTest antes de que termine el timer sale un error, indicando el problema que hay un timer abierto.

La solución a esto fué crear prácticamente todo el entorno del app inyectando el caso de uso mockeado con la data, la cual permite navegar desde el splash hasta la pantalla del newsListScreen como se ve a continuación:

```dart
class MockNewsApiSerice extends Mock implements NewsApiService {}

void main() {
  testWidgets('check splash show test data success', (tester) async {
    final newsApiserviceMock = MockNewsApiSerice();
    final news = NewsModel(
        title: 'title',
        description: 'description',
        url: '',
        urlToImage: '',
        sourceName: 'sourceName');
    when(() => newsApiserviceMock.fetchTopHeadlines()).thenAnswer(
      (invocation) => Future(() => [news]),
    );

    await tester.pumpWidget(Provider<GetNewsUsecase>(
      create: (_) => GetNewsUsecase(newsApiserviceMock),
      child: const MaterialApp(
        home: Scaffold(
          body: SplashScreen(),
        ),
      ),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 1));
    // test splash message in screen
    expect(find.text('News App'), findsOneWidget);

    // test navigate to new Screen in at least 2 seconds
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(NewsListScreen),findsOneWidget);

  });
}
```

Para el resto de pruebas de widget el reto es poder encontrar los componenetes con find y probar en que pantalla está para la navegación.

## Integration test

Se hizo un integration test muy básico, dado que no controlamos la data, ya que esta si viene del servicio, en el cual solo se prueba que entre a la pantalla del listado de noticias y navegue a la primera noticia con 'tap' y se verifica que llegue a la pantalla de detalle.

En general lo profundo de los test se hizo con los widgetTest, los cuales permiten probar todas las navegaciones y pantallas con datos mockeados.
