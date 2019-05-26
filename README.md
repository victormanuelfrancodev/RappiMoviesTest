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
