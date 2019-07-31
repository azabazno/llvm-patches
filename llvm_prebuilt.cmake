#===================== begin_copyright_notice ==================================
# 
# Copyright (c) 2018 Intel Corporation.
# 
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
# 
# ======================= end_copyright_notice ==================================

set(LLVM_BUILD_TYPE ${CMAKE_BUILD_TYPE})

if(DEFINED BUILD_TYPE)
  if(${BUILD_TYPE} STREQUAL "release")
    set(LLVM_BUILD_TYPE "Release")
  else()
    set(LLVM_BUILD_TYPE "Debug")
  endif()
endif()

if(NOT DEFINED LLVM_BUILD_PREBUILDS_DIR)
  if(NOT EXISTS ${LLVM_BUILD_PREBUILDS_DIR})
    set(LLVM_BUILD_PREBUILDS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../prebuild-llvm/${LLVM_BUILD_TYPE}")
  endif()
endif()


if(EXISTS ${LLVM_BUILD_PREBUILDS_DIR}/include)
  list(APPEND CMAKE_MODULE_PATH "${LLVM_BUILD_PREBUILDS_DIR}/lib/cmake/llvm/")
   
  set(LLVM_DIR ${LLVM_BUILD_PREBUILDS_DIR}/lib/cmake/llvm)  
  include(${LLVM_BUILD_PREBUILDS_DIR}/lib/cmake/llvm/LLVMConfig.cmake)
  include(${LLVM_BUILD_PREBUILDS_DIR}/lib/cmake/llvm/AddLLVM.cmake)
  
  find_package(LLVM REQUIRED CONFIG)
  
  set(LLVM_INCLUDE_DIRS "${LLVM_BUILD_PREBUILDS_DIR}/include")
  
  set(LLVM_USE_PREBUILT true)
  
  message(STATUS "[LLVM_PATCHER\\Prebuilt] : Found prebuilt of llvm in version ${PACKAGE_VERSION}")
endif()