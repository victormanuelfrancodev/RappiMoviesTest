# Rapid Movie Test 

<img src="https://pixel.nymag.com/imgs/fashion/daily/2018/11/02/2-empty-movie-theatre.w700.h467.2x.jpg" align="right"
     title="Movie Test" width="220" height="178">

.
Modelo
     Contiene objetos de acceso a datos y lógica de validación. Sabe cómo leer y escribir datos, y notifica al modelo de vista     cuando los datos cambian
     
* Capa persistencia: 
    
    -Encapsula el comportamiento necesario para mantener los objetos: 
    
    Se puede ocupar NSUserDefaults,Property Lists,NSFileManager,SQLite, Core Data en mi proyecto ocupe Realm.
    
    Clases:
    
    MoviesPopularRLM: encapsula en realm las peliculas populares
    
    MoviesTopRankedRLM: encapsula en realm las peliculas top ranked
    
    MoviesUpcomingRLM: encapsula en realm las peliculas upcoming
    
