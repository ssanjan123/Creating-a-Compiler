package semanticAnalyzer.types;

import java.util.Set;

public class ArrayType implements Type {
    private Type subtype;
    private int sizeInBytes;

    public ArrayType(Type subtype) {
        this.subtype = subtype;
        this.sizeInBytes = subtype.getSize() + 4; // assuming 4 bytes for array length
    }

    public Type getSubtype() {
        return subtype;
    }

    public int getSize() {
        return sizeInBytes;
    }

    @Override
    public String infoString() {
        return "array of " + subtype.infoString();
    }

    @Override
    public boolean equivalent(Type otherType) {
        return subtype == otherType;
    }

    @Override
    public void addTypeVariables(Set<TypeVariable> TypeVariables) {

    }

    @Override
    public Type concreteType() {
        return subtype;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        ArrayType arrayType = (ArrayType) obj;
        return subtype.equals(arrayType.getSubtype());
    }

    @Override
    public int hashCode() {
        return subtype.hashCode();
    }

    @Override
    public String toString() {
        return "ArrayType{" +
                "subtype=" + subtype +
                ", sizeInBytes=" + sizeInBytes +
                '}';
    }
}
