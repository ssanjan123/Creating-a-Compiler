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
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import parseTree.*;
import parseTree.nodeTypes.*;
import parseTree.nodeTypes.IfStatementNode;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.types.ArrayType;
import semanticAnalyzer.signatures.PromotedSignature;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.Binding;
import symbolTable.Scope;


import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;


// do not call the code generator if any errors have occurred during analysis.
public class ASMCodeGenerator {
	public static final int ADDRESS_SIZE = PrimitiveType.STRING.getSize();
	public static final int FRAME_ADDITIONAL_SIZE = ADDRESS_SIZE * 2;

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
		code.add(DLabel, RunTime.LOCAL_MEMORY_BLOCK);
		code.add(DataZ, root.child(root.nChildren()-1).getScope().getAllocatedSize());
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
			assert  frag.isVoid();
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
				code.append(arrayAddress);
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
			//System.out.print(rvalue);
			code.append(lvalue);
			code.append(rvalue);

			Type type;
			if(node.getToken().isLextant(Keyword.SUBR)){
				//type = node.child(1).child(0).getType();
				type = PrimitiveType.INTEGER;
			}
			else{
				type = node.getType();
			}
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
/*			if(type instanceof ArrayType) {
				// store array's base address in the variable's memory location
				code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
				code.add(LoadI);
				code.add(StoreI);
			}*/
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


		private ASMOpcode opcodeForLoad(Type type) {
			if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER || type == PrimitiveType.STRING || type instanceof ArrayType) {
				return LoadI;
			}
			if (type == PrimitiveType.BOOLEAN) {
				return LoadC;
			}
			if (type == PrimitiveType.FLOAT) {
				return LoadF;
			}

