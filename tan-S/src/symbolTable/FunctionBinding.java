package symbolTable;

import inputHandler.TextLocation;
import semanticAnalyzer.types.Type;

import java.util.List;

public class FunctionBinding extends Binding {
    private List<Type> parameterTypes;
    private Type returnType;

    public FunctionBinding(Type returnType, List<Type> parameterTypes, TextLocation location, MemoryLocation memoryLocation, String lexeme, boolean isMutable) {
        super(returnType, location, memoryLocation, lexeme, isMutable);
        this.parameterTypes = parameterTypes;
        this.returnType = returnType;
    }

    public List<Type> getParameterTypes() {
        return parameterTypes;
    }

    public Type getReturnType() {
        return returnType;
    }
}
