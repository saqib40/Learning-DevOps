# -----------------------------
# Build stage
# -----------------------------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

# -----------------------------
# Runtime + Datadog tracer
# -----------------------------
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

# Install Datadog .NET tracer (OFFICIAL METHOD)
RUN apt-get update \
 && apt-get install -y curl ca-certificates \
 && TRACER_VERSION=$(curl -s https://api.github.com/repos/DataDog/dd-trace-dotnet/releases/latest | grep tag_name | cut -d '"' -f 4) \
 && curl -L https://github.com/DataDog/dd-trace-dotnet/releases/download/${TRACER_VERSION}/datadog-dotnet-apm_${TRACER_VERSION#v}_amd64.deb \
    -o datadog-dotnet-apm.deb \
 && dpkg -i datadog-dotnet-apm.deb \
 && rm datadog-dotnet-apm.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy application
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "datadog1.dll"]
