package sofka.petstore;

import com.intuit.karate.junit5.Karate;

class PetStoreRunner {

  @Karate.Test
  Karate runAllSpecs() {
    // Ejecuta todos los features bajo specs/
    return Karate.run("classpath:specs/pet-crud.feature");
    
    // Ejecuta sólo el feature pet-crud.feature
    //return Karate.run("classpath:specs/pet-crud.feature").tags("@add");
  }

  
  
}

