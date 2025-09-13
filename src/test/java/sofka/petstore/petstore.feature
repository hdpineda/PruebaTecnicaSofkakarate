Feature: Pruebas PetStore - CRUD básico de Pet y búsqueda por estatus

  Background:
    * def baseUrl = karate.get('baseUrl')
    * url baseUrl
    # Datos iniciales (entradas)
    * def petId = Math.floor(Math.random() * 901) + 100
    * print 'petId:', petId
    * def initialName = 'firulais-' + petId
    * def updatedName = initialName + '-updated'
    * def initialStatus = 'available'
    * def finalStatus = 'sold'

    # Payloads
    * def newPet =
    """
    {
      "id": #(petId),
      "category": {"id": 1, "name": "dog"},
      "name": "#(initialName)",
      "photoUrls": ["https://img.example/dog.png"],
      "tags": [{"id": 1, "name": "qa"}],
      "status": "#(initialStatus)"
    }
    """

    * def updatePetPayload =
    """
    {
      "id": #(petId),
      "category": {"id": 1, "name": "dog"},
      "name": "#(updatedName)",
      "photoUrls": ["https://img.example/dog.png"],
      "tags": [{"id": 1, "name": "qa"}],
      "status": "#(finalStatus)"
    }
    """
    * header Accept = 'application/json'

  Scenario: Flujo completo - Añadir, Consultar por ID, Actualizar, Consultar por estatus

    # 1) Añadir una mascota a la tienda (POST /pet)
    Given path 'pet'
    And request newPet
    When method post
    Then status 200
    And match response.id == petId
    And match response.name == initialName
    And match response.status == initialStatus
    * def createdPet = response
    * print 'POST created:', createdPet

    # 2) Consultar la mascota ingresada previamente por ID (GET /pet/{petId})* configure retry = { count: 10, interval: 1000 }
    * print 'Consultando por ID:', petId
    Given path 'pet', petId
    And retry until responseStatus == 200
    When method get
    Then status 200
    And match response.id == petId
    And match response.name == initialName
    And match response.status == initialStatus

    # 3) Actualizar nombre y estatus de la mascota a "sold" (PUT /pet)
    Given path 'pet'
    And request updatePetPayload
    When method put
    Then status 200
    And match response.id == petId
    And match response.name == updatedName
    And match response.status == finalStatus

    # 4) Consultar la mascota modificada por estatus (GET /pet/findByStatus?status=sold)
    
    Given path 'pet', 'findByStatus'
    And param status = finalStatus
    When method get
    Then status 200
    # Validar que el arreglo contenga nuestro petId y el nombre actualizado
    And match response[*].id contains petId
    # Filtrar el elemento y validar campos
    * def myPet = response.filter(x => x.id == petId)[0]
    And match myPet.name == updatedName
    And match myPet.status == finalStatus

    # Evidencias (salidas)
    * print 'Nuevo Pet creado:', createdPet
    * print 'Pet actualizado y localizado por estatus:', myPet