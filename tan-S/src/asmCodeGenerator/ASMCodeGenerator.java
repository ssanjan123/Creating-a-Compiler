package asmCodeGenerator;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.operators.SimpleCodeGenerator;
import asmCodeGenerator.runtime.MemoryManager;
import asmCodeGenerator.runtime.RunTime;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import parseTree.*;
import parseTree.nodeTypes.*;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.types.ArrayType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.Binding;
import symbolTable.Scope;


import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;


// do not call the code generator if any errors have occurred during analysis.
public class ASMCodeGenerator {
	ParseNode root;

	public static ASMCodeFragment generate(ParseNode syntaxTree) {
		ASMCodeGenerator codeGenerator = new ASMCodeGenerator(syntaxTree);
		return codeGenerator.makeASM();
	}
	public ASMCodeGenerator(ParseNode root) {
		super();
		this.root = root;
	}
	
	public ASMCodeFragment makeASM() {
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		code.append( MemoryManager.codeForInitialization());
		code.append( RunTime.getEnvironment() );
		code.append( globalVariableBlockASM() );
		code.append( programASM() );
		code.append( MemoryManager.codeForAfterApplication() );
		
		return code;
	}
	private ASMCodeFragment globalVariableBlockASM() {
		assert root.hasScope();
		Scope scope = root.getScope();
		int globalBlockSize = scope.getAllocatedSize();
		
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		code.add(DLabel, RunTime.GLOBAL_MEMORY_BLOCK);
		code.add(DataZ, globalBlockSize);
		return code;
	}
	private ASMCodeFragment programASM() {
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		
		code.add(    Label, RunTime.MAIN_PROGRAM_LABEL);
		code.append( programCode());
		code.add(    Halt );
		
		return code;
	}
	private ASMCodeFragment programCode() {
		CodeVisitor visitor = new CodeVisitor();
		root.accept(visitor);
		return visitor.removeRootCode(root);
	}




	protected class CodeVisitor extends ParseNodeVisitor.Default {
		private Map<ParseNode, ASMCodeFragment> codeMap;
		ASMCodeFragment code;
		
		public CodeVisitor() {
			codeMap = new HashMap<ParseNode, ASMCodeFragment>();
		}


