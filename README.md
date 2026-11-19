# BankOS — Contratos Oficiales de API (contracts)

**Versión actual:** `v1.0.0`  
**Hash SHA-256:** `f454d326e4b4ba731db6c422241595fd1d90021277e18531afff90fa26336141`  
**Especificación:** OpenAPI 3.1.0  

---

## 1. Propósito

Este repositorio constituye la **única fuente de verdad inquebrantable** para la comunicación entre la aplicación móvil Flutter y el backend Spring Boot de BankOS.

Ningún cambio a la API puede ser realizado de forma unilateral en el código de backend o frontend sin haber sido previamente aprobado, fusionado y versionado en este repositorio.

---

## 2. Contenido

- `openapi.yaml`: Especificación oficial de endpoints, DTOs, códigos de respuesta, cabeceras (`Idempotency-Key`, `X-Correlation-ID`) y esquemas de seguridad Bearer JWT.
- `openapi.sha256`: Suma de verificación criptográfica para asegurar la integridad bit a bit.
- `GOVERNANCE.md`: Reglas formales y procedimiento RFC de modificación.
- `scripts/verify-parity.sh`: Script de verificación de paridad entre repositorios.

---

## 3. Verificación de Paridad

Para verificar que un repositorio cliente (`backend` o `mobile`) tiene exactamente la misma versión del contrato:

```bash
./scripts/verify-parity.sh path/al/repositorio
```
