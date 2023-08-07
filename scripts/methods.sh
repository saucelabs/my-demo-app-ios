##
# This script generates a list of methods in the test target.
# The list is used to shard the tests and is written to a file in the project directory.
#
# Set the path to the output file
OUTPUT_FILE="${SRCROOT}/test_classes_and_tests.txt"

# Find all Swift files in the test target and exclude the ones you don't want
TEST_FILES=$(find "${SRCROOT}/${TARGET_NAME}" -name "*.swift" -not -name "Info.plist")

# Print the found test files
echo "Found test files:"
echo "$TEST_FILES"
echo ""

# Initialize an empty string to store class names and test names
CLASS_AND_TEST_NAMES=""

# Determine the separator based on the build platform
if [ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]; then
    SEPARATOR="/"
else
    SEPARATOR="."
fi

# Get the class names and test names from the Swift files that contain test methods
while IFS= read -r file; do
    # Check if the file contains a test method
    if grep -q "func test[A-Za-z0-9_]*()" "$file"; then
        # Extract the class name
        CLASS_NAME=$(grep -Eo "class [a-zA-Z_][a-zA-Z0-9_]*:*" "$file" | awk '{gsub(":", "", $2); print $2}')

        # Extract the test names
        TEST_NAMES=$(grep -Eo "func test[A-Za-z0-9_]*()" "$file" | awk '{gsub("(func |\\(\\))", "", $2); print $2}')

        # Loop through each test name and append it to the list
        while IFS= read -r test_name; do
            CLASS_AND_TEST_NAMES+="$TARGET_NAME$SEPARATOR$CLASS_NAME/$test_name"$'\n'
        done <<< "$TEST_NAMES"
    fi
done <<< "$TEST_FILES"

# Remove duplicate class and test names
UNIQUE_CLASS_AND_TEST_NAMES=$(echo "$CLASS_AND_TEST_NAMES" | sort | uniq | grep -v '^$')

# Write the unique class and test names to the output file
echo "$UNIQUE_CLASS_AND_TEST_NAMES" > "$OUTPUT_FILE"

# Print the class and test names and the path to the output file
echo "Test class names and test names:"
echo "$UNIQUE_CLASS_AND_TEST_NAMES"
echo ""
echo "Test class and test list has been created at: ${OUTPUT_FILE}"
