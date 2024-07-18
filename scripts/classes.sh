##
# This script generates a list of test classes in the test target.
# The list is used to shard the tests and is written to a file in the project directory.
#
# Set the path to the output file
OUTPUT_FILE="${SRCROOT}/test_classes.txt"

# Find all Swift files in the test target and exclude the ones you don't want
TEST_FILES=$(find "${SRCROOT}/${TARGET_NAME}" -name "*.swift" -not -name "Info.plist")

# Print the found test files
echo "Found test files:"
echo "$TEST_FILES"
echo ""

# Initialize an empty string to store class names
CLASS_NAMES=""

# Determine the separator based on the build platform
if [ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]; then
    SEPARATOR="/"
else
    SEPARATOR="."
fi

# Get the class names from the Swift files that contain test methods
while IFS= read -r file; do
    # Check if the file contains a test method
    if grep -q "func test[A-Za-z0-9_]*()" "$file"; then
        # Extract the class name and append it to the list
        CLASS_NAME=$(grep -Eo "class [a-zA-Z_][a-zA-Z0-9_]*:*" "$file" | awk '{gsub(":", "", $2); print $2}')
        CLASS_NAMES+="$TARGET_NAME$SEPARATOR$CLASS_NAME"$'\n'
    fi
done <<< "$TEST_FILES"

# Remove duplicate class names
UNIQUE_CLASS_NAMES=$(echo "$CLASS_NAMES" | sort | uniq | grep -v '^$')

# Write the unique class names to the output file
echo "$UNIQUE_CLASS_NAMES" > "$OUTPUT_FILE"

# Print the class names and the path to the output file
echo "Test class names:"
echo "$UNIQUE_CLASS_NAMES"
echo ""
echo "Test class list has been created at: ${OUTPUT_FILE}"
