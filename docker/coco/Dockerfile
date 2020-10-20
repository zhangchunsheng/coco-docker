FROM openjdk:8-jre
COPY application.yml application.yml
COPY coco.jar coco.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","coco.jar"]