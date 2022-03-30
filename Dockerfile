# Change the below to match your version of Playwright from your .csproj file.
ARG PLAYWRIGHT_VERSION=1.20.2
# By using the official Playwright container pinned at the version of Playwright we are using, the Browsers and their dependencies
# will already be included! So you don't have to install them explicitly!
FROM mcr.microsoft.com/playwright/dotnet:v${PLAYWRIGHT_VERSION}-focal

# We copy the relevant test/project files in.
# NB: You can replace the below copies with a wider copy, but be sure to add a .dockerignore so you don't pick up unwanted files and build artifacts from the host
COPY PlaywrightTests/*.csproj /src/PlaywrightTests/
COPY PlaywrightTests/*.cs /src/PlaywrightTests/

WORKDIR /src/PlaywrightTests
# You might be able to leave the explicit build command off depending on your setup:
RUN dotnet build

# This is the command that will be run when our container is actually run!
CMD dotnet test -- NUnit.NumberOfTestWorkers=5
