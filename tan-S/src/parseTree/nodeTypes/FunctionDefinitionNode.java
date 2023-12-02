package parseTree.nodeTypes;

import asmCodeGenerator.Labeller;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class FunctionDefinitionNode extends ParseNode {
    private String functionLocationLabel, returnCodeLabel, endLabel;
    public FunctionDefinitionNode(Token token) {
        super(token);
    }

    public FunctionDefinitionNode(ParseNode node) {
        super(node);
    }

    // children order: returnType, functionName, parameterList, functionBody
    public static FunctionDefinitionNode withChildren(ParseNode returnType, ParseNode parameterList, ParseNode functionBody) {
        FunctionDefinitionNode node = new FunctionDefinitionNode(returnType.getToken());
        node.appendChild(returnType);
        //node.appendChild(functionName);
        node.appendChild(parameterList);
        node.appendChild(functionBody);
        Labeller labeller = new Labeller("Function");
        node.functionLocationLabel = labeller.newLabel("function-location");
        node.returnCodeLabel = labeller.newLabel("return-code");
        node.endLabel = labeller.newLabel("end");
        return node;
    }


    public String getFunctionLocationLabel() {
        return functionLocationLabel;
    }
    public String getReturnCodeLabel() {
        return returnCodeLabel;
    }
    public String getEndLabel() {
        return endLabel;
    }
    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
