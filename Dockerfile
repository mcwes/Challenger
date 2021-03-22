FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /Challenger

# Copy csproj and restore as distinct layers
COPY /Challenger/Challenger.csproj .
RUN dotnet restore "Challenger.csproj"

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /Chanllenger/out .
ENTRYPOINT ["dotnet", "Challenger.dll"]