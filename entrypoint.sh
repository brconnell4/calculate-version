#!/bin/bash -l

# Execute dotnet-gitversion and store the output
OUTPUT=$(./dotnet-gitversion)

# Extract branch name from Github environment variable
BRANCH_NAME=$(echo "$GITHUB_HEAD_REF" | sed 's/features\///')

# Parse JSON and extract the version information
SemVer=$(echo "$OUTPUT" | jq -r .MajorMinorPatch)
PRE_RELEASE=$(echo "$OUTPUT" | jq -r .PreReleaseNumber)

## Determine if prod flag is true
if [ "${INPUT_PROD}" == "true" ]; then
    VERSION="${SemVer}"
    GIT_VERSION="v${SemVer}"
else
    VERSION="${SemVer}-${BRANCH_NAME}.${PRE_RELEASE}"
    GIT_VERSION="v${SemVer}-${BRANCH_NAME}.${GITVERSION_PRERELEASENUMBER}"
fi

echo "Branch Name: ${BRANCH_NAME}"
echo "Production Build: ${INPUT_PROD}"
echo "SemVer: ${SemVer}"
echo "Git Version: ${GIT_VERSION}"
echo "Version: ${VERSION}"