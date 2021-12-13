#include "Cat/Cat.h"

#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/OpImplementation.h"

using namespace mlir;
using namespace mlir::cat;

#include "Cat/CatDialect.cpp.inc"

void CatDialect::initialize() {
    addOperations<
#define GET_OP_LIST
#include "Cat/Cat.cpp.inc"
    >();
}


#define GET_OP_CLASSES
#include "Cat/Cat.cpp.inc"