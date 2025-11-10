# 1) Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY HelloWorldApp/*.csproj HelloWorldApp/
RUN dotnet restore HelloWorldApp/HelloWorldApp.csproj
COPY . .
RUN dotnet publish HelloWorldApp/HelloWorldApp.csproj -c Release -o /app/publish

# 2) Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet","HelloWorldApp.dll"]
