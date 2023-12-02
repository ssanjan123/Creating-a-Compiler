package asmCodeGenerator.operators;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import parseTree.ParseNode;

import java.util.List;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;

public class integerEqualCodeGenerator implements  SimpleCodeGenerator{
    @Override
    public ASMCodeFragment generate(ParseNode node, List<ASMCodeFragment> args) {
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);
        for (ASMCodeFragment arg: args){
            result.append(arg);
        }
        result.add(ASMOpcode.PStack);

        Labeller labeller = new Labeller("compare");

        String trueLabel  = labeller.newLabel("true");
        String falseLabel = labeller.newLabel("false");
        String greater = labeller.newLabel("greater");
        String joinLabel = labeller.newLabel("join");


        result.add(ASMOpcode.Subtract);
        result.add(ASMOpcode.JumpFalse, trueLabel);//jumps when a-b = 0

        //not equal
        result.add(Label, falseLabel);
        result.add(ASMOpcode.PushI, 0);//false
        result.add(ASMOpcode.Jump, joinLabel);


        //equal
        result.add(Label, trueLabel);
        result.add(ASMOpcode.PushI, 1);//true
        //because
        result.add(ASMOpcode.Label, joinLabel);

        result.add(ASMOpcode.PStack);

        return result;





    }





}



