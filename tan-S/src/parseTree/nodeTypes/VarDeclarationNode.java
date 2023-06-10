package parseTree.nodeTypes;

import lexicalAnalyzer.Keyword;
import parseTree.ParseNode;
import parseTree.nodeTypes.DeclarationNode;
import tokens.Token;

public class VarDeclarationNode extends DeclarationNode {

    public VarDeclarationNode(Token token) {
        super(token);
        assert(token.isLextant(Keyword.VAR));
    }

    public static VarDeclarationNode withChildren(Token token, ParseNode declaredName, ParseNode initializer) {
        VarDeclarationNode node = new VarDeclarationNode(token);
        node.appendChild(declaredName);
        node.appendChild(initializer);
        return node;
    }
}
