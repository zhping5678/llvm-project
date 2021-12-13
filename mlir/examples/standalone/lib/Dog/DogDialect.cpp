#include "Dog/DogDialect.h"
#include "Dog/DogOps.h"

using namespace mlir;
using namespace mlir::dog;

#include "Dog/DogOpsDialect.cpp.inc"

void DogDialect::initialize() {
    addOperations<
#define GET_OP_LIST
#include "Dog/DogOps.cpp.inc"
    >();
}