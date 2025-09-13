ejecución de la prueba con jmeter:
    - parea ejecución se debe ubicar dentro de la carpeta jmeter \jmeter>
    - ejecuta el siguioente comando jmeter -n -t fakestoreapi_test.jmx -l results.jtl -e -o ./report
    - el reporte se genera automanticamente Reporte jmeter/report visualiza el archivo index.html

nota: para ejecutar mas de una vez, se debe borrar o reemplazar el nombre del archivo results.jtl en cada ejecución