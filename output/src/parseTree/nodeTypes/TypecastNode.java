package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import tokens.Token;

public class TypecastNode extends ParseNode {
    private Token typeToken;
    private ParseNode expressionNode;

    public TypecastNode(Token token, Token typeToken, ParseNode expressionNode) {
        super(token);
        this.typeToken = typeToken;
        this.expressionNode = expressionNode;


    }

    public Token getTypeToken() {
        return this.typeToken;
    }
    public PrimitiveType getType() {
        return PrimitiveType.fromString(this.typeToken.getLexeme());
    }

    public ParseNode getExpressionNode() {
        return this.expressionNode;
    }

    @Override
    public String toString() {
        return "Typecast: " + this.typeToken.getLexeme() + " (" + this.expressionNode.toString() + ")";
    }
    @Override
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }


}
