#ifndef CAT_DIALECT_H
#define CAT_DIALECT_H

#include "mlir/IR/Dialect.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "Cat/CatDialect.h.inc"

#define GET_OP_CLASSES
#include "Cat/Cat.h.inc"

#endif