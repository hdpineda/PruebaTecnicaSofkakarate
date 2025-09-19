Feature: util retry with backoff

Scenario: wait GET by id returns 200
  * def id = __arg.id
  * def pathSegs = __arg.path
  * def max = __arg.max || 10
  * def interval = __arg.interval || 1000
  * configure retry = { count: #(max), interval: #(interval) }

  Given path pathSegs, id
  And retry until responseStatus == 200
  When method get
  Then status 200