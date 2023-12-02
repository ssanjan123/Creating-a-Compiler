package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ArrayLengthNode extends ParseNode {
    public ArrayLengthNode(Token token) {
        super(token);
    }

    public ArrayLengthNode(ParseNode node) {
        super(node);
    }

    // Access the array expression node
    public ParseNode getArrayExpressionNode() {
        return this.child(0);
    }

    // Create the ArrayLengthNode with the given array expression
    public static ArrayLengthNode withChildren(Token token, ParseNode arrayExpression) {
        ArrayLengthNode node = new ArrayLengthNode(token);
        node.appendChild(arrayExpression);
        return node;
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
