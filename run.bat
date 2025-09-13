@echo off
echo Ejecutando pruebas Karate...
mvn -q test
echo Reporte: target\karate-reports\karate-summary.html