		////////////////////////////////////////////////////////////////////
        // Make the field "code" refer to a new fragment of different sorts.
		private void newAddressCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_ADDRESS);
			codeMap.put(node, code);
		}
		private void newValueCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_VALUE);
			codeMap.put(node, code);
		}
		private void newVoidCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_VOID);
			codeMap.put(node, code);
		}

	    ////////////////////////////////////////////////////////////////////
        // Get code from the map.
		private ASMCodeFragment getAndRemoveCode(ParseNode node) {
			ASMCodeFragment result = codeMap.get(node);
			codeMap.remove(node);
			return result;
		}
	    public  ASMCodeFragment removeRootCode(ParseNode tree) {
			return getAndRemoveCode(tree);
		}
		ASMCodeFragment removeValueCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			if (frag == null) {
				throw new RuntimeException("No ASM code fragment associated with node: " + node);
			}
			makeFragmentValueCode(frag, node);
			return frag;
		}
		private ASMCodeFragment removeAddressCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			assert frag.isAddress();
			return frag;
		}		
		ASMCodeFragment removeVoidCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			assert frag.isVoid();
			return frag;
		}
		
	    ////////////////////////////////////////////////////////////////////
        // convert code to value-generating code.
		private void makeFragmentValueCode(ASMCodeFragment code, ParseNode node) {
			assert !code.isVoid();
			
			if(code.isAddress()) {
				turnAddressIntoValue(code, node);
			}	
		}
		private void turnAddressIntoValue(ASMCodeFragment code, ParseNode node) {
			Type type = node.getType();
			if(node.getType() == PrimitiveType.INTEGER) {
				code.add(LoadI);
			}
			else if(node.getType() == PrimitiveType.BOOLEAN) {
				code.add(LoadC);
			}
			else if(node.getType() == PrimitiveType.FLOAT) {
				code.add(LoadF);
			}
			else if(node.getType() == PrimitiveType.CHARACTER) {
				code.add(LoadC);
			}
			else if(node.getType() == PrimitiveType.STRING) {
				code.add(LoadI);
			}
			else if (type instanceof ArrayType) {
				code.add(LoadI);  // Load the address of the array record
			}
			else {
				assert false : "node " + node;
			}
			code.markAsValue();
		}


		
	    ////////////////////////////////////////////////////////////////////
        // ensures all types of ParseNode in given AST have at least a visitLeave	
		public void visitLeave(ParseNode node) {
			assert false : "node " + node + " not handled in ASMCodeGenerator";
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////
		// constructs larger than statements
		public void visitLeave(ProgramNode node) {
			newVoidCode(node);
			for(ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
			}
		}
		public void visitLeave(MainBlockNode node) {
			newVoidCode(node);
			for(ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
			}
		}

		///////////////////////////////////////////////////////////////////////////
		// statements and declarations

		public void visitLeave(PrintStatementNode node) {
			newVoidCode(node);
			if (node.child(0).getType() instanceof ArrayType) {
				// Load the base address and length of the array to print
				ASMCodeFragment arrayAddress = removeValueCode(node.child(0));
				System.out.print(arrayAddress);
				code.append(arrayAddress);
				//code.add(LoadI);	// Loads the address of the array record in heap
				// Store ARRAY_BASE_ADDRESS and ARRAY_LENGTH
				code.add(Duplicate);  // Duplicate the address of the array record
				code.add(PushI, 16);  // Offset of the elements block address in the array record
				code.add(Add);
		/*		code.add(Duplicate);
				code.add(LoadI);
				code.add(PushD, RunTime.INTEGER_PRINT_FORMAT);
				code.add(Printf);*/
				code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
				code.add(Exchange);
				code.add(StoreI);

				code.add(PushI, 12);  // Offset of the array length in the array record
				code.add(Add);
				code.add(LoadI);
				code.add(PushD, RunTime.ARRAY_LENGTH);
				code.add(Exchange);
				code.add(StoreI);
			}
			// Print the array
			new PrintStatementGenerator(code, this).generate(node);
		}

		public void visit(NewlineNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.NEWLINE_PRINT_FORMAT);
			code.add(Printf);
		}
		public void visit(SpaceNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.SPACE_PRINT_FORMAT);
			code.add(Printf);
		}
		public void visit(TabNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.TAB_PRINT_FORMAT);
			code.add(Printf);
		}
		

		public void visitLeave(DeclarationNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));	
			ASMCodeFragment rvalue = removeValueCode(node.child(1));
			
			code.append(lvalue);
			code.append(rvalue);

			Type type = node.getType();
			code.add(opcodeForStore(type));
		}

		public void visitLeave(VarDeclarationNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));
			ASMCodeFragment rvalue = removeValueCode(node.child(1));

			code.append(lvalue);
			code.append(rvalue);

			Type type = node.getType();
			code.add(opcodeForStore(type));
			// Additional logic to handle array type
			if(type instanceof ArrayType) {
				// store array's base address in the variable's memory location
				code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
				code.add(LoadI);
				code.add(StoreI);
			}
		}

		public void visitLeave(AssignmentNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));
			ASMCodeFragment rvalue = removeValueCode(node.child(1));

			code.append(lvalue);
			code.append(rvalue);

			Type type = node.getType();
			code.add(opcodeForStore(type));
			// Additional logic to handle array type
			if(type instanceof ArrayType) {
				// store array's base address in the variable's memory location
				code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
				code.add(LoadI);
				code.add(StoreI);
			}
		}

		private ASMOpcode opcodeForStore(Type type) {
			if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER || type == PrimitiveType.STRING || type instanceof ArrayType) {
				return StoreI;
			}
			if (type == PrimitiveType.BOOLEAN) {
				return StoreC;
			}
			if (type == PrimitiveType.FLOAT) {
				return StoreF;
			}
			assert false: "Type " + type + " unimplemented in opcodeForStore()";
			return null;
		}





		///////////////////////////////////////////////////////////////////////////
		// expressions
		public void visitLeave(OperatorNode node) {
			Lextant operator = node.getOperator();
			FunctionSignature signature = node.getSignature();
			Object variant = signature.getVariant();


			if (variant instanceof ASMOpcode){
				Labeller labeller = new Labeller("Operator");
				String startLabel = labeller.newLabel("args");
				String opLabel = labeller.newLabel("op");

				newValueCode(node);
				code.add(Label, startLabel);
				for (ParseNode child: node.getChildren()){
					code.append(removeValueCode(child));
				}
				code.add((ASMOpcode) variant);
			}else if (variant instanceof SimpleCodeGenerator){
				SimpleCodeGenerator generator = (SimpleCodeGenerator) variant;
				ASMCodeFragment fragment = generator.generate(node, childValueCode(node));
				codeMap.put(node,fragment);

			}




		}

		private List<ASMCodeFragment> childValueCode(OperatorNode node){
			List <ASMCodeFragment> result = new ArrayList<>();
			for (ParseNode child : node.getChildren()){
				result.add(removeValueCode(child));
			}
			return result;
		}

		private void visitComparisonOperatorNode(OperatorNode node,
				Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			newValueCode(node);
			code.add(Label, startLabel);
			code.append(arg1);
			code.add(Label, arg2Label);
			code.append(arg2);
			code.add(Label, subLabel);
			code.add(Subtract);
			
			code.add(JumpPos, trueLabel);
			code.add(Jump, falseLabel);

			code.add(Label, trueLabel);
			code.add(PushI, 1);
			code.add(Jump, joinLabel);
			code.add(Label, falseLabel);
			code.add(PushI, 0);
			code.add(Jump, joinLabel);
			code.add(Label, joinLabel);

		}		
		private void visitUnaryOperatorNode(OperatorNode node) {
			newValueCode(node);
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			
			code.append(arg1);
			
			ASMOpcode opcode = opcodeForOperator(node.getOperator(),node.getType());
			code.add(opcode);							// type-dependent! (opcode is different for floats and for ints)
		}
		private void visitNormalBinaryOperatorNode(OperatorNode node) {
			newValueCode(node);
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			code.append(arg1);
			code.append(arg2);
			
			ASMOpcode opcode = opcodeForOperator(node.getOperator(), node.getType());
			code.add(opcode);							// type-dependent! (opcode is different for floats and for ints)
		}
		private ASMOpcode opcodeForOperator(Lextant lextant, Type type) {
			assert(lextant instanceof Punctuator);
			Punctuator punctuator = (Punctuator)lextant;
			switch(punctuator) {
				case ADD:
					if (type == PrimitiveType.FLOAT) return FAdd;
					else if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER) return Add;
					break;
				case SUBTRACT:
					if (type == PrimitiveType.FLOAT) return FNegate;
					else if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER) return Negate;
					break;
				case MULTIPLY:
					if (type == PrimitiveType.FLOAT) return FMultiply;
					else if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER) return Multiply;
					break;
				default:
					assert false : "unimplemented operator in opcodeForOperator";
			}
			return null;
		}

		////////////////////////////////////
		//Type cast
		public void visitLeave(TypecastNode node) {
			ASMCodeFragment valueFragment = removeValueCode(node.child(0)); // Extract the expression fragment

			newValueCode(node);

			code.append(valueFragment); // Add the expression code fragment

			Type castFromType = node.child(0).getType(); // Extract the type to be casted from
			Type castToType = node.getType(); // Extract the type to be casted to

			if(castFromType == PrimitiveType.INTEGER && castToType == PrimitiveType.FLOAT) {
				code.add(ConvertF); // Add the opcode to convert integer to float
			}
			else if(castFromType == PrimitiveType.FLOAT && castToType == PrimitiveType.INTEGER) {
				code.add(ConvertI); // Add the opcode to convert float to integer
			}
			else if(castFromType == PrimitiveType.INTEGER && castToType == PrimitiveType.CHARACTER) {
				code.add(PushI, 127); // Push mask value onto the stack
				code.add(BTAnd); // Perform bitwise and with mask value
			}
			else if(castFromType == PrimitiveType.CHARACTER && castToType == PrimitiveType.INTEGER) {
				// No operation needed. Characters are already represented as integers
			}
			else if((castFromType == PrimitiveType.INTEGER || castFromType == PrimitiveType.CHARACTER) && castToType == PrimitiveType.BOOLEAN) {
				String zeroLabel = new Labeller("zeroCheck").newLabel("");
				String doneLabel = new Labeller("done").newLabel("");

				code.add(Duplicate);
				code.add(JumpFalse, zeroLabel);
				code.add(PushI, 1);
				code.add(Jump, doneLabel);
				code.add(Label, zeroLabel);
				code.add(Pop);
				code.add(PushI, 0);
				code.add(Label, doneLabel);
			}
		}

		public void visitLeave(BracketNode node) {
			ASMCodeFragment valueFragment = removeValueCode(node.child(0)); // Extract the expression fragment
			newValueCode(node);
			code.append(valueFragment);
		}

		///////////////////////////////////////////////////////////////////////////
		// leaf nodes (ErrorNode not necessary)
		public void visit(BooleanConstantNode node) {
			newValueCode(node);
			code.add(PushI, node.getValue() ? 1 : 0);
		}
		public void visit(IdentifierNode node) {
			newAddressCode(node);
			Binding binding = node.getBinding();
			
			binding.generateAddress(code);
		}		
		public void visit(IntegerConstantNode node) {
			newValueCode(node);
			
			code.add(PushI, node.getValue());
		}
		public void visit(FloatConstantNode node) {
			newValueCode(node);
			code.add(PushF, node.getValue());
		}
		public void visit(CharacterConstantNode node) {
			newValueCode(node);
			code.add(PushI, node.getValue());
		}
		private int stringCounter = 0;

		public void visit(StringConstantNode node) {
			newValueCode(node);

			String strValue = node.getValue();
			int strLength = strValue.length();

			// First, generate the string record
			String strRecordLabel = "str_" + stringCounter++;  // Use the counter to generate a unique label
			code.add(DLabel, strRecordLabel);
			code.add(DataI, 3);  // Type ID for string records
			code.add(DataI, 9);  // Status bits for the string record
			code.add(DataI, strLength);  // Length of the string
			for (char c : strValue.toCharArray()) {
				code.add(DataC, (int) c);  // Add each character
			}
			code.add(DataC, 0);  // Null character at the end of the string

			// Push the address of the string record to the stack
			code.add(PushD, strRecordLabel);
		}

		public void visitLeave(BlockStatementNode node) {
			newVoidCode(node);
			for(ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
			}
		}


		private static int arrayCounter = 0;

		public void visitLeave(ArrayLiteralNode node) {
			newValueCode(node);

			int elementsCounter = 0;
			String arrayLabel = "$arr-" + arrayCounter++;
			List<ASMCodeFragment> elementsCode = new ArrayList<>();
			List<Integer> elementsValues = new ArrayList<>();  // list for storing elements' values

			for (ParseNode child : node.getChildren()) {
				// Get the actual value of the child node before it's translated to ASM code
				int value = getActualValue(child);  // use your method here
				elementsValues.add(value);

				ASMCodeFragment childCode = removeValueCode(child);
				elementsCode.add(childCode);
				elementsCounter++;
			}

			// The type of array elements (assuming all elements are of the same type)
			Type elementType = node.child(0).getType();
			int elementSize = elementType.getSize();

			// The size of the array record (header size + numElements * elementSize)
			int arraySize = 16 + elementSize * elementsCounter; //get back to this later

			//System.out.print(elementsCounter);
			System.out.print(arraySize);
			//code.add(DLabel, arrayLabel);
			// Request memory for the array record
			code.add(PushI, arraySize);
			code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE);

			// Store the returned pointer into a temporary location
			code.add(Duplicate);
			code.add(DLabel, arrayLabel);
			code.add(PushD, arrayLabel);
			code.add(Exchange);
			code.add(StoreI);

			// Set up the header of the array record
			code.add(Duplicate);
			code.add(PushI, 5);  // Type ID for array records
			code.add(StoreI);
