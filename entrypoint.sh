#!/bin/bash -l

# Execute dotnet-gitversion and store the output
OUTPUT=$(/tools/dotnet-gitversion)

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
    GIT_VERSION="v${SemVer}-${BRANCH_NAME}.${PRE_RELEASE}"
fi

echo "BRANCH_NAME=${BRANCH_NAME}" >> $GITHUB_OUTPUT
echo "BRANCH_NAME: ${BRANCH_NAME}"

echo "PRODUCTION_BUILD=${INPUT_PROD}" >> "$GITHUB_OUTPUT"
echo "PRODUCTION_BUILD: ${INPUT_PROD}"

echo "VERSION=${VERSION}" >> "$GITHUB_OUTPUT"
echo "VERSION: ${VERSION}"

echo "GIT_VERSION=${GIT_VERSION}" >> "$GITHUB_OUTPUT"
echo "GIT_VERSION: ${GIT_VERSION}"