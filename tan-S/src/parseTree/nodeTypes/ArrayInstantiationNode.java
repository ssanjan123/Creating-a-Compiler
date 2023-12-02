package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ArrayInstantiationNode extends ParseNode {
    public ArrayInstantiationNode(Token token) {
        super(token);
    }

    public ArrayInstantiationNode(ParseNode node) {
        super(node);
    }

    public ParseNode getArrayTypeNode() {
        return this.child(0);
    }
    public static ArrayInstantiationNode withChildren(Token token, ParseNode arrayType, ParseNode sizeExpression) {
        ArrayInstantiationNode node = new ArrayInstantiationNode(token);
        node.appendChild(arrayType);
        node.appendChild(sizeExpression);
        return node;
    }

    public ParseNode getSizeExpressionNode() {
        return this.child(1);
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