/*			code.add(Duplicate);
			code.add(LoadI);
			code.add(PushD, RunTime.INTEGER_PRINT_FORMAT);
			code.add(Printf);*/
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, 0);  // Status bits for the array record
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, elementSize);  // Subtype size
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, elementsCounter);  // Length of the array
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);

			// Now, generate the array elements in memory
			for (int elementValue : elementsValues) {
				code.add(Duplicate);
				code.add(PushI, elementValue);
				code.add(Nop);
				code.add(StoreI);
				code.add(PushI, elementSize);
				code.add(Add);
			}


/*			// Fetch the base address of the current array element
			code.add(PushI, elementsCounter * elementSize);  // Offset of the elements block address in the array record
			code.add(Subtract);
			code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
			code.add(Exchange);
			code.add(StoreI);*/
			code.add(Pop);

		// Push the address of the array record to the stack
			code.add(PushD, arrayLabel);
			code.add(LoadI);

		}

	/*	private int arrayCounter = 0;
		public void visitLeave(ArrayLiteralNode node) {
			newValueCode(node);

			int elementsCounter = 0;
			String arrayLabel = "$arr-" + arrayCounter++;
			List<ASMCodeFragment> elementsCode = new ArrayList<>();
			List<Integer> elementsValues = new ArrayList<>();  // list for storing elements' values

			for (ParseNode child : node.getChildren()) {
				// Get the actual value of the child node before it's translated to ASM code
				int value = getActualValue(child);  // use your method here
				elementsValues.add(value);

				ASMCodeFragment childCode = removeValueCode(child);
				elementsCode.add(childCode);
				elementsCounter++;
			}

			// The type of array elements (assuming all elements are of the same type)
			Type elementType = node.child(0).getType();
			int elementSize = elementType.getSize();

			// Now, generate the array record
			code.add(DLabel, arrayLabel);
			code.add(DataI, 5);  // Type ID for array records
			code.add(DataI, 0);  // Status bits for the array record
			code.add(DataI, elementSize);  // Subtype size
			code.add(DataI, elementsCounter);  // Length of the array

			// Now, generate the array elements in memory
			for (int elementValue : elementsValues) {
				code.add(DataI, elementValue);
			}

			// Push the address of the array elements to ARRAY_BASE_ADDRESS
			code.add(PushD, arrayLabel);
			// Fetch the base address of the current array element
			code.add(PushI, 16);  // Offset of the elements block address in the array record
			code.add(Add);
			code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
			code.add(Exchange);
			code.add(StoreI);

			// Push the length of the array to ARRAY_LENGTH
			code.add(PushI, elementsCounter);
			code.add(PushD, RunTime.ARRAY_LENGTH);
			code.add(Exchange);
			code.add(StoreI);

			// Initialize ARRAY_INDEX to 0
			code.add(PushI, 0);
			code.add(PushD, RunTime.ARRAY_INDEX);
			code.add(Exchange);
			code.add(StoreI);

			// Push the address of the array record to the stack
			code.add(PushD, arrayLabel);

		}*/
		public void visitLeave(ArrayAccessNode node) {
			newValueCode(node);

			ASMCodeFragment arrayAddress = removeValueCode(node.child(0));
			ASMCodeFragment index = removeValueCode(node.child(1));

			code.append(arrayAddress); // loads the address of the array record


			// Load ARRAY_INDEX from the provided index
			code.append(index);
			code.add(PushD, RunTime.ARRAY_INDEX);
			code.add(Exchange);
			code.add(StoreI);

			code.add(Call, RunTime.ARRAY_INDEXING);

		}

		public void visitLeave(ArrayInstantiationNode node) {
			newValueCode(node);

			// Do not try to retrieve a code from ArrayTypeNode. Instead, get the type information directly from it.
			ArrayType arrayType = (ArrayType) node.child(0).getType();
			int subtypeSize = arrayType.getSubtype().getSize();

			// Get the size expression's code
			ASMCodeFragment arraySize = removeValueCode(node.child(1));

			code.append(arraySize);

			// Load record values
			code.add(PushI, 5); // Array type identifier
			code.add(PushI, 0); // Immutability status, subtype-is-reference status, is-deleted status, permanent status
			code.add(PushI, subtypeSize); // Subtype size

			// Call memory manager to allocate memory
			code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE); // Assuming the method in the memory manager for allocating memory is called MEM_MANAGER_ALLOCATE

			// Save record address
			Labeller labeller = new Labeller("array");
			String arrayRecordAddress = labeller.newLabel("record-address");
			code.add(DLabel, arrayRecordAddress);
			code.add(StoreI);

			// Set ARRAY_BASE_ADDRESS to start of array
			code.add(Duplicate);
			code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
			code.add(Exchange);
			code.add(StoreI);

			// Load ARRAY_LENGTH with the size of the array
			code.append(arraySize);
			code.add(PushD, RunTime.ARRAY_LENGTH);
			code.add(Exchange);
			code.add(StoreI);
		}


		public void visit(ArrayTypeNode node) {
			//newValueCode(node);

			Type arrayType = ((ArrayType)node.getType()).getSubtype();
			int typeSize = arrayType.getSize();

			// Array type records have the following format:
			code.add(PushI, 5); // Array type identifier
			code.add(PushI, 0); // Immutability status, subtype-is-reference status, is-deleted status, permanent status
			code.add(PushI, typeSize); // Subtype size

			// We don't know the length or the elements at compile time,
			// so we cannot generate code for them here.
		}

	}

}
