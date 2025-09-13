# Ejecución del proyecto - PetStore con Karate

## Prerrequisitos
- Java 11+ (recomendado 17)
- Maven 3.8+

## Instalación
1) Clonar o descargar este repositorio.
2) Desde la raíz del proyecto, verificar dependencias:
   mvn -v

## Ejecución de pruebas
- Opción 1 (Maven):
  mvn test

- Opción 2 (scripts): (desde la carpeta raiz)
  - Windows:
    run.bat o .\run.bat

## Reportes
- Reporte HTML de Karate:
  target/karate-reports/karate-summary.html
  (abrir en el navegador)

- Reportes JUnit/Surefire:
  target/surefire-reports/

## Qué se prueba
1. Añadir una mascota (POST /pet)
2. Consultar por ID la mascota creada (GET /pet/{petId})
3. Actualizar nombre y estatus a "sold" (PUT /pet)
4. Consultar por estatus (GET /pet/findByStatus?status=sold) y validar que aparece la mascota actualizada

## Variables y Datos
- El ID de la mascota se genera aleatoriamente.
- Los nombres también incluyen el ID: "firulais-<id>" y "firulais-<id>-updated".

