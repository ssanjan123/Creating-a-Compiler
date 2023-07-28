package semanticAnalyzer.signatures;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import semanticAnalyzer.types.Type;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static semanticAnalyzer.types.PrimitiveType.*;

public enum Promotion {
    CHAR_TO_INT(CHARACTER, INTEGER, Nop),
    CHAR_TO_FLOAT(CHARACTER, FLOAT, ConvertF),
    INT_TO_FLOAT(INTEGER, FLOAT, ConvertF),
    NONE(NO_TYPE, NO_TYPE, Nop){
        boolean appliesTo(Type type){
            return true;
        }
        Type apply(Type type){
            return type;
        }
        boolean isNull(){
            return true;
        }
    };

    Type fromType;
    Type toType;
    ASMOpcode opcode;

    Promotion(Type fromType, Type toType, ASMOpcode opcode) {
        this.fromType = fromType;
        this.toType = toType;
        this.opcode = opcode;
    }

    boolean appliesTo(Type type){
        return fromType == type;
    }

    Type apply(Type type){
        assert (appliesTo(type));
        return toType;
    }

    public ASMCodeFragment codeFor(){
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);
        result.add(opcode);
        return result;
    }

    boolean isNull(){
        return false;
    }
}
