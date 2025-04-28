FROM quay.io/keycloak/keycloak:20.0.3 as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
RUN /opt/keycloak/bin/kc.sh build

# Configure a database vendor
ENV KC_DB=postgres

# for demonstration purposes only, please make sure to use proper certificates in production instead

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest 
COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak

ENV KC_DB=postgres
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV JAVA_OPTS_APPEND="-Djava.net.preferIPv4Stack=false"
ENV JAVA_OPTS_KC_HEAP = "-XX:MaxHeapFreeRatio=30 -XX:MaxRAMPercentage=65"

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--proxy-headers", "xforwarded"]