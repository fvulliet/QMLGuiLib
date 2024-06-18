
include(CMakeParseArguments)

function(load_extern_cache)
    cmake_parse_arguments(EXT "" "CACHE_DIR" "VAR_LIST" ${ARGN})
    if(EXT_CACHE_DIR)
      load_cache(${EXT_CACHE_DIR} READ_WITH_PREFIX "EXT_" ${EXT_VAR_LIST})
      foreach(EXT_VAR ${EXT_VAR_LIST})
        if(EXT_${EXT_VAR})
            set(${EXT_VAR} ${EXT_${EXT_VAR}} CACHE STRING "" FORCE)
        endif()
      endforeach()
    endif (EXT_CACHE_DIR)
endfunction()
