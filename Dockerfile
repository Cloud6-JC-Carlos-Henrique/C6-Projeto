FROM openjdk:16-jdk-alpine
COPY *.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]