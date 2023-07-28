package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class BracketNode extends ParseNode {
    //private Token typeToken;
    private ParseNode expressionNode;


    public BracketNode(Token token, ParseNode expressionNode) {
        super(token);
        //this.typeToken = typeToken;
        this.expressionNode = expressionNode;
    }

    public BracketNode(ParseNode node) {
        super(node);
    }

    public ParseNode getExpressionNode() {
        return this.expressionNode;
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
