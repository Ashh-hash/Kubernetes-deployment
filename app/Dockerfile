# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["CodeCraft.API/CodeCraft.API.csproj", "CodeCraft.API/"]
RUN dotnet restore "CodeCraft.API/CodeCraft.API.csproj"

# Copy the rest of the code
COPY . .
WORKDIR "/src/CodeCraft.API"

# Build and publish
RUN dotnet build "CodeCraft.API.csproj" -c Release -o /app/build
RUN dotnet publish "CodeCraft.API.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Set environment variables
ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_ENVIRONMENT=Production

# Expose port 80
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "CodeCraft.API.dll"] 