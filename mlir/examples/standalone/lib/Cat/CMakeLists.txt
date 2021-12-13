add_mlir_dialect_library(MLIRCat
    CatDialect.cpp

    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/include/Cat

    DEPENDS
    MLIRCatIncGen

    LINK_LIBS PUBLIC
    MLIRIR
    )