FROM eclipse-temurin:17-jre-alpine

WORKDIR /opt/Lavalink

# Install native dependencies for libudpqueue (Lavalink native UDP queue bindings)
RUN apk add --no-cache libgcc libstdc++ gcompat

# Download Lavalink jar (Lavalink v4)
ADD https://github.com/lavalink-devs/Lavalink/releases/latest/download/Lavalink.jar Lavalink.jar

# Copy application configuration
COPY application.yml application.yml

# Copy cookies.txt for YouTube authentication (to bypass rate limit 403s)
COPY cookies.txt cookies.txt

EXPOSE 443

# JVM Tuning for limited environments (e.g. 512MB memory limit)
CMD ["java", "-Djava.net.preferIPv4Stack=true", "-Xmx512M", "-XX:+UseG1GC", "-jar", "Lavalink.jar"]