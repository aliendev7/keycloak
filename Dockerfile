FROM quay.io/keycloak/keycloak:26.2.1

# Variables de administración (valores por defecto)
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Configuraciones de Keycloak
ENV KC_PROXY=edge
ENV KC_HOSTNAME=keycloak

# Configuraciones para la base de datos PostgreSQL
ENV KC_DB=postgres
ENV KC_DB_URL_HOST=your-database-hostname    # Ej. "postgres.my-render-db.internal"
ENV KC_DB_URL_PORT=5432
ENV KC_DB_USERNAME=your-db-username          # Ej. "myuser"
ENV KC_DB_PASSWORD=your-db-password          # Ej. "mypassword"
ENV KC_DB_DATABASE=your-database-name        # Ej. "keycloakdb"

# Inicia Keycloak en modo desarrollo
CMD ["start-dev"]
