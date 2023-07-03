package semanticAnalyzer.types;

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
