add_mlir_dialect_library(MLIRDog
    DogDialect.cpp
    DogOps.cpp

    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/include/Dog

    DEPENDS
    MLIRDogOpsIncGen

    LINK_LIBS PUBLIC
    MLIRIR
    )