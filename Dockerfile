# Utiliser une image de base Maven avec JDK 17
FROM maven:3.8.7-openjdk-17 AS build

# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copier le fichier pom.xml et télécharger les dépendances Maven
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copier le code source du projet
COPY src ./src

# Construire le projet
RUN mvn clean package -DskipTests

# Utiliser une image de base plus légère pour exécuter l'application
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le jar de l'étape précédente
COPY --from=build /app/target/check-dependency-0.0.1-SNAPSHOT.jar /app/check-dependency-0.0.1-SNAPSHOT.jar

# Exposer le port de l'application
EXPOSE 8084

# Définir le point d'entrée de l'application
ENTRYPOINT ["java","-jar","/app/check-dependency-0.0.1-SNAPSHOT.jar"]
