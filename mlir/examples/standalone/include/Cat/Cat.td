//DEfine Cat dialect and ops

// #ifndef CAT_OPS
#define CAT_OPS

include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def Cat_Dialect : Dialect {
    let name = "cat";
    let cppNamespace = "::mlir::cat";
}

class Cat_Op<string mnemonicm, list<OpTrait> traits = []> : 
    Op<Cat_Dialect, mnemonicm, traits>;


def ConstantOp : Cat_Op<"constant", [NoSideEffect]> {
    let summary = "constant";
    let description = [{
        Constant operation turns a literal into an SSA value.
    }];
    let arguments = (ins F64ElementsAttr:$value);
    let results = (outs F64Tensor);

}

// #endif