FROM maven:3.5.3-jdk-8 AS build

COPY src/ src/
COPY pom.xml pom.xml

RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

FROM java:8-jdk-alpine
RUN adduser -Dh /home/treeptik treeptik
COPY --from=build target/springboot.helloworld.rest-0.0.2.jar /home/treeptik/

EXPOSE 8181
ENTRYPOINT [ "java", "-jar", "/home/treeptik/springboot.helloworld.rest-0.0.2.jar" ]
