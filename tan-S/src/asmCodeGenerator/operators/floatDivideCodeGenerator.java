package asmCodeGenerator.operators;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.operators.SimpleCodeGenerator;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

import java.util.List;

public class floatDivideCodeGenerator implements SimpleCodeGenerator {
    @Override
    public ASMCodeFragment generate(ParseNode node, List<ASMCodeFragment> args) {
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);
        for (ASMCodeFragment arg: args){
            result.append(arg);
        }
        result.add(ASMOpcode.Duplicate);
        result.add(ASMOpcode.JumpFZero, RunTime.FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR);
        result.add(ASMOpcode.FDivide);
        return result;
    }

}