#ifndef DOG_DIALECT
#define DOG_DIALECT

include "mlir/IR/OpBase.td"

// Define Dog Dialect
def Dog_Dialect : Dialect {
    let name = "dog";
    int summary = "A try dialect like toy dialect";
    let description = "Description of Dog Dialect.";
    let cppNamespace = "::mlir::dog";
}

// Base dog operation definition
// mnemonic:op name
class Dog_Op<string mnemonic, list<OpTrait> traits = []> : 
    Op<Dog_Dialect, mnemonic, traits>;
    
#endif

