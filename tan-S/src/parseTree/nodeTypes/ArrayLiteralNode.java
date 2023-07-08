package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;
import java.util.List;

public class ArrayLiteralNode extends ParseNode {
    public ArrayLiteralNode(Token token) {
        super(token);
    }

    public ArrayLiteralNode(ParseNode node) {
        super(node);
    }

    // This method will take in a list of expressions that represent the elements of the array.
    public static ArrayLiteralNode withChildren(Token token, List<ParseNode> elements) {
        ArrayLiteralNode node = new ArrayLiteralNode(token);
        for(ParseNode element : elements) {
            node.appendChild(element);
        }
        return node;
    }

    // A helper method to get the length of the array.
    public int length() {
        return this.getChildren().size();
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }


}
