set(LLVM_LINK_COMPONENTS Support)

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(translation_libs GLOBAL PROPERTY MLIR_TRANSLATION_LIBS)

mlir_check_link_libraries(standalone-toyc)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR}/include/)
include_directories(include)
add_subdirectory(include)

add_llvm_executable(standalone-toyc 
  toyc.cpp
  parser/AST.cpp
  Dialect/MLIRGen.cpp
  Dialect/ToyDialect.cpp)

llvm_update_compile_flags(standalone-toyc)
target_link_libraries(standalone-toyc
  PRIVATE
  ${dialect_libs}
  ${translation_libs}
  MLIRIR
  MLIRParser
  MLIRPass
  MLIRSPIRV
  MLIRTranslation
  MLIRSupport
  )

# add_public_tablegen_target(StandaloneToyIncGen)
add_custom_target(StandaloneToy)
