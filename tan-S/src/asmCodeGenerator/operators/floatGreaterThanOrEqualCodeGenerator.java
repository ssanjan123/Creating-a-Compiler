package asmCodeGenerator.operators;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.operators.SimpleCodeGenerator;
import parseTree.ParseNode;

import java.util.List;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;

public class floatGreaterThanOrEqualCodeGenerator implements SimpleCodeGenerator {
    @Override
    public ASMCodeFragment generate(ParseNode node, List<ASMCodeFragment> args) {
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);
        for (ASMCodeFragment arg: args){
            result.append(arg);
        }

        Labeller labeller = new Labeller("compare");

        String trueLabel  = labeller.newLabel("true");
        String falseLabel = labeller.newLabel("false");
        String greater = labeller.newLabel("greater");
        String joinLabel = labeller.newLabel("join");


        result.add(ASMOpcode.FSubtract);
        result.add(ASMOpcode.JumpFNeg, trueLabel);//pops stack

        //if less than or equal
        result.add(Label, falseLabel);
        result.add(ASMOpcode.PushI, 1);//false
        result.add(ASMOpcode.Jump, joinLabel);


        //true that its negative
        result.add(Label, trueLabel);
        result.add(ASMOpcode.PushI, 0);//true
        result.add(ASMOpcode.Label, joinLabel);

        return result;





    }





}



