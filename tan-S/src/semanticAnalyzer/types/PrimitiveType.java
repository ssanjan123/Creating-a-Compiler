package semanticAnalyzer.types;


public enum PrimitiveType implements Type {
	BOOLEAN(1),
	CHARACTER(1),
	INTEGER(4),
	FLOAT(8),
	ERROR(0),			// use as a value when a syntax error has occurred
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
	public int getSize() {
		return sizeInBytes;
	}
	public String infoString() {
		return infoString;
	}
	public static PrimitiveType fromString(String typeString) {
		if (typeString.equals("int")) {
			return INTEGER;
		}
		if (typeString.equals("char")) {
			return CHARACTER;
		}
		for (PrimitiveType type : PrimitiveType.values()) {
			if (type.name().toLowerCase().equals(typeString)) {
				return type;
			}
		}
		throw new IllegalArgumentException("Unknown type: " + typeString);
	}



}
