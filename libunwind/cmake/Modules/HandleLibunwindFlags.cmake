# HandleLibcxxFlags - A set of macros used to setup the flags used to compile
# and link libc++abi. These macros add flags to the following CMake variables.
# - LIBUNWIND_COMPILE_FLAGS: flags used to compile libunwind
# - LIBUNWIND_LINK_FLAGS: flags used to link libunwind
# - LIBUNWIND_LIBRARIES: libraries to link libunwind to.

include(CheckCCompilerFlag)
include(CheckCXXCompilerFlag)

unset(add_flag_if_supported)

# Mangle the name of a compiler flag into a valid CMake identifier.
# Ex: --std=c++11 -> STD_EQ_CXX11
macro(mangle_name str output)
  string(STRIP "${str}" strippedStr)
  string(REGEX REPLACE "^/" "" strippedStr "${strippedStr}")
  string(REGEX REPLACE "^-+" "" strippedStr "${strippedStr}")
  string(REGEX REPLACE "-+$" "" strippedStr "${strippedStr}")
  string(REPLACE "-" "_" strippedStr "${strippedStr}")
  string(REPLACE "=" "_EQ_" strippedStr "${strippedStr}")
  string(REPLACE "+" "X" strippedStr "${strippedStr}")
  string(TOUPPER "${strippedStr}" ${output})
endmacro()

