package parseTree.nodeTypes;

import asmCodeGenerator.Labeller;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class WhileStatementNode extends ParseNode {
    private String loopLabel;
    private String endLabel;

    public String getLoopLabel() {
        return loopLabel;
    }
    public void setLoopLabel(String loopLabel) {
        this.loopLabel = loopLabel;
    }

    public String getEndLabel() {
        return endLabel;
    }
    public void setEndLabel(String endLabel) {
        this.endLabel = endLabel;
    }

    public WhileStatementNode(Token token) {
        super(token);
    }

    public WhileStatementNode(ParseNode node) {
        super(node);
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }

}
