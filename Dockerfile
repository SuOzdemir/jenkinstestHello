FROM adoptopenjdk/openjdk11:alpine-jre
VOLUME /tmp
ARG JAR_FILE=target/hello-world*.jar
ADD ${JAR_FILE} /app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
