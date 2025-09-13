package sofka.petstore;

import com.intuit.karate.junit5.Karate;

class PetStoreRunner {
  @Karate.Test
  Karate testPetStore() {
    return Karate.run("classpath:sofka/petstore/petstore.feature");
      
  }
}

