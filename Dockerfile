FROM quay.io/keycloak/keycloak:26.2.1

# Variables de administración (valores por defecto)
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Configuraciones de Keycloak: Vincula a todas las interfaces y al puerto 10000
ENV KC_PROXY=edge
ENV KC_HTTP_HOST=0.0.0.0
ENV KC_HTTP_PORT=10000

# Configuraciones para la base de datos PostgreSQL
ENV KC_DB=postgres
ENV KC_DB_URL_HOST=yourdatabasehostname    
ENV KC_DB_URL_PORT=5432
ENV KC_DB_USERNAME=yourdbusername          
ENV KC_DB_PASSWORD=yourdbpassword          
ENV KC_DB_DATABASE=yourdatabasename 

# Expone el puerto 10000 para que Render lo detecte
EXPOSE 10000

# Inicia Keycloak en modo desarrollo
CMD ["start-dev"]
