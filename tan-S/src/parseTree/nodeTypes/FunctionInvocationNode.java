package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class FunctionInvocationNode extends ParseNode {
    public FunctionInvocationNode(Token token) {
        super(token);
    }

    public FunctionInvocationNode(ParseNode node) {
        super(node);
    }

    // children order: functionName, argumentList

    public static FunctionInvocationNode withChildren(ParseNode functionName, ParseNode... children) {
        FunctionInvocationNode node = new FunctionInvocationNode(functionName.getToken());
        node.appendChild(functionName);
        for(ParseNode child: children) {
            //System.out.print(child);
            node.appendChild(child);
        }
        return node;
    }

    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}