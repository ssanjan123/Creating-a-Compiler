package semanticAnalyzer.types;


import tokens.Token;
import java.util.Set;

public enum PrimitiveType implements Type {
	BOOLEAN(1),
	CHARACTER(1),
	STRING(4),
	INTEGER(4),
	FLOAT(8),
	ERROR(0),			// use as a value when a syntax error has occurred
	VOID(0),
	NO_TYPE(0, "");		// use as a value when no type has been assigned.


    private int sizeInBytes;
	private String infoString;
	
	private PrimitiveType(int size) {
		this.sizeInBytes = size;
		this.infoString = toString();
	}
	private PrimitiveType(int size, String infoString) {
		this.sizeInBytes = size;
		this.infoString = infoString;
	}

	public static PrimitiveType getTypeForToken(Token token) {
		switch (token.getLexeme().toLowerCase()) {
			case "bool":
				return BOOLEAN;
			case "char":
				return CHARACTER;
			case "string":
				return STRING;
			case "int":
				return INTEGER;
			case "float":
				return FLOAT;
			default:
				throw new IllegalArgumentException("Unknown type: " + token.getLexeme());
		}
	}



	public int getSize() {
		return sizeInBytes;
	}
	public String infoString() {
		return infoString;
	}

	@Override
	public boolean equivalent(Type otherType) {
		return this == otherType;
	}

	public static PrimitiveType fromString(String typeString) {
		if (typeString.equals("int")) {
			return INTEGER;
		}
		if (typeString.equals("float")) {
			return FLOAT;
		}
		if (typeString.equals("char")) {
			return CHARACTER;
		}
		if (typeString.equals("bool")) {
			return BOOLEAN;
		}
		if (typeString.equals("string")) {
			return STRING;
		}
		for (PrimitiveType type : PrimitiveType.values()) {
			if (type.name().toLowerCase().equals(typeString)) {
				return type;
			}
		}
		throw new IllegalArgumentException("Unknown type: " + typeString);
	}


	public void addTypeVariables(Set<TypeVariable> TypeVariables){

	}

	@Override
	public Type concreteType() {
		return this;
	}


}