# Remove a list of flags from all CMake variables that affect compile flags.
# This can be used to remove unwanted flags specified on the command line
# or added in other parts of LLVM's cmake configuration.
macro(remove_flags)
  foreach(var ${ARGN})
    string(REPLACE "${var}" "" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
    string(REPLACE "${var}" "" CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL}")
    string(REPLACE "${var}" "" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
    string(REPLACE "${var}" "" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
    string(REPLACE "${var}" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    string(REPLACE "${var}" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
    string(REPLACE "${var}" "" CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
    string(REPLACE "${var}" "" CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}")
    string(REPLACE "${var}" "" CMAKE_SHARED_MODULE_FLAGS "${CMAKE_SHARED_MODULE_FLAGS}")
    remove_definitions(${var})
  endforeach()
endmacro(remove_flags)

macro(check_flag_supported flag)
    mangle_name("${flag}" flagname)
    check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
endmacro()

macro(append_flags DEST)
  foreach(value ${ARGN})
    list(APPEND ${DEST} ${value})
    list(APPEND ${DEST} ${value})
  endforeach()
endmacro()

# If the specified 'condition' is true then append the specified list of flags to DEST
macro(append_flags_if condition DEST)
  if (${condition})
    list(APPEND ${DEST} ${ARGN})
  endif()
endmacro()

# Add each flag in the list specified by DEST if that flag is supported by the current compiler.
macro(append_flags_if_supported DEST)
  foreach(flag ${ARGN})
    mangle_name("${flag}" flagname)
    check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
    append_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${DEST} ${flag})
  endforeach()
endmacro()

# Add a macro definition if condition is true.
macro(define_if condition def)
  if (${condition})
    add_definitions(${def})
  endif()
endmacro()

# Add a macro definition if condition is not true.
macro(define_if_not condition def)
  if (NOT ${condition})
    add_definitions(${def})
  endif()
endmacro()

# Add a macro definition to the __config_site file if the specified condition
# is 'true'. Note that '-D${def}' is not added. Instead it is expected that
# the build include the '__config_site' header.
macro(config_define_if condition def)
  if (${condition})
    set(${def} ON)
    set(LIBUNWIND_NEEDS_SITE_CONFIG ON)
  endif()
endmacro()

macro(config_define_if_not condition def)
  if (NOT ${condition})
    set(${def} ON)
    set(LIBUNWIND_NEEDS_SITE_CONFIG ON)
  endif()
endmacro()

macro(config_define value def)
  set(${def} ${value})
  set(LIBUNWIND_NEEDS_SITE_CONFIG ON)
endmacro()

# Add a list of flags to all of 'CMAKE_CXX_FLAGS', 'CMAKE_C_FLAGS',
# 'LIBUNWIND_COMPILE_FLAGS' and 'LIBUNWIND_LINK_FLAGS'.
macro(add_target_flags)
  foreach(value ${ARGN})
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${value}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${value}")
    list(APPEND LIBUNWIND_COMPILE_FLAGS ${value})
    list(APPEND LIBUNWIND_LINK_FLAGS ${value})
  endforeach()
endmacro()

# If the specified 'condition' is true then add a list of flags to
# all of 'CMAKE_CXX_FLAGS', 'CMAKE_C_FLAGS', 'LIBUNWIND_COMPILE_FLAGS'
# and 'LIBUNWIND_LINK_FLAGS'.
macro(add_target_flags_if condition)
  if (${condition})
    add_target_flags(${ARGN})
  endif()
endmacro()

# Add all the flags supported by the compiler to all of
# 'CMAKE_CXX_FLAGS', 'CMAKE_C_FLAGS', 'LIBUNWIND_COMPILE_FLAGS'
# and 'LIBUNWIND_LINK_FLAGS'.
macro(add_target_flags_if_supported)
  foreach(flag ${ARGN})
    mangle_name("${flag}" flagname)
    check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
    add_target_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a specified list of flags to both 'LIBUNWIND_COMPILE_FLAGS' and
# 'LIBUNWIND_LINK_FLAGS'.
macro(add_flags)
  foreach(value ${ARGN})
    list(APPEND LIBUNWIND_COMPILE_FLAGS ${value})
    list(APPEND LIBUNWIND_LINK_FLAGS ${value})
  endforeach()
endmacro()

# If the specified 'condition' is true then add a list of flags to both
# 'LIBUNWIND_COMPILE_FLAGS' and 'LIBUNWIND_LINK_FLAGS'.
macro(add_flags_if condition)
  if (${condition})
    add_flags(${ARGN})
  endif()
endmacro()

# Add each flag in the list to LIBUNWIND_COMPILE_FLAGS and LIBUNWIND_LINK_FLAGS
# if that flag is supported by the current compiler.
macro(add_flags_if_supported)
  foreach(flag ${ARGN})
      mangle_name("${flag}" flagname)
      check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
      add_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a list of flags to 'LIBUNWIND_COMPILE_FLAGS'.
macro(add_compile_flags)
  foreach(f ${ARGN})
    list(APPEND LIBUNWIND_COMPILE_FLAGS ${f})
  endforeach()
endmacro()

# If 'condition' is true then add the specified list of flags to
# 'LIBUNWIND_COMPILE_FLAGS'
macro(add_compile_flags_if condition)
  if (${condition})
    add_compile_flags(${ARGN})
  endif()
endmacro()

# For each specified flag, add that flag to 'LIBUNWIND_COMPILE_FLAGS' if the
# flag is supported by the C++ compiler.
macro(add_compile_flags_if_supported)
  foreach(flag ${ARGN})
      mangle_name("${flag}" flagname)
      check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
      add_compile_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a list of flags to 'LIBUNWIND_C_FLAGS'.
macro(add_c_flags)
  foreach(f ${ARGN})
    list(APPEND LIBUNWIND_C_FLAGS ${f})
  endforeach()
endmacro()

# If 'condition' is true then add the specified list of flags to
# 'LIBUNWIND_C_FLAGS'
macro(add_c_flags_if condition)
  if (${condition})
    add_c_flags(${ARGN})
  endif()
endmacro()

# For each specified flag, add that flag to 'LIBUNWIND_C_FLAGS' if the
# flag is supported by the C compiler.
macro(add_c_compile_flags_if_supported)
  foreach(flag ${ARGN})
      mangle_name("${flag}" flagname)
      check_c_compiler_flag("${flag}" "C_SUPPORTS_${flagname}_FLAG")
      add_c_flags_if(C_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a list of flags to 'LIBUNWIND_CXX_FLAGS'.
macro(add_cxx_flags)
  foreach(f ${ARGN})
    list(APPEND LIBUNWIND_CXX_FLAGS ${f})
  endforeach()
endmacro()

# If 'condition' is true then add the specified list of flags to
# 'LIBUNWIND_CXX_FLAGS'
macro(add_cxx_flags_if condition)
  if (${condition})
    add_cxx_flags(${ARGN})
  endif()
endmacro()

# For each specified flag, add that flag to 'LIBUNWIND_CXX_FLAGS' if the
# flag is supported by the C compiler.
macro(add_cxx_compile_flags_if_supported)
  foreach(flag ${ARGN})
      mangle_name("${flag}" flagname)
      check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
      add_cxx_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a list of flags to 'LIBUNWIND_LINK_FLAGS'.
macro(add_link_flags)
  foreach(f ${ARGN})
    list(APPEND LIBUNWIND_LINK_FLAGS ${f})
  endforeach()
endmacro()

# If 'condition' is true then add the specified list of flags to
# 'LIBUNWIND_LINK_FLAGS'
macro(add_link_flags_if condition)
  if (${condition})
    add_link_flags(${ARGN})
  endif()
endmacro()

# For each specified flag, add that flag to 'LIBUNWIND_LINK_FLAGS' if the
# flag is supported by the C++ compiler.
macro(add_link_flags_if_supported)
  foreach(flag ${ARGN})
    mangle_name("${flag}" flagname)
    check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
    add_link_flags_if(CXX_SUPPORTS_${flagname}_FLAG ${flag})
  endforeach()
endmacro()

# Add a list of libraries or link flags to 'LIBUNWIND_LIBRARIES'.
macro(add_library_flags)
  foreach(lib ${ARGN})
    list(APPEND LIBUNWIND_LIBRARIES ${lib})
  endforeach()
endmacro()

# if 'condition' is true then add the specified list of libraries and flags
# to 'LIBUNWIND_LIBRARIES'.
macro(add_library_flags_if condition)
  if(${condition})
    add_library_flags(${ARGN})
  endif()
endmacro()

# Turn a comma separated CMake list into a space separated string.
macro(split_list listname)
  string(REPLACE ";" " " ${listname} "${${listname}}")
endmacro()

# For each specified flag, add that compile flag to the provided target.
# The flags are added with the given visibility, i.e. PUBLIC|PRIVATE|INTERFACE.
function(target_add_compile_flags_if_supported target visibility)
  foreach(flag ${ARGN})
    mangle_name("${flag}" flagname)
    check_cxx_compiler_flag("${flag}" "CXX_SUPPORTS_${flagname}_FLAG")
    if (CXX_SUPPORTS_${flagname}_FLAG)
      target_compile_options(${target} ${visibility} ${flag})
    endif()
  endforeach()
endfunction()
