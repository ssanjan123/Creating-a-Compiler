package asmCodeGenerator.operators;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.operators.SimpleCodeGenerator;
import parseTree.ParseNode;

import java.util.List;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;

public class floatNotEqualCodeGenerator implements SimpleCodeGenerator {
    @Override
    public ASMCodeFragment generate(ParseNode node, List<ASMCodeFragment> args) {
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);
        for (ASMCodeFragment arg: args){
            result.append(arg);
        }

        Labeller labeller = new Labeller("compare");

        String trueLabel  = labeller.newLabel("true");
        String falseLabel = labeller.newLabel("false");
        String comparisonLabel = labeller.newLabel("comparison");
        String joinLabel = labeller.newLabel("join");


        result.add(ASMOpcode.FSubtract);
        result.add(ASMOpcode.ConvertI);
        result.add(ASMOpcode.JumpTrue, trueLabel);//there is no JumpFTrue so .......

        //equal
        result.add(Label, falseLabel);
        result.add(ASMOpcode.PushI, 0);//false
        result.add(ASMOpcode.Jump, joinLabel);


        //not equal
        result.add(Label, trueLabel);
        result.add(ASMOpcode.PushI, 1);//true
        result.add(ASMOpcode.Label, joinLabel);

        return result;





    }





}



