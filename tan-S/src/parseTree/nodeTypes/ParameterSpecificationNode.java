package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.Type;
import tokens.Token;

public class ParameterSpecificationNode extends ParseNode {
    public ParameterSpecificationNode(Token token) {
        super(token);
    }

    public ParameterSpecificationNode(ParseNode node) {
        super(node);
    }

    // children order: type, identifier
    public static ParameterSpecificationNode withChildren(ParseNode type, ParseNode identifier) {
        ParameterSpecificationNode node = new ParameterSpecificationNode(type.getToken());
        node.appendChild(type);
        node.appendChild(identifier);
        return node;
    }


    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }


    // other methods...
}
