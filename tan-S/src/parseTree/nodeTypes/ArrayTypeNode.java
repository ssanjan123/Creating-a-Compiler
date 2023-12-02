package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.ArrayType;
import tokens.Token;

public class ArrayTypeNode extends ParseNode {
    public ArrayTypeNode(Token token) {
        super(token);
    }

    public ArrayTypeNode(ParseNode node) {
        super(node);
    }

    public ParseNode getSubTypeNode() {
        return this.child(0);
    }
    public static ArrayTypeNode withChildren(Token token, ParseNode subType) {
        ArrayTypeNode node = new ArrayTypeNode(token);
        node.appendChild(subType);
        return node;
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
