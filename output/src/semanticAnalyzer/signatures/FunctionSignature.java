package semanticAnalyzer.signatures;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import semanticAnalyzer.types.TypeVariable;

//immutable
public class FunctionSignature {
	private static final boolean ALL_TYPES_ACCEPT_ERROR_TYPES = true;
	private Type resultType;
	private Type[] paramTypes;
	Object whichVariant;


	Set<TypeVariable> typeVariables;

	///////////////////////////////////////////////////////////////
	// construction
	
	public FunctionSignature(Object whichVariant, Type ...types) {
		assert(types.length >= 1);
		storeParamTypes(types);
		resultType = types[types.length-1];
		this.whichVariant = whichVariant;

		findTypeVariables();
	}
	private void storeParamTypes(Type[] types) {
		paramTypes = new Type[types.length-1];
		for(int i=0; i<types.length-1; i++) {
			paramTypes[i] = types[i];
		}
	}

	private void findTypeVariables(){// should be called once
		typeVariables = new HashSet<TypeVariable>();
		for (Type type : paramTypes){
			type.addTypeVariables(typeVariables);
		}
		resultType.addTypeVariables(typeVariables);
	}

	public List<Type> typeVariableSettings(){//or stored locally

		List<Type> results = new ArrayList<Type>();
		for (TypeVariable typeVariable : typeVariables){
			results.add(typeVariable.concreteType());
		}
		return results;
	}

	public void setTypeVariables(List<Type> settings){//passed in here
		int i = 0;
		for(TypeVariable typevariable : typeVariables){
			typevariable.setContraint(settings.get(i));
			i = i + 1;
		}
	}
	
	///////////////////////////////////////////////////////////////
	// accessors
	
	public Object getVariant() {
		return whichVariant;
	}
	public Type resultType() {
		return resultType;
	}
	public boolean isNull() {
		return false;
	}
	
	
	///////////////////////////////////////////////////////////////
	// main query

	public boolean accepts(List<Type> types) {
		if(types.size() != paramTypes.length) {
			return false;
			//resetTypeVariables();
		}
		
		for(int i=0; i<paramTypes.length; i++) {
			if(!assignableTo(paramTypes[i], types.get(i))) {
				return false;
			}
		}		
		return true;
	}
	private boolean assignableTo(Type variableType, Type valueType) {
		if(valueType == PrimitiveType.ERROR && ALL_TYPES_ACCEPT_ERROR_TYPES) {
			return true;
		}	
		return variableType.equals(valueType);
	}
	
	// Null object pattern
	private static FunctionSignature neverMatchedSignature = new FunctionSignature(1, PrimitiveType.ERROR) {
		public boolean accepts(List<Type> types) {
			return false;
		}
		public boolean isNull() {
			return true;
		}
	};
	public static FunctionSignature nullInstance() {
		return neverMatchedSignature;
	}
	
	///////////////////////////////////////////////////////////////////
	// Signatures for tan-0 operators
	// this section will probably disappear in tan-1 (in favor of FunctionSignatures)
	
	private static FunctionSignature addSignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER);
	private static FunctionSignature subtractSignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER);
	private static FunctionSignature multiplySignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER);
	private static FunctionSignature greaterSignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.BOOLEAN);

	
	// the switch here is ugly compared to polymorphism.  This should perhaps be a method on Lextant.
	// the switch here is ugly compared to polymorphism.  This should perhaps be a method on Lextant.
	public static FunctionSignature signatureOf(Lextant lextant, List<Type> types) {
		assert(lextant instanceof Punctuator);
		Punctuator punctuator = (Punctuator)lextant;

		// We now use the new signaturesOf function to fetch the right FunctionSignatures based on the punctuator.
		FunctionSignatures possibleSignatures = FunctionSignatures.signaturesOf(punctuator);

		// From the fetched signatures, we choose the one that matches the provided types
		return possibleSignatures.acceptingSignature(types);
	}




}