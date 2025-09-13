function fn() {
  var env = karate.env || 'dev';
  var config = {
    env: env,
    baseUrl: 'https://petstore.swagger.io/v2' // default
  };
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 15000);
  return config;
}
