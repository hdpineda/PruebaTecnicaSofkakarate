function fn() {
  var env = karate.env || 'dev';
  var config = { env: env };

  // Base por environment
  if (env == 'dev') {
    config.baseUrl = 'https://petstore.swagger.io/v2';
  }
  if (env == 'qa') {
    config.baseUrl = 'https://petstore.swagger.io/v2';
    karate.configure('ssl', true);
  }
  if (env == 'stg') {
    config.baseUrl = 'https://petstore.swagger.io/v2';
  }

  // Timeouts robustos
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 20000);

  // Retries globales (se activan sólo con "retry until")
  karate.configure('retry', { count: 5, interval: 800 });

  // Logs: compactos en CI
  if (karate.properties['ci']) {
    karate.configure('logPrettyRequest', false);
    karate.configure('logPrettyResponse', false);
  } else {
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
  }

  return config;
}
