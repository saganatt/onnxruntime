# Custom cmake config file by jcarius to enable find_package(ONNXRuntime)
# without modifying LIBRARY_PATH and LD_LIBRARY_PATH
# From: https://stackoverflow.com/a/66494534
#
# This will define the following variables:
#   ONNXRuntime_FOUND        -- True if the system has the onnxruntime library
#   ONNXRuntime_INCLUDE_DIRS -- The include directories for onnxruntime
#   ONNXRuntime_LIBRARIES    -- Libraries to link against
#   ONNXRuntime_CXX_FLAGS    -- Additional (required) compiler flags

include(FindPackageHandleStandardArgs)

# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

set(ONNXRuntime_INCLUDE_DIRS ${_IMPORT_PREFIX}/include)
set(ONNXRuntime_CXX_FLAGS "") # no flags needed

find_library(ONNXRuntime_LIBRARY onnxruntime
    PATHS ${_IMPORT_PREFIX}/lib
)

add_library(ONNXRuntime::ONNXRuntime SHARED IMPORTED)
set_property(TARGET ONNXRuntime::ONNXRuntime PROPERTY IMPORTED_LOCATION "${ONNXRuntime_LIBRARY}")
set_property(TARGET ONNXRuntime::ONNXRuntime PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${ONNXRuntime_INCLUDE_DIRS}")
set_property(TARGET ONNXRuntime::ONNXRuntime PROPERTY INTERFACE_COMPILE_OPTIONS "${ONNXRuntime_CXX_FLAGS}")

find_package_handle_standard_args(ONNXRuntime::ONNXRuntime DEFAULT_MSG ONNXRuntime_LIBRARY ONNXRuntime_INCLUDE_DIRS)
