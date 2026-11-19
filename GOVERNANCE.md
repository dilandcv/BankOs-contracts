# PROTOCOLO DE GOBERNANZA DEL CONTRATO OPENAPI

**Regla de Oro:** El contrato `openapi.yaml` no se modifica para maquillar implementaciones deficientes o desalineadas. La implementación en código debe adaptarse al contrato.

---

## 1. Niveles de Versionado Semántico (SemVer)

- **PATCH (`v1.0.x`):** Corrección de descripciones, documentación de campos existentes o adición de metadatos opcionales que no alteran la serialización.
- **MINOR (`v1.x.0`):** Adición de nuevos endpoints, parámetros de consulta opcionales o campos adicionales en respuestas (retrocompatibles).
- **MAJOR (`v2.0.0`):** Eliminación de endpoints, cambio de rutas, modificación de tipos de datos, adición de campos requeridos en cuerpos de petición o cambios incompatibles de autenticación.

---

## 2. Flujo de Modificación RFC (Request for Comments)

1. **Creación del RFC:** El equipo solicitante (Frontend o Backend) abre un Pull Request / Issue en este repositorio describiendo el cambio propuesto en `openapi.yaml`.
2. **Revisión Obligatoria:** Requiere la aprobación cruzada explícita de:
   - Lead Frontend Developer
   - Lead Backend Engineer
   - Senior Software Architect
3. **Fusión y Etiquetado:** Tras la aprobación, se hace commit en `main`, se genera la nueva etiqueta `git tag vX.Y.Z` y se actualiza `openapi.sha256`.
4. **Despliegue Sincronizado:** Los repositorios `backend` y `mobile` actualizan su copia/submódulo e implementan el soporte correspondiente antes del paso a producción.
