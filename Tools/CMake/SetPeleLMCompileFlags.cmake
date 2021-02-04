if(PELELM_ENABLE_ALL_WARNINGS)
  list(APPEND PELELM_CXX_FLAGS "-Wall" "-Wextra" "-pedantic" "-Wno-unused-function")
  if(CMAKE_CXX_COMPILER_ID MATCHES "^(GNU|Clang|AppleClang)$")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 7.0)
      list(APPEND PELELM_CXX_FLAGS "-faligned-new"
                                  "-Wunreachable-code"
                                  "-Wnull-dereference"
                                  "-Wfloat-conversion"
                                  "-Wshadow"
                                  "-Woverloaded-virtual")
      if(CMAKE_CXX_COMPILER_ID MATCHES "^(Clang|AppleClang)$")
        list(APPEND PELELM_CXX_FLAGS "-Wno-pass-failed")
      endif()
    endif()
  endif()
  if(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
    list(APPEND PELELM_CXX_FLAGS "-diag-disable:11074,11076,10397,15335")
  endif()
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  list(APPEND PELELM_Fortran_FLAGS "-ffree-line-length-none"
                                   "-ffixed-line-length-none"
                                   "-fno-range-check"
                                   "-fno-second-underscore")
endif()

if(PELELM_ENABLE_WERROR)
  list(APPEND PELELM_CXX_FLAGS "-Werror")
endif()

separate_arguments(PELELM_CXX_FLAGS)
separate_arguments(PELELM_Fortran_FLAGS)
target_compile_options(${pelelm_exe_name} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${PELELM_CXX_FLAGS}>)
target_compile_options(${pelelm_exe_name} PRIVATE $<$<COMPILE_LANGUAGE:Fortran>:${PELELM_Fortran_FLAGS}>)
