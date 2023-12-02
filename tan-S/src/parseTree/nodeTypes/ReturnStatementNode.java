package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ReturnStatementNode extends ParseNode {
    private String functionReturnLabel;
    public ReturnStatementNode(Token token) {
        super(token);
    }

    public ReturnStatementNode(ParseNode node) {
        super(node);
    }
    public String getFunctionReturnLabel() {
        return functionReturnLabel;
    }
    public void setFunctionReturnLabel(String val) {
        functionReturnLabel = val;
    }
    // children order: returnExpression
    public static ReturnStatementNode withChildren(ParseNode returnExpression) {
        ReturnStatementNode node = new ReturnStatementNode(returnExpression.getToken());
        node.appendChild(returnExpression);
        return node;
    }

    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}