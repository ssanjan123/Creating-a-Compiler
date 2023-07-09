package semanticAnalyzer.signatures;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import asmCodeGenerator.operators.*;

import asmCodeGenerator.codeStorage.ASMOpcode;
import lexicalAnalyzer.Punctuator;
import semanticAnalyzer.types.Type;

import lexicalAnalyzer.Punctuator;

import asmCodeGenerator.operators.*;

import asmCodeGenerator.codeStorage.ASMOpcode;
import semanticAnalyzer.types.Type;

import static lexicalAnalyzer.Punctuator.AND;
import static lexicalAnalyzer.Punctuator.OR;
import static semanticAnalyzer.types.PrimitiveType.*;



public class FunctionSignatures extends ArrayList<FunctionSignature> {
	private static final long serialVersionUID = -4907792488209670697L;
	private static Map<Object, FunctionSignatures> signaturesForKey = new HashMap<Object, FunctionSignatures>();
	
	Object key;
	
	public FunctionSignatures(Object key, FunctionSignature ...functionSignatures) {
		this.key = key;
		for(FunctionSignature functionSignature: functionSignatures) {
			add(functionSignature);
		}
		signaturesForKey.put(key, this);
	}
	
	public Object getKey() {
		return key;
	}
	public boolean hasKey(Object key) {
		return this.key.equals(key);
	}
	
	public FunctionSignature acceptingSignature(List<Type> types) {
		for(FunctionSignature functionSignature: this) {
			if(functionSignature.accepts(types)) {
				return functionSignature;
			}
		}
		return FunctionSignature.nullInstance();
	}
	public boolean accepts(List<Type> types) {
		return !acceptingSignature(types).isNull();
	}

	
	/////////////////////////////////////////////////////////////////////////////////
	// access to FunctionSignatures by key object.
	
	public static FunctionSignatures nullSignatures = new FunctionSignatures(0, FunctionSignature.nullInstance());

	public static FunctionSignatures signaturesOf(Object key) {
		if(signaturesForKey.containsKey(key)) {
			return signaturesForKey.get(key);
		}
		return nullSignatures;
	}
	public static FunctionSignature signature(Object key, List<Type> types) {
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(key);
		return signatures.acceptingSignature(types);
	}


//	private boolean assignableTo(Type formalType, Type actualType) {
//		if(actualType == PrimitiveType.ERROR && P) {
//			return true;
//		}
//		return formalType.equivalent(actualType);
//	}

	/////////////////////////////////////////////////////////////////////////////////
	// Put the signatures for operators in the following static block.


	static {

//		typeVariable T = new typeVariable("T");
//		new FunctionSignatures(Punctuator.INDEXING,
//				new FunctionSignature(new Array(T), INTEGER, T));


		new FunctionSignatures(Punctuator.ADD,
				new FunctionSignature(ASMOpcode.Add, INTEGER, INTEGER, INTEGER),//integer
				new FunctionSignature(ASMOpcode.Nop, INTEGER, INTEGER),
				new FunctionSignature(ASMOpcode.FAdd, FLOAT, FLOAT, FLOAT),//float
				new FunctionSignature(ASMOpcode.Nop, FLOAT, FLOAT)
		);

		new FunctionSignatures(Punctuator.SUBTRACT,
				new FunctionSignature(ASMOpcode.Subtract, INTEGER, INTEGER, INTEGER),//integer
				new FunctionSignature(ASMOpcode.Negate, INTEGER, INTEGER),
				new FunctionSignature(ASMOpcode.FSubtract, FLOAT, FLOAT, FLOAT),//float
				new FunctionSignature(ASMOpcode.FNegate, FLOAT, FLOAT)
		);

		new FunctionSignatures(Punctuator.MULTIPLY,
				new FunctionSignature(ASMOpcode.Multiply, INTEGER, INTEGER, INTEGER),//integer
				new FunctionSignature(ASMOpcode.FMultiply, FLOAT, FLOAT, FLOAT)//float
		);

		new FunctionSignatures(Punctuator.DIVIDE,
		    new FunctionSignature(new integerDivideCodeGenerator(), INTEGER, INTEGER, INTEGER),
			new FunctionSignature(new floatDivideCodeGenerator(), FLOAT, FLOAT, FLOAT)
		);



		//comparison operators
		new FunctionSignatures(Punctuator.GREATER,
				new FunctionSignature(new integerGreaterThanCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatGreaterThanCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);
		new FunctionSignatures(Punctuator.GREATERTHANOREQUAL,
				new FunctionSignature(new integerGreaterThanOrEqualCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatGreaterThanOrEqualCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);
		new FunctionSignatures(Punctuator.LESSER,
				new FunctionSignature(new integerLessThanCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatLessThanCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);
		new FunctionSignatures(Punctuator.LESSERTHANOREQUAL,
				new FunctionSignature(new integerLessThanOrEqualCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatLessThanOrEqualCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);
		new FunctionSignatures(Punctuator.EQUAL,
				new FunctionSignature(new integerEqualCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatEqualCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);
		new FunctionSignatures(Punctuator.NOTEQUAL,
				new FunctionSignature(new integerNotEqualCodeGenerator(), INTEGER, INTEGER, INTEGER),
				new FunctionSignature(new floatNotEqualCodeGenerator(), FLOAT, FLOAT, INTEGER)
		);

		new FunctionSignatures(AND,
				//new FunctionSignature(ASMOpcode.And, BOOLEAN, BOOLEAN, BOOLEAN)
				new FunctionSignature(new booleanAndCodeGenerator(), BOOLEAN, BOOLEAN, BOOLEAN)
		);

		new FunctionSignatures(OR,
				//new FunctionSignature(ASMOpcode.Or, BOOLEAN, BOOLEAN, BOOLEAN)
				new FunctionSignature(new booleanOrCodeGenerator(), BOOLEAN, BOOLEAN, BOOLEAN)
		);

		new FunctionSignatures(Punctuator.NOT,
				new FunctionSignature(ASMOpcode.BNegate, BOOLEAN, BOOLEAN)
		);

		// First, we use the operator itself (in this case the Punctuator ADD) as the key.
		// Then, we give that key two signatures: one an (INT x INT -> INT) and the other
		// a (FLOAT x FLOAT -> FLOAT).  Each signature has a "whichVariant" parameter where
		// I'm placing the instruction (ASMOpcode) that needs to be executed.
		//
		// I'll follow the convention that if a signature has an ASMOpcode for its whichVariant,
		// then to generate code for the operation, one only needs to generate the code for
		// the operands (in order) and then add to that the Opcode.  For instance, the code for
		// floating addition should look like:
		//
		//		(generate argument 1)	: may be many instructions
		//		(generate argument 2)   : ditto
		//		FAdd					: just one instruction
		//
		// If the code that an operator should generate is more complicated than this, then
		// I will not use an ASMOpcode for the whichVariant.  In these cases I typically use
		// a small object with one method (the "Command" design pattern) that generates the
		// required code.

	}


}
