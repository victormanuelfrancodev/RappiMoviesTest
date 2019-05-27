# Rapid Movie Test 

<img src="https://pixel.nymag.com/imgs/fashion/daily/2018/11/02/2-empty-movie-theatre.w700.h467.2x.jpg" align="right"
     title="Movie Test" width="220" height="178">

.
La arquitectura que ocupe fue la de MVVM, tenía otra opción que era ocupar Clean architecture pero llegue a la conclusión que el proyecto era pequeño para implementar una arquitectura grande, en un libro decia: "no intentes matar moscas a cañonazos" y me guie de esa frase, aparte que MVVM es recomendada por apple para una buena arquitectura en aplicaciones con swift. 

Model

     El modelo es básicamente el modelo de datos o entidades que tiene su aplicación. Son simplemente estructuras o clases con propiedades asociadas simples. En la práctica general, simplemente retienen los datos que se han mapeado de su estructura de datos sin procesar que pueden provenir de su API u otras fuentes, como archivos SQLite, etc.
     
* Capa persistencia: 
    
    -Encapsula el comportamiento necesario para mantener los objetos: 
    
    Se puede ocupar NSUserDefaults,Property Lists,NSFileManager,SQLite, Core Data en mi proyecto ocupe Realm.
    
    Clases:
    
    MoviesPopularRLM: encapsula en realm las peliculas populares
    
    MoviesTopRankedRLM: encapsula en realm las peliculas top ranked
    
    MoviesUpcomingRLM: encapsula en realm las peliculas upcoming
   
 View Model 
 
    Los modelos de vista reciben eventos de IU y realizan la lógica de negocios y proporcionan el resultado que se mostrará en la IU. Este es el componente que se encarga de manejar la lógica empresarial que controla la vista. Pero internamente no modifica la interfaz de usuario, ni tiene ninguna referencia a la vista. Posee el modelo de datos.
    
   
   -MoviesModel Contiene el modelo de Movies
   
   -VideoModel  Contiene el modelo de Video 
    
   -MovieManager Hace el parseo de JSOn , aqui esta todo el parser de JSON para el objeto movie y la lógica empresarial
    
   -VideoManager Hace el parseo de JSOn , aqui esta todo el parser de JSON para el objeto video y la lógica empresarial
    
 Capa de Comunicaciones: 
 
     Esta capa es para gestionar la comunicación de la app, se puede ocupar librerias como alamofire
 
   -APIRequest : Es la clase encargada de las conexiones como hacer los request con alamofire. 
 
 Helper 
 
    Contiene clases que se ocupan como extensiones para poder volver a utilizar en otros proyectos o en el mismo proyecto
    
   -Locale+Extensions : tiene funciones como una que devuelve el idioma del dispositivo 
   
   -Error+Extensions: Maneja los errores en la aplicación 
   
   -UIImageView+Extensions : Maneja el load de las imagenes asi como el cache 
   
 View
 
     La vista es el elemento visual que se muestra. Todos los componentes de la interfaz de usuario en una pantalla de aplicación son vistas. La vista solo contiene la lógica de la interfaz de usuario, como la representación de datos, la navegación, etc. La vista posee el modelo de vista.
    
 
   -MoviesViewController  Contiene el viewcontroller donde muestra un collection de peliculas dependiendo la categoria, top,becoming y mas popular, contiene el tabbar y el buscador online offline
     
   -DetailViewController. Contiene el viewcontroller de detalle,muestra el detalle de la pelicula seleccionada 
     
   -VideoViewController. Contiene el viewcontroller que tiene embebido un webview para cargar el video de youtube.
     
   Unit Test
   
   MovieRappiTestTests : Se implenentan pruebas para los request al servidor. 
   
# Preguntas

   ¿En qué consiste el principio de responsabilidad única? Cuál es su propósito?
   
   Consiste que cada modulo o clase debe tener una responsabilidad sobre el sistema, tiene varios propositos: 
   -No afectar en cambios futuros a otros modulos
   -Realizar correctas y faciles pruebas unitarias
   -Hacer mas legible y ordenado el código
   -Encontrar y corregir problemas en el código
   -Poder reciclar el modulo en el mismo proyecto u en otro.
   -Facilidad de escalamiento 
   
   Qué características tiene, según su opinión, un “buen” código o código limpio
   
   Un buen código es aquel que cualquiera que lo tome lo pueda entender sin problemas,que tenga sus respectivas Unit Test que sea posible de escalar y modificar sin tener clases "amarradas a el", tener una buena arquitectura dentro del proyecto, tener nombres entendibles en las funciones,clases y variables, tener indexado el código y ordenado por carpetas; también tener las librerias necesarias y actualizado el codigo para cualquier actualización futura.
   
 
 
 

  
     
 
