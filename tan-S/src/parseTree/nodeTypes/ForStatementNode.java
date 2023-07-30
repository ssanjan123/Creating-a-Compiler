package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ForStatementNode extends ParseNode{
    private ParseNode identifierNode;
    //private ParseNode otherIdentifierNode;



    public ForStatementNode(Token token, ParseNode identifierNode) {
        super(token);
        //this.typeToken = typeToken;
        this.identifierNode = identifierNode;
        //this.otherIdentifierNode = new IdentifierNode(token);
    }

    public ForStatementNode(ParseNode node) {
        super(node);
    }

    public ParseNode getIdentifierNode() {
        return identifierNode;
    }

//    public ParseNode getOtherIdentifierNode() {
//        return otherIdentifierNode;
//    }


    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
