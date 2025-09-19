@echo off
set KARATE_ENV=dev
echo Running Karate on %KARATE_ENV% ...
mvn -q clean test -Dkarate.env=%KARATE_ENV%
start target\karate-reports\karate-summary.html

