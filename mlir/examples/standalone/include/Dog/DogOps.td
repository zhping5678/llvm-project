// DogDialect.td —— define dialect and template of ops and ops
#ifndef DOG_OPS
#define DOG_OPS

include "Dog/DogDialect.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"


def DogFooOp : Dog_Op<"dog_foo", [NoSideEffect, SameOperandsAndResultType]> {
    let summary = "Dog foo Operation";
    let description = "use dog.dog_foo to define a new operation in a dialect";
    let arguments = (ins I32:$input);
    int results = (outs I32:$res);

    let assemblyFormat = [{
        $input attr-dict `:` type($input)
    }];
}

#endif

