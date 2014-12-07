### Version control policy
###
### Extract current version from version control if present.  If
### source is not under source control - take from .version
### file. Otherwise current version is 0.0

if (EXISTS "${CMAKE_SOURCE_DIR}/.git")
  execute_process (COMMAND git describe
    OUTPUT_VARIABLE GIT_TAG_VERSION)
  if (GIT_TAG_VERSION)
    file (WRITE .version "${GIT_TAG_VERSION}")
  endif ()
else ()
  if (EXISTS "${CMAKE_SOURCE_DIR}/.version")
    execute_process (COMMAND cat .version
      OUTPUT_VARIABLE GIT_TAG_VERSION)
  endif ()
endif ()
## Parse version
if (NOT GIT_TAG_VERSION)
  message (WARNING "No version information was found! "
    "Package should be built from correct source tree.")
  set (TRUT_VERSION_MAJOR 0)
  set (TRUT_VERSION_MINOR 0)
  set (TRUT_VERSION "0.0")
  set (TRUT_VERSION_FULL "unknown")
else ()
  execute_process (COMMAND echo "${GIT_TAG_VERSION}"
    COMMAND sed -ne "s/^v\\([[:digit:]]*\\)\\..*/\\1/p"
    OUTPUT_VARIABLE TRUT_VERSION_MAJOR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process (COMMAND echo "${GIT_TAG_VERSION}"
    COMMAND sed -ne "s/^v[[:digit:]]*\\.\\([[:digit:]]*\\).*/\\1/p"
    OUTPUT_VARIABLE TRUT_VERSION_MINOR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process (COMMAND echo "${GIT_TAG_VERSION}"
    COMMAND sed -ne "s/.*-\\(.*\\)/\\1/p"
    OUTPUT_VARIABLE TRUT_VERSION_DIRT
    OUTPUT_STRIP_TRAILING_WHITESPACE)

  set (TRUT_VERSION "${TRUT_VERSION_MAJOR}.${TRUT_VERSION_MINOR}")
  if (TRUT_VERSION_DIRT)
    set (TRUT_VERSION_FULL "${TRUT_VERSION}-${TRUT_VERSION_DIRT}")
  else ()
    set (TRUT_VERSION_FULL "${TRUT_VERSION}")
  endif ()
  
  message (STATUS "Building version: ${TRUT_VERSION_FULL}")
endif ()