			assert false: "Type " + type + " unimplemented in opcodeForLoad()";
			return null;
		}



		///////////////////////////////////////////////////////////////////////////
		// expressions
		public void visitLeave(OperatorNode node) {
			Lextant operator = node.getOperator();
			//FunctionSignature signature = node.getSignature();
			PromotedSignature signature = node.getPromotedSignature();
			Object variant = signature.getVariant();

			if (variant instanceof ASMOpcode){
				Labeller labeller = new Labeller("Operator");
				String startLabel = labeller.newLabel("args");
				String opLabel = labeller.newLabel("op");

				int i = 0;
				//operator + not defined
				newValueCode(node);
				code.add(Label, startLabel);
				for (ParseNode child: node.getChildren()){
					code.append(removeValueCode(child));
					code.append(signature.promotion(i).codeFor());//0
					i++;
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

		public void visitLeave(IfStatementNode node) {//return here after && and || to make sure result of those expression leaves something compatible for this part
			Labeller labeller = new Labeller("If");// don't say "if statement
			String ifLabel = labeller.newLabel("ifBlock");
			String elseLabel = labeller.newLabel("elseBlock");
			String endLabel = labeller.newLabel("end");

			newVoidCode(node);
			ASMCodeFragment expressionFragment = removeValueCode(node.child(0)); // Extract the expression fragment

			code.append(expressionFragment);
			code.add(JumpTrue, ifLabel); // always jumping

			//else
			if (node.getChildren().size() >= 3){
				code.add(Label, elseLabel); //incorrect labelling?
				ASMCodeFragment elseFragment = removeVoidCode(node.child(2)); // Extract the else block fragment
				code.append(elseFragment);
			}
			code.add(Jump, endLabel);

			//if
			code.add(Label, ifLabel);
			ASMCodeFragment ifFragment = removeVoidCode(node.child(1)); // Extract the if block fragment
			code.append(ifFragment);
			code.add(Label, endLabel);

			//defined multiple times
		}

		public void visitLeave(WhileStatementNode node) {//return here after && and || to make sure result of those expression leaves something compatible for this part
			Labeller labeller = new Labeller("While");// don't say "if statement
			String whileLabel = labeller.newLabel("whileBlock");
			String endLabel = labeller.newLabel("end");

			newVoidCode(node);
			ASMCodeFragment expressionFragment = removeValueCode(node.child(0)); // Extract the expression fragment
			code.add(Label, whileLabel);
			code.append(expressionFragment);
			code.add(JumpFalse, endLabel);

			//while
			ASMCodeFragment whileFragment = removeVoidCode(node.child(1)); // Extract the while block fragment
			code.append(whileFragment);
			code.add(Jump, whileLabel);
			code.add(Label, endLabel);

		}

		public void visitLeave(ForStatementNode node) {//return here after && and || to make sure result of those expression leaves something compatible for this part
			Labeller labeller = new Labeller("ForStatement");// don't say "if statement
			String forLabel = labeller.newLabel("for");
			String counter = labeller.newLabel("counter");
			String max = labeller.newLabel("max");
			String loopLabel = labeller.newLabel("loop");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String endLabel = labeller.newLabel("end");

			newVoidCode(node);


			ASMCodeFragment fromFragment = removeValueCode(node.child(0)); // Extract the from fragment
			ASMCodeFragment toFragment = removeValueCode(node.child(1));
			ASMCodeFragment blockFragment = removeVoidCode(node.child(2));



			//we need to store in DATA counter and max

			code.add(Label, forLabel);

			code.add(DLabel, max);
			code.append(toFragment);//dataI start hopefully
			code.add(PushD, max);

			code.add(DLabel, counter);
			code.append(fromFragment);//dataI start hopefully
			code.add(PushD, counter);

			code.add(Label, loopLabel);//lessthan or equal to
			code.add(DataD, counter);
			code.add(DataD, max);
			code.add(ASMOpcode.Subtract);
			code.add(ASMOpcode.JumpPos, trueLabel);//pops stack

			//if less than or equal
			code.add(Label, falseLabel);
			//code.add(ASMOpcode.PushI, 1);//false
			code.add(ASMOpcode.Jump, endLabel);


			//not less or equal
			code.add(Label, trueLabel);
			//code.add(ASMOpcode.PushI, 0);//true
			code.append(blockFragment);

			//increment counter
			code.add(DataD, counter);//address of counter
			code.add(LoadI);
			code.add(PushI, 1);
			code.add(Add);

			code.add(DataD, counter);
			code.add(Exchange);

			code.add(StoreI);
			code.add(Jump, loopLabel);

			code.add(ASMOpcode.Label, endLabel);

		}





		///////////////////////////////////////////////////////////////////////////
		// leaf nodes (ErrorNode not necessary)
		public void visit(BreakNode node) {
			newVoidCode(node);
			//code.add(Jump, endLabel);
			//three potential methods left
			//go up tree in asmcodegenerator
			//pass down most breakpoint down tree
			// create pointer in semantic analysis
		}

		public void visit(ContinueNode node) {
			newVoidCode(node);
			//code.add(Jump, loopLabel);// find new delivery
		}

		public void visit(BooleanConstantNode node) {
			newValueCode(node);
			code.add(PushI, node.getValue() ? 1 : 0);
		}
		public void visit(IdentifierNode node) {
			newAddressCode(node);
			//System.out.print(node);
			// Add debug logging
			//System.out.println("Searching for binding for " + node.getToken().getLexeme() + " in scope " + node.getLocalScope());
			Binding binding = node.findVariableBinding();
			// Add debug logging
			//System.out.println("Visiting IdentifierNode for " + node.getToken().getLexeme() + " with current scope " + node.getLocalScope());
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
			Type elementType = node.child(0).getType();

			boolean arrayOfArrays = elementType instanceof ArrayType;

			int elementsCounter = 0;
			String arrayLabel = "$arr-" + arrayCounter++;
			List<ASMCodeFragment> elementsCode = new ArrayList<>();
			List<String> elementLabels = new ArrayList<>();
			int elementSize;
			boolean isFloat = false;

			if (elementType == PrimitiveType.FLOAT)
				isFloat = true;

			for (ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeValueCode(child);
				elementsCode.add(childCode);
				elementsCounter++;
			}
			if (arrayOfArrays) {
				elementSize = 4; // Size of a pointer
			} else {
				elementSize = elementType.getSize();
			}
			int arraySize = 16 + elementSize * elementsCounter;


			code.add(PushI, arraySize);
			code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE);
			code.add(Duplicate);
			code.add(DLabel, arrayLabel);
			code.add(DataI, 0);
			code.add(PushD, arrayLabel);
			code.add(Exchange);
			code.add(StoreI);
			code.add(Duplicate);
			code.add(PushI, 5);
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, 0);
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, elementSize);
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, elementsCounter);
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);

			if (arrayOfArrays) {
				for (ASMCodeFragment elementValue : elementsCode) {
					code.add(Duplicate);
					code.append(elementValue);
					code.add(Nop);
					code.add(StoreI);
					code.add(PushI, elementSize);
					code.add(Add);
				}
			} else if (isFloat) {
				for (ASMCodeFragment elementValue : elementsCode) {
					code.add(Duplicate);
					code.append(elementValue);
					code.add(Nop);
					code.add(StoreF);
					code.add(PushI, elementSize);
					code.add(Add);
				}
			} else {
				for (ASMCodeFragment elementValue : elementsCode) {
					code.add(Duplicate);
					code.append(elementValue);
					code.add(Nop);
					code.add(StoreI);
					code.add(PushI, elementSize);
					code.add(Add);
				}
			}

			code.add(Pop);
			code.add(PushD, arrayLabel);
			code.add(LoadI);
		}


		public void visitLeave(ArrayAccessNode node) {
			newAddressCode(node);

			ASMCodeFragment arrayAddress = removeValueCode(node.child(0));
			ASMCodeFragment index = removeValueCode(node.child(1));


			code.append(arrayAddress); // loads the address of the array record
			code.add(Duplicate);
			code.add(PushI,8); // Get the subtype size
			code.add(Add);
			code.add(LoadI);

			// Load ARRAY_INDEX from the provided index
			code.append(index);
			code.add(Multiply);
			code.add(PushI,16);
			code.add(Add);
			code.add(Add);

		}

		public void visitLeave(ArrayLengthNode node) {
			newValueCode(node);
			ASMCodeFragment arrayAddress = removeValueCode(node.child(0));
			code.append(arrayAddress);
			code.add(PushI, 12);
			code.add(Add);
			code.add(LoadI);
		}
		public void visitLeave(ArrayInstantiationNode node) {
			newValueCode(node);

			// Do not try to retrieve a code from ArrayTypeNode. Instead, get the type information directly from it.
			ArrayType arrayType = (ArrayType) node.child(0).getType();
			int subtypeSize = arrayType.getSubtype().getSize();
			String arrayLabel = "$arr-" + arrayCounter++;
			String arraySizeLabel = "$arrSize-" + arrayCounter;


			// Get the size expression's code
			ASMCodeFragment arraySize = removeValueCode(node.child(1));
			int value = getActualValueI(node.child(1));



			// Use the stored array size for memory allocation
			code.add(PushD, arraySizeLabel);
			code.add(LoadI);
			code.add(PushI, subtypeSize);
			code.add(Multiply);
			code.add(PushI, 16);
			code.add(Add);

			// Call memory manager to allocate memory
			code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE); // Assuming the method in the memory manager for allocating memory is called MEM_MANAGER_ALLOCATE

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
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, 0);  // Status bits for the array record
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, subtypeSize);  // Subtype size
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);
			code.add(Duplicate);
			code.add(PushI, value);  // Element length
			code.add(StoreI);
			code.add(PushI, 4);
			code.add(Add);


			int elementValue = 0;
			for (int i = 0; i < value; i++) {
				code.add(Duplicate);
				code.add(PushI, elementValue);
				code.add(Nop);
				code.add(StoreI);
				code.add(PushI, subtypeSize);
				code.add(Add);
			}



			code.add(Pop);

			// Push the address of the array record to the stack
			code.add(PushD, arrayLabel);
			code.add(LoadI);

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

	public void visitLeave(ParameterSpecificationNode node) {
			newVoidCode(node);
	}
		public void visitLeave(FunctionDefinitionNode node) {
			Type returnType = node.child(0).getType();
			newValueCode(node);
			code.add(Jump, node.getEndLabel());
			code.add(Label, node.getFunctionLocationLabel());
			Macros.loadIFrom(code, RunTime.STACK_POINTER);
			code.add(PushI, ADDRESS_SIZE);
			code.add(Subtract);
			code.add(Duplicate);
			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
			code.add(StoreI);
			code.add(PushI, ADDRESS_SIZE);
			code.add(Subtract);
			code.add(Exchange);
			code.add(StoreI);
			Macros.loadIFrom(code, RunTime.STACK_POINTER);
			Macros.storeITo(code, RunTime.FRAME_POINTER);
			ParseNode bodyCode = node.child(node.nChildren()-1);
			Macros.loadIFrom(code, RunTime.STACK_POINTER);
			code.add(PushI, bodyCode.getScope().getAllocatedSize() + FRAME_ADDITIONAL_SIZE);
			code.add(Subtract);
			Macros.storeITo(code, RunTime.STACK_POINTER);
			code.append(removeVoidCode(bodyCode));

			code.add(Jump, RunTime.FUNCTION_REACHED_END);
			code.add(Label, node.getReturnCodeLabel());
			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
			code.add(PushI, FRAME_ADDITIONAL_SIZE);
			code.add(Subtract);
			code.add(LoadI);

			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
			code.add(PushI, ADDRESS_SIZE);
			code.add(Subtract);
			code.add(LoadI);
			Macros.storeITo(code, RunTime.FRAME_POINTER);

			if(returnType == PrimitiveType.VOID){
				// [...  returnAddr]
			}
			else {
				code.add(Exchange);		// [...  returnAddr  returnValue]
			}
			Macros.loadIFrom(code, RunTime.STACK_POINTER);
			code.add(PushI, bodyCode.getScope().getAllocatedSize() + node.getScope().getAllocatedSize() + FRAME_ADDITIONAL_SIZE);
			code.add(Add);
			Macros.storeITo(code, RunTime.STACK_POINTER);

			if(returnType.equivalent(PrimitiveType.VOID)) {
				// [... retAddr]
			}
			else {
				Macros.loadIFrom(code, RunTime.STACK_POINTER); // [...  retAddr  retVal  SP_val]
				code.add(PushI, returnType.getSize());
				code.add(Subtract);
				code.add(Duplicate);
				Macros.storeITo(code, RunTime.STACK_POINTER);

				code.add(Exchange);

				code.add(opcodeForStore(returnType));
			}
			code.add(Return);

			code.add(Label, node.getEndLabel());
			code.add(PushD, node.getFunctionLocationLabel());

		}


		public void visitLeave(ReturnStatementNode node) {
			Type type = node.getType();
			newVoidCode(node);
			if(type != PrimitiveType.VOID) {
				code.append(removeValueCode(node.child(0)));
			}
			code.add(Jump, node.getFunctionReturnLabel());
		}
		public void visitLeave(FunctionInvocationNode node) {

			Type type = node.getType();
			//System.out.print(type);
			if(type == PrimitiveType.VOID) {
				newVoidCode(node);
			}
			else {
				newValueCode(node);
			}

			//System.out.print(node.child(2));
			ASMCodeFragment[] args = new ASMCodeFragment[node.nChildren()];
			for(int i=0;i<args.length;i++) {
				args[i] = removeValueCode(node.child(i));
				System.out.print(args[i]);
			}

			for(int i=1;i<args.length;i++) {
				Type argType = node.child(i).getType();
				Macros.loadIFrom(code, RunTime.STACK_POINTER);
				code.add(PushI, argType.getSize());
				code.add(Subtract);
				code.add(Duplicate);
				Macros.storeITo(code, RunTime.STACK_POINTER);
				code.append(args[i]);
				code.add(opcodeForStore(argType));
			}
			code.append(args[0]);
			code.add(CallV);


			if(type != PrimitiveType.VOID) {
				Macros.loadIFrom(code, RunTime.STACK_POINTER);
				code.add(opcodeForLoad(type));
				Macros.loadIFrom(code, RunTime.STACK_POINTER);
				code.add(PushI, type.getSize());
				code.add(Add);
				Macros.storeITo(code, RunTime.STACK_POINTER);
			}
		}

	}

}
