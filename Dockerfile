# Stage 1: build du front Angular avec une image Node légère
FROM node:20-alpine AS front-build

COPY ./front /src

WORKDIR /src

# Install propre des dépendances + build Angular
RUN npm ci \
    && npm run build

# Stage 2: build du back Spring Boot via Gradle
FROM gradle:jdk17 AS back-build

COPY ./back /src

WORKDIR /src

# Corrige les fins de ligne Windows, rend le wrapper exécutable, build sans tests
RUN sed -i 's/\r$//' ./gradlew \
    && chmod +x ./gradlew \
    && ./gradlew build -x test

# Stage 3: runtime front (Caddy sert les fichiers statiques)
FROM alpine:3.19 AS front

COPY --from=front-build /src/dist/microcrm/browser /app/front
COPY misc/docker/Caddyfile /app/Caddyfile

RUN apk add caddy

WORKDIR /app

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/caddy", "run"]

# Stage 4: runtime back (JRE + JAR)
FROM alpine:3.19 AS back

COPY --from=back-build /src/build/libs/microcrm-0.0.1-SNAPSHOT.jar /app/back/microcrm-0.0.1-SNAPSHOT.jar

RUN apk add openjdk17-jre-headless

WORKDIR /app

EXPOSE 8080

CMD ["java", "-jar", "/app/back/microcrm-0.0.1-SNAPSHOT.jar"]

# Stage 5: image tout-en-un (front + back + supervisor)
FROM alpine:3.19 AS standalone

COPY --from=front / /
COPY --from=back / /
COPY misc/docker/supervisor.ini /app/supervisor.ini

RUN apk add supervisor

WORKDIR /app

CMD ["/usr/bin/supervisord", "-c", "/app/supervisor.ini"]



