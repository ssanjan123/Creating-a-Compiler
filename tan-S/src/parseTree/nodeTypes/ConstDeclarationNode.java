package parseTree.nodeTypes;

import lexicalAnalyzer.Keyword;
import parseTree.ParseNode;
import parseTree.nodeTypes.DeclarationNode;
import tokens.Token;

public class ConstDeclarationNode extends DeclarationNode {

    public ConstDeclarationNode(Token token) {
        super(token);
        assert(token.isLextant(Keyword.CONST));
    }

    public static ConstDeclarationNode withChildren(Token token, ParseNode declaredName, ParseNode initializer) {
        ConstDeclarationNode node = new ConstDeclarationNode(token);
        node.appendChild(declaredName);
        node.appendChild(initializer);
        return node;
    }
}
