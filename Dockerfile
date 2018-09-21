FROM java:8-jdk-alpine
VOLUME /tmp
COPY target/Proxy_Default-*.jar app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
