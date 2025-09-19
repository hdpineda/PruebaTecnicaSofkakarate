Feature: Pet API

Background:
  * url baseUrl
  * header Accept = 'application/json'

@create
Scenario: create pet
  * def body = __arg.body
  Given path 'pet'
  And request body
  When method post
  Then status 200
  * def result = response
  * karate.set('petCreated', result)

@get
Scenario: get pet by id
  * def id = __arg.id
  Given path 'pet', id
  When method get
  Then status 200

@update
Scenario: update pet
  * def body = __arg.body
  Given path 'pet'
  And request body
  When method put
  Then status 200

@findByStatus
Scenario: find pets by status
  * def status = __arg.status
  Given path 'pet', 'findByStatus'
  And param status = status
  When method get
  Then status 200
