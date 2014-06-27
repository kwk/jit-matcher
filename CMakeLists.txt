cmake_minimum_required (VERSION 2.8)

project (jit-matcher)

# A convenience variable:
set(LLVM_ROOT "~/Development/llvm-install" CACHE PATH "Root of LLVM install.")

# A bit of a sanity check:
if( NOT EXISTS ${LLVM_ROOT}/include/llvm )
message(FATAL_ERROR "LLVM_ROOT (${LLVM_ROOT}) is not a valid LLVM install")
endif()

# We incorporate the CMake features provided by LLVM:
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${LLVM_ROOT}/share/llvm/cmake")
include(LLVMConfig)

# Now set the header and library paths:
include_directories( ${LLVM_INCLUDE_DIRS} ${LLVM_ROOT}/include )
link_directories( ${LLVM_LIBRARY_DIRS} )
add_definitions( ${LLVM_DEFINITIONS} )

# # Define add_llvm_* macro's.
include(AddLLVM)

set(LLVM_LINK_COMPONENTS
   Core
   ExecutionEngine
   JIT
   Support
   nativecodegen
   )

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_CURRENT_BINARY_DIR})
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_CURRENT_BINARY_DIR})

message(STATUS "CMAKE_MODULE_PATH           =   ${CMAKE_MODULE_PATH}")
message(STATUS "LLVM_DEFINITIONS            =   ${LLVM_DEFINITIONS}")
message(STATUS "LLVM_INCLUDE_DIRS           =   ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM_LIBRARY_DIRS           =   ${LLVM_LIBRARY_DIRS}")
message(STATUS "LLVM_LINK_COMPONENTS        =   ${LLVM_LINK_COMPONENTS}")
message(STATUS "LLVM_RUNTIME_OUTPUT_INTDIR  =   ${LLVM_RUNTIME_OUTPUT_INTDIR}")
message(STATUS "LLVM_LIBRARY_OUTPUT_INTDIR  =   ${LLVM_LIBRARY_OUTPUT_INTDIR}")

add_llvm_executable(jit-matcher
  jit-matcher.cpp
  )
  
add_dependencies(jit-matcher
  clang-headers
  )

target_link_libraries(jit-matcher
  clangBasic
  clangCodeGen
  clangDriver
  clangFrontend
  # manually added
  clangTooling
  clangFrontendTool
  clangFrontend
  clangDriver
  clangSerialization
  clangParse
  clangSema
  clangAnalysis
  clangEdit
  clangAST
  clangLex
  clangBasic
  clangASTMatchers
  # added due to missing symbols when linking
  LLVMLinker
  LLVMInstrumentation
  LLVMipo
  LLVMBitWriter
  LLVMObjCARCOpts
  LLVMLTO
  LLVMIRReader
  LLVMOption
  LLVMProfileData
  )

