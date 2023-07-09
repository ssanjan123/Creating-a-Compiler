package asmCodeGenerator.operators;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

import java.util.List;

import static asmCodeGenerator.codeStorage.ASMOpcode.Label;

public class booleanAndCodeGenerator implements SimpleCodeGenerator {
    @Override
    public ASMCodeFragment generate(ParseNode node, List<ASMCodeFragment> args) {
        ASMCodeFragment result = new ASMCodeFragment(ASMCodeFragment.CodeType.GENERATES_VALUE);

        Labeller labeller = new Labeller("compareAND");
        String trueLabel  = labeller.newLabel("trueAND");
        String falseLabel  = labeller.newLabel("falseAND");
        String endLabel = labeller.newLabel("endAND");

        result.append(args.get(0));//get first argument
        result.add(ASMOpcode.JumpFalse, falseLabel);
        result.append(args.get(1));
        result.add(ASMOpcode.JumpFalse, falseLabel);

        //if both true
        result.add(Label, trueLabel);
        result.add(ASMOpcode.PushI, 1);//true
        result.add(ASMOpcode.Jump, endLabel);

        //if either false
        result.add(Label, falseLabel);
        result.add(ASMOpcode.PushI, 0);//true

        //end
        result.add(ASMOpcode.Label, endLabel);

        return result;
    }
}
