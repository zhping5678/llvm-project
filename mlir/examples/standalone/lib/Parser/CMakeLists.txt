set(LLVM_LINK_COMPONENTS Support)

include_directories(${PROJECT_SOURCE_DIR}/include/Parser)

add_library(AST AST.cpp MLIRGen.cpp)
