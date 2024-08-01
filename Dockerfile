# Utiliser une image de base officielle Java 17
FROM openjdk:17-jdk-slim

# Ajouter un label pour identifier la maintenabilité de l'image
LABEL maintainer="your-email@example.com"

# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copier le fichier pom.xml et télécharger les dépendances Maven
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copier le code source du projet
COPY src ./src

# Construire le projet
RUN mvn clean package -DskipTests

# Exposer le port de l'application
EXPOSE 8080

# Définir le point d'entrée de l'application
ENTRYPOINT ["java","-jar","target/crud-vulnerable-1.0-SNAPSHOT.jar"]
