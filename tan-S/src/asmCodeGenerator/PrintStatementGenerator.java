package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpTrue;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;
import static asmCodeGenerator.codeStorage.ASMOpcode.Printf;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushD;

import applications.TanCompiler;
import asmCodeGenerator.codeStorage.ASMOpcode;
import parseTree.ParseNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.TabNode;
import semanticAnalyzer.types.ArrayType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.runtime.RunTime;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class PrintStatementGenerator {
	ASMCodeFragment code;
	ASMCodeGenerator.CodeVisitor visitor;


	public PrintStatementGenerator(ASMCodeFragment code, CodeVisitor visitor) {
		super();
		this.code = code;
		this.visitor = visitor;
	}

	public void generate(PrintStatementNode node) {
		for(ParseNode child : node.getChildren()) {
			if(child instanceof NewlineNode || child instanceof SpaceNode || child instanceof TabNode) {
				ASMCodeFragment childCode = visitor.removeVoidCode(child);
				code.append(childCode);
			}
			else {
				appendPrintCode(child);
			}
		}
	}

	private void appendPrintCode(ParseNode node) {
		if (node.getType() instanceof ArrayType) {
			appendPrintArrayCode(node);
		} else {
			String format = printFormat(node.getType());

			code.append(visitor.removeValueCode(node));
			if (node.getType() == PrimitiveType.STRING) {
				// Assumes the metadata is 12 bytes long, adjust accordingly if it differs
				code.add(PushI, 12);
				code.add(Add);
			} else {
				convertToStringIfBoolean(node);
			}
			code.add(PushD, format);
			code.add(Printf);
		}
	}

	public ASMOpcode opcodeForLoad(Type type) {
		if (type == PrimitiveType.INTEGER || type == PrimitiveType.CHARACTER || type == PrimitiveType.STRING || type instanceof ArrayType) {
			return LoadI;
		}
		if (type == PrimitiveType.BOOLEAN) {
			return LoadC;
		}
		if (type == PrimitiveType.FLOAT) {
			return LoadF;
		}

		assert false: "Type " + type + " unimplemented in opcodeForStore()";
		return null;
	}
	private static int printCounter = 0;
	private void appendPrintArrayCode(ParseNode node) {
		Type type = ((ArrayType) node.getType()).getSubtype();
		String length = "len" + printCounter;
		String index = "index" + printCounter;
		code.add(DLabel, length);
		code.add(DataZ,8);
		code.add(DLabel, index);
		code.add(DataZ,8);
		printCounter++;



		// Store ARRAY_BASE_ADDRESS and ARRAY_LENGTH
		code.add(Duplicate);  // Duplicate the address of the array record
		code.add(PushI, 12);  // Offset of the array length in the array record
		code.add(Add);
		code.add(LoadI);

		code.add(PushD, length);
		code.add(Exchange);
		code.add(StoreI);


		code.add(PushI, 16);  // Offset of the elements block address in the array record
		code.add(Add);


		code.add(PushD, RunTime.ARRAY_PRINT_START_LABEL);
		code.add(Printf); // Print the opening bracket of array



		//Set index to 0
		code.add(PushD, index);
		code.add(PushI, 0);
		code.add(StoreI);

		String startLabel = "start_" + printCounter;
		String endLabel = "end_" + printCounter;
		String skipCommaLabel = "skip_comma_space_" + printCounter;

		code.add(Label, startLabel); // Start of the loop
		code.add(Duplicate);  // Duplicate the address of the array record
		code.add(opcodeForLoad(type));
		if (type instanceof ArrayType){
			// Recursion for nested array
			ParseNode childNode = new ParseNode(node.getToken());
			childNode.setType(type);
			appendPrintArrayCode(childNode); // Skip array address fetch for recursive call and increment printCounter
		}
		else {// Print the array element
			String format = printFormat(type);
			code.add(PushD, format);
			code.add(Printf);            // Print it
		}

		// Increment ARRAY_INDEX
		code.add(PushD, index);
		code.add(LoadI);
		code.add(PushI, 1);
		code.add(Add);
		code.add(PushD, index);
		code.add(Exchange);
		code.add(StoreI);


		// Load ARRAY_LENGTH and ARRAY_INDEX onto the stack
		code.add(PushD, length);
		code.add(LoadI);
		code.add(PushD, index);
		code.add(LoadI);
		// Compare ARRAY_INDEX and ARRAY_LENGTH
		code.add(Subtract);
		code.add(JumpFalse, endLabel); // If ARRAY_INDEX is equal to ARRAY_LENGTH, jump to end

		//code.add(Pop);

		if(type instanceof ArrayType){
			code.add(PushI, 4);
		}
		else {
			code.add(PushI, type.getSize());
		}
		code.add(Add);

		// Print a comma and space if not the last element
		code.add(PushD, index);
		code.add(LoadI);
		code.add(PushD, length);
		code.add(LoadI);
		code.add(Subtract);
		code.add(JumpFalse, skipCommaLabel);
		code.add(PushD, RunTime.ARRAY_PRINT_SEPARATOR_LABEL);
		code.add(Printf);
		code.add(Label, skipCommaLabel);

		code.add(Jump, startLabel); // Jump back to start
		code.add(Label, endLabel); // End of the loop

		code.add(PushD, RunTime.ARRAY_PRINT_END_LABEL);
		code.add(Printf); // Print the closing bracket of array
		//code.add(Pop);
		code.add(Pop);


/*
		// Fetch the base address of the current element of the array
		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(LoadI);
		code.add(Duplicate);
		if(type == PrimitiveType.FLOAT) {
			code.add(LoadF);  // Dereference to get value
		}
		else {
			code.add(LoadI);
		}




		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(LoadI);
		code.add(PushI, type.getSize());
		code.add(Add);
		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(Exchange);
		code.add(StoreI);

		// Print a comma and space if not the last element
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(LoadI);
		code.add(PushD, RunTime.ARRAY_LENGTH);
		code.add(LoadI);
		code.add(Subtract);
		code.add(JumpFalse, skipCommaLabel);
		code.add(PushD, RunTime.ARRAY_PRINT_SEPARATOR_LABEL);
		code.add(Printf);
		code.add(Label, skipCommaLabel);






		printCounter++; // Increment the print counter for the next array

		// Reset ARRAY_BASE_ADDRESS and ARRAY_INDEX
		//code.add(PushI, 0);
		code.add(Duplicate);
		code.add(PushI, 4);
		code.add(Subtract);
		code.add(LoadI);
		code.add(PushD, RunTime.ARRAY_LENGTH);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushI, 0);
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(Exchange);
		code.add(StoreI);*/
	}



	/*private static int printCounter = 0;
	private void appendPrintArrayCode(ParseNode node, boolean skipArrayAddressFetch, int printCounter) {
		if (!skipArrayAddressFetch) {
			// Load the base address and length of the array to print
			ASMCodeFragment arrayAddress = visitor.removeValueCode(node);
			code.append(arrayAddress);

		}
		// Store ARRAY_BASE_ADDRESS and ARRAY_LENGTH
		code.add(Duplicate);  // Duplicate the address of the array record
		code.add(PushI, 16);  // Offset of the elements block address in the array record
		code.add(Add);

		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushI, 12);  // Offset of the array length in the array record
		code.add(Add);
		code.add(LoadI);
		code.add(PushD, RunTime.ARRAY_LENGTH);
		code.add(Exchange);
		code.add(StoreI);
		Type type = ((ArrayType) node.getType()).getSubtype();
		code.add(PushD, RunTime.ARRAY_PRINT_START_LABEL);
		code.add(Printf); // Print the opening bracket of array

		String startLabel = "start_" + printCounter;
		String endLabel = "end_" + printCounter;
		String skipCommaLabel = "skip_comma_space_" + printCounter;

		code.add(Label, startLabel); // Start of the loop
		// Load ARRAY_LENGTH and ARRAY_INDEX onto the stack
		code.add(PushD, RunTime.ARRAY_LENGTH);
		code.add(LoadI);
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(LoadI);
		// Compare ARRAY_INDEX and ARRAY_LENGTH
		code.add(Subtract);
		code.add(JumpFalse, endLabel); // If ARRAY_INDEX is equal to ARRAY_LENGTH, jump to end
		// Fetch the base address of the current element of the array
		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(LoadI);
		code.add(Duplicate);
		if(type == PrimitiveType.FLOAT) {
			code.add(LoadF);  // Dereference to get value
		}
		else {
			code.add(LoadI);
		}

		if (type instanceof ArrayType){
			code.add(PushD, RunTime.ARRAY_PRINT_START_LABEL);
			code.add(Printf); // Print the opening bracket of array
			// Recursion for nested array
			ParseNode childNode = new ParseNode(node.getToken());
			childNode.setType(type);
			appendPrintArrayCode(childNode, true, printCounter+1); // Skip array address fetch for recursive call and increment printCounter
			code.add(PushD, RunTime.ARRAY_PRINT_END_LABEL);
			code.add(Printf); // Print the closing bracket of array
		}
		else {// Print the array element
			String format = printFormat(type);
			code.add(PushD, format);
			code.add(Printf);            // Print it
		}

		// Increment ARRAY_INDEX and ARRAY_BASE_ADDRESS
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(LoadI);
		code.add(PushI, 1);
		code.add(Add);
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(LoadI);
		code.add(PushI, type.getSize());
		code.add(Add);
		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(Exchange);
		code.add(StoreI);



		code.add(Jump, startLabel); // Jump back to start

		code.add(Label, endLabel); // End of the loop



		code.add(PushD, RunTime.ARRAY_PRINT_END_LABEL);
		code.add(Printf); // Print the closing bracket of array

		printCounter++; // Increment the print counter for the next array

		// Reset ARRAY_BASE_ADDRESS and ARRAY_INDEX
		//code.add(PushI, 0);
		code.add(Duplicate);
		code.add(PushI, 4);
		code.add(Subtract);
		code.add(LoadI);
		code.add(PushD, RunTime.ARRAY_LENGTH);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushD, RunTime.ARRAY_BASE_ADDRESS);
		code.add(Exchange);
		code.add(StoreI);

		code.add(PushI, 0);
		code.add(PushD, RunTime.ARRAY_INDEX);
		code.add(Exchange);
		code.add(StoreI);
	}

*/

	private void convertToStringIfBoolean(ParseNode node) {
		if(node.getType() != PrimitiveType.BOOLEAN) {
			return;
		}
		
		Labeller labeller = new Labeller("print-boolean");
		String trueLabel = labeller.newLabel("true");
		String endLabel = labeller.newLabel("join");

		code.add(JumpTrue, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_FALSE_STRING);
		code.add(Jump, endLabel);
		code.add(Label, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_TRUE_STRING);
		code.add(Label, endLabel);
	}


	private static String printFormat(Type type) {
		assert type instanceof PrimitiveType;

		switch((PrimitiveType)type) {
			case INTEGER:  return RunTime.INTEGER_PRINT_FORMAT;
			case BOOLEAN:  return RunTime.BOOLEAN_PRINT_FORMAT;
			case FLOAT:    return RunTime.FLOAT_PRINT_FORMAT;
			case CHARACTER: return RunTime.CHARACTER_PRINT_FORMAT;
			case STRING: return RunTime.STRING_PRINT_FORMAT;   // Add this line
			default:
				assert false : "Type " + type + " unimplemented in PrintStatementGenerator.printFormat()";
				return "";
		}
	}

}
