# BBVA – Indra | BI Data Integration Project

## 📌 Descripción

Proyecto de Business Intelligence enfocado en la integración, transformación y modelado de datos financieros para su consumo en plataformas de análisis y reporting.

El objetivo del proyecto fue centralizar información operativa proveniente de múltiples fuentes, estandarizarla y generar capas analíticas optimizadas para análisis de negocio.

---

## Arquitectura General
- Fuentes de datos operativas (bases de datos y archivos planos)
- Procesos ETL / ELT mediante scripts SQL
- Capa analítica basada en QVDs
- Consumo en herramientas de Business Intelligence

---

## Estructura del Proyecto
/ProgMigracionInicial
/NroCuenta
/functionTitania.sql
/insertTitania.sql
/mconten.backup
/mconten.csv
/mpredio.backup
/mpropi.backup
/observaciones.txt
---

## Modelo de Datos (QVDs)
- QVD_Cuentas.qvd  
  Información de cuentas y clientes.

- QVD_Transacciones.qvd  
  Movimientos financieros consolidados.

- QVD_Propiedades.qvd  
  Datos relacionados con predios y activos.

- QVD_Observaciones.qvd  
  Observaciones y notas operativas.

---

## Procesos ETL
- Extracción de datos desde múltiples fuentes
- Limpieza y normalización de información
- Validación de integridad y consistencia
- Generación incremental de QVDs
- Optimización para consumo analítico

---

## Tecnologías Utilizadas
- SQL
- Qlik (QVD Layer)
- Modelado de datos
- Procesos ETL / Data Integration

---

## Resultados
- Optimización de tiempos de carga
- Modelo de datos reutilizable
- Información confiable para análisis financiero
- Base sólida para dashboards ejecutivos y operativos

---

## Notas
Este repositorio representa un caso práctico de integración de datos en un entorno bancario, enfocado en buenas prácticas de Business Intelligence y performance.
