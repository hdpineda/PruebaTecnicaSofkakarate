Feature: Pet CRUD specs with robust sync, retries and data-driven

Background:
  * url baseUrl
  * header Accept = 'application/json'
  * def now = function(){ return new Date().getTime() }


@add
Scenario: Añadir y confirmar por ID con retry robusto
  * def petIdSmall = Math.floor(Math.random() * 901) + 100
  * def petId = now()

  * def newPet =  {id: #(petId), category: { id: 1, name: 'dog' }, name: "#('firu-' + petIdSmall)", photoUrls: ['https://img.example/dog.png'], tags: [ { id: 1, name: "#('qa-' + petIdSmall)" } ], status: 'available'}

  # POST
  Given path 'pet'
  And request newPet
  When method post
  Then status 200
  And match response.id == petId

  # GET/{id}
  * configure retry = { count: 25, interval: 1500 }
  Given path 'pet', petId
  And param _ = now()
  And retry until responseStatus == 200
  When method get
  Then status 200
  And match response.id == petId
  And match response.name == 'firu-' + petIdSmall
  And match response.status == 'available'


@update
Scenario: Actualizar a sold y confirmar por ID con retry
  * def petIdSmall = Math.floor(Math.random() * 901) + 100
  * def petId = now()

  # Crear
  * def pet = { id: #(petId), name: "#('firu-' + petIdSmall)", status: 'available' }
  Given path 'pet'
  And request pet
  When method post
  Then status 200

  # Confirmar existencia por ID
  * configure retry = { count: 25, interval: 1500 }
  Given path 'pet', petId
  And param _ = now()
  And retry until responseStatus == 200
  When method get
  Then status 200

  # Actualizar a sold
  * def upd = { id: #(petId), name: "#('firu-' + petIdSmall + '-upd')", status: 'sold' }
  Given path 'pet'
  And request upd
  When method put
  Then status 200
  And match response.status == 'sold'

  # Confirmar por ID que ya quedó sold
  Given path 'pet', petId
  And param _ = now()
  And retry until response.status == 'sold'
  When method get
  Then status 200
  And match response.status == 'sold'


@findByStatus
Scenario: Buscar por estatus sold con retry hasta que aparezca mi id
  * def petIdSmall = Math.floor(Math.random() * 901) + 100
  * def petId = now()

  # Crear directamente en sold para acelerar la indexación
  * def pet = { id: #(petId), name: "#('firu-' + petIdSmall)", status: 'sold' }
  Given path 'pet'
  And request pet
  When method post
  Then status 200

  # Confirmar sold por ID
  * configure retry = { count: 25, interval: 1500 }
  Given path 'pet', petId
  And param _ = now()
  And retry until response.status == 'sold'
  When method get
  Then status 200

  # Ahora sí buscar por estatus
  * configure retry = { count: 25, interval: 1500 }
  Given path 'pet', 'findByStatus'
  And param status = 'sold'
  And param _ = now()
  And retry until response[*].id contains petId
  When method get
  Then status 200
  And match response[*].id contains petId
  * def mine = response.filter(x => x.id == petId)[0]
  And match mine.name contains 'firu-'
  And match mine.status == 'sold'


@dataDriven
Scenario Outline: Crear mascotas con diferentes estados (Examples)
  * def body = { id: <id>, name: '<name>', status: '<status>' }
  * call read('classpath:api/pet/pet-api.feature@create') { body: #(body) }
  * match petCreated.status == '<status>'

Examples:
| id  | name  | status     |
| 801 | pepe  | available  |
| 802 | luna  | pending    |
| 803 | toby  | sold       |

#@dataFromJson
#Scenario: Data-driven desde JSON externo
#  * def pets = read('classpath:data/pets.json')
#  * karate.forEach(pets, function(p){
#  * karate.call('classpath:api/pet/pet-api.feature@create', { body: p });
#  * karate.match(petCreated.id, p.id);
#  })
