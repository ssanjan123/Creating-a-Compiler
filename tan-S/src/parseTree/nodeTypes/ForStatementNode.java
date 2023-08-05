package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import symbolTable.Binding;
import tokens.Token;

public class ForStatementNode extends ParseNode{

    private ParseNode identifierNode;
    private Binding binding;

    //private ParseNode otherIdentifierNode;
    private String incrementLabel;
    private String endLabel;

    public String getIncrementLabel() {
        return incrementLabel;
    }
    public void setIncrementLabel(String incrementLabel) {
        this.incrementLabel = incrementLabel;
    }

    public String getEndLabel() {
        return endLabel;
    }
    public void setEndLabel(String endLabel) {
        this.endLabel = endLabel;
    }



    public ForStatementNode(Token token, ParseNode identifierNode) {
        super(token);
        //this.typeToken = typeToken;
        this.identifierNode = identifierNode;
        //this.otherIdentifierNode = new IdentifierNode(token);
    }

    public ForStatementNode(Token token) {
        super(token);
    }

    public ForStatementNode(ParseNode node) {
        super(node);
    }

    public ParseNode getIdentifierNode() {
        return identifierNode;
    }
    public ParseNode setIdentifierNode(ParseNode identifierNode) {
        return this.identifierNode = identifierNode;
    }

    public Binding getBinding() {
        return binding;
    }
    public Binding setBinding(Binding binding) {
        return this.binding = binding;
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
