package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.PunctuationToken;
import tokens.Token;

public class PunctuationNode extends ParseNode {
    public char getChar() {
        return Char;
    }

    public void setLex(char Char) {
        this.Char = Char;
    }

    protected char Char;


    public PunctuationNode (Token token) {
        super(token);
        assert(token instanceof PunctuationToken);
    }




//    public void accept(ParseNodeVisitor visitor) {
//        visitor.visitEnter(this);
//        visitChildren(visitor);
//        visitor.visitLeave(this);
//    }
}
