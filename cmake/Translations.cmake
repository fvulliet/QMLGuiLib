find_package(${QtMajorVersion} COMPONENTS LinguistTools Core REQUIRED)
include(CMakeParseArguments)

# list of all languages we support
set(languages
    de_DE
    nb_NO
    en_EN
)

# Qt translations:
# ts files contain the sources and are "compiled" to .qm files which are binaries
list(TRANSFORM languages REPLACE "(.+)" "${CMAKE_SOURCE_DIR}/translations/reMarkable_\\1.ts" OUTPUT_VARIABLE ts_files)

# Write the .ts files in the translations directory:
set_source_files_properties(${ts_files} PROPERTIES OUTPUT_LOCATION translations)
set(TS_FILES "${ts_files}")
