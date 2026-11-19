# BankOS — Contratos Oficiales de API (`BankOs-contracts`)

**Versión actual:** `v1.0.0`  
**Hash SHA-256:** `f454d326e4b4ba731db6c422241595fd1d90021277e18531afff90fa26336141`  
**Especificación:** OpenAPI 3.1.0  
**Repositorios del Ecosistema:**
- Backend: [BankOs-backend](https://github.com/dilandcv/BankOs-backend)
- Mobile/Frontend: [BanckOs-mobile](https://github.com/dilandcv/BanckOs-mobile)
- Contratos (Este repositorio): [BankOs-contracts](https://github.com/dilandcv/BankOs-contracts)

---

## 1. ¿Para qué es este repositorio?

Este repositorio es la **única fuente de verdad inquebrantable (Single Source of Truth)** para la arquitectura dirigida por contratos (*Contract-First Architecture*) de BankOS.

Contiene el archivo canónico `openapi.yaml` que rige formalmente:
- Todos los endpoints REST y métodos HTTP.
- Esquemas de request/response y DTOs estandarizados.
- Cabeceras financieras obligatorias (`Idempotency-Key`, `X-Correlation-ID`).
- Esquemas de seguridad (Bearer JWT, multi-tenant claims).
- Códigos de error y sobres JSON estandarizados (`success`, `code`, `message`, `data`, `correlation_id`).

### ¿Por qué existe de manera independiente?
En un entorno bancario y de microservicios/monolito modular donde frontend y backend son desarrollados por equipos separados:
1. **Evita la divergencia:** Impide que backend invente endpoints o que frontend espere formatos distintos.
2. **Desacoplamiento total:** Permite versionar la API independientemente de los ciclos de despliegue de código.
3. **Validación automática (CI/CD):** Tanto backend como mobile incluyen pruebas automatizadas que calculan la suma de verificación SHA-256 del contrato y fallan la compilación si existe una diferencia de tan solo 1 byte respecto a esta versión canónica.

---

## 2. ¿Cuál repositorio debo clonar si quiero probar el proyecto completo?

> **Si tu objetivo es ejecutar y probar la aplicación completa funcionando en tiempo real:**
> **NO necesitas clonar este repositorio.**  
>
> Debes clonar los repositorios ejecutables:
> 1. **[BankOs-backend](https://github.com/dilandcv/BankOs-backend.git)**: Para levantar la base de datos PostgreSQL, Redis y la API Spring Boot con Docker Compose.
> 2. **[BanckOs-mobile](https://github.com/dilandcv/BanckOs-mobile.git)**: Para ejecutar la interfaz gráfica Flutter en Web, Android o iOS.
>
> *(Consulta la guía rápida de ejecución más abajo).*

**¿Cuándo se clona este repositorio (`BankOs-contracts`)?**
- Cuando seas el Arquitecto de Software o un desarrollador proponiendo un cambio a la API mediante el flujo formal de **RFC (Request for Comments)** descrito en [`GOVERNANCE.md`](./GOVERNANCE.md).

---

## 3. Guía Rápida para Probar el Proyecto Completo

Si deseas probar el ecosistema BankOS de extremo a extremo:

### Paso 1: Levantar el Backend (Servicios y Base de Datos)
```bash
git clone https://github.com/dilandcv/BankOs-backend.git
cd BankOs-backend
cp .env.example .env
docker compose up --build -d
```
- Verifica salud: `curl http://localhost:8080/actuator/health` (debe responder `{"status":"UP"}`).
- Swagger UI interactivo: `http://localhost:8080/swagger-ui.html`.

### Paso 2: Levantar el Cliente Flutter
```bash
git clone https://github.com/dilandcv/BanckOs-mobile.git
cd BanckOs-mobile
flutter pub get
flutter run -d chrome    # Ejecutar en Google Chrome
# o simplemente 'flutter run' con tu emulador/dispositivo conectado
```

### Paso 3: Credenciales de Prueba (Seed Oficial)
- **Contraseña para todos los usuarios:** `Admin123!`
- **Institución / Tenant:** `BANCO_HORIZONTE`
- **Correo:** `admin@horizonte.com`
- **Contraseña:** `Admin123!`

*(Otras instituciones disponibles: `NEQUI`, `DAVIPLATA`, `PAYPAL`, `BANCOLOMBIA`, `NU`, `PLATFORM`).*

---

## 4. Estructura de este Repositorio

- `openapi.yaml`: Especificación OpenAPI 3.1.0 oficial de la API de BankOS.
- `openapi.sha256`: Hash criptográfico SHA-256 del contrato canónico.
- `GOVERNANCE.md`: Protocolo de gobernanza, ciclo de vida del versionado semántico y reglas de RFC para aprobar cambios.
- `scripts/verify-parity.sh`: Script ejecutable para verificar la integridad y paridad de copias locales en repositorios clientes.

---

## 5. Verificación de Integridad de Contratos

Para verificar que un repositorio cliente (`backend` o `mobile`) tenga exactamente la versión oficial:

```bash
./scripts/verify-parity.sh path/al/repositorio
```

Salida esperada:
```
[PARITY CHECK] Comparing openapi.yaml with path/al/repositorio/openapi.yaml
Canonical SHA-256: f454d326e4b4ba731db6c422241595fd1d90021277e18531afff90fa26336141
Target SHA-256:    f454d326e4b4ba731db6c422241595fd1d90021277e18531afff90fa26336141
[SUCCESS] Contract parity verified. No drift detected.
```
