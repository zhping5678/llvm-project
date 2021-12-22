//DEfine Cat dialect and ops
#ifndef CAT_OPS
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

    let parser = [{return ::parseConstantOp(parser, result);}];
    let printer = [{return ::print(p, *this);}];

    let builders = [
        OpBuilder<(ins "DenseElementsAttr":$value), [{
            build($_builder, $_state, value.getType(), value);
        }]>,
        OpBuilder<(ins "double":$value)>
    ];

    let verifier = [{ return ::verify(*this);}];
}


def AddOp : Cat_Op<"add"> {
    let summary = "element-wise addition operation in Cat Dialect";
    let description = [{Element-wise addition operation}];
    let arguments = (ins F64Tensor:$lhs, F64Tensor:$rhs);
    let results = (outs F64Tensor);

    let parser = [{ return ::parseBinaryOp(parser, result); }];
    let printer = [{return ::printBinaryOp(p, *this); }];

    let builders = [OpBuilder<(ins "Value":$lhs, "Value":$rhs)>];
}

def GenericCallOp : Cat_Op<"call"> {
    let summary = "call operation";
    let description = [{generic call operation}];

    let arguments = (ins FlatSymbolRefAttr:$callee, Variadic<F64Tensor>:$inputs);
    let results = (outs F64Tensor);

    let assemblyFormat = [{
        $callee `(` $inputs `)` attr-dict `:` functional-type($inputs, results)
    }];

    let builders = [OpBuilder<(ins "StringRef":$callee, "ArrayRef<Value>":$arguments)>];
}

def MulOp : Cat_Op<"mul"> {
    let summary = "Element-wise multiplication op";
    let description = [{Multiplication Operation.}];

    let arguments = (ins F64Tensor:$lhs, F64Tensor:$rhs);
    let results = (outs F64Tensor);

    let parser = [{ return ::parseBinaryOp(parser, result); }];
    let printer = [{ return ::printBinaryOp(p, *this); }];

    let builders = [OpBuilder<(ins "Value":$lhs, "Value":$rhs)>];
}

def PrintOp : Cat_Op<"print"> {
    let summary = "print op";
    let description = [{print a given input tensor.}];

    let arguments = (ins F64Tensor:$input);

    let assemblyFormat = "$input attr-dict `:` type($input)";
}

def ReshapeOp : Cat_Op<"reshape"> {
  let summary = "tensor reshape operation";
  let description = [{Reshape operation}];

  let arguments = (ins F64Tensor:$input);

  let results = (outs StaticShapeTensorOf<[F64]>);

  let assemblyFormat = [{
    `(` $input `:` type($input) `)` attr-dict `to` type(results)
  }];
}

def ReturnOp : Cat_Op<"return", [NoSideEffect, HasParent<"FuncOp">,
                                 Terminator]> {
  let summary = "return operation";
  let description = [{return operation within a function.}];

  let arguments = (ins Variadic<F64Tensor>:$input);

  let assemblyFormat = "($input^ `:` type($input))? attr-dict ";

  // Allow building a ReturnOp with no return operand.
  let builders = [
    OpBuilder<(ins), [{ build($_builder, $_state, llvm::None); }]>
  ];

  // Provide extra utility definitions on the c++ operation class definition.
  let extraClassDeclaration = [{
    bool hasOperand() { return getNumOperands() != 0; }
  }];

  let verifier = [{ return ::verify(*this); }];
}

def TransposeOp : Cat_Op<"transpose"> {
  let summary = "transpose operation";

  let arguments = (ins F64Tensor:$input);
  let results = (outs F64Tensor);

  let assemblyFormat = [{
    `(` $input `:` type($input) `)` attr-dict `to` type(results)
  }];

  let builders = [
    OpBuilder<(ins "Value":$input)>
  ];

  // Invoke a static verify method to verify this transpose operation.
  let verifier = [{ return ::verify(*this); }];
}

#endif

