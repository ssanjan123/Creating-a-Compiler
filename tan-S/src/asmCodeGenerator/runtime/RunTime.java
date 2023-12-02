package asmCodeGenerator.runtime;
import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.Macros;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
public class RunTime {

	public static final String ARRAY_INDEXING = "$$array-indexing";
	public static final String ARRAY_INDEX_OUT_OF_BOUNDS_ERROR = "$$array-index-out-of-bounds-error";
	public static final String ARRAY_NULL_POINTER_ERROR = "$$array-null-pointer-error";
	public static final String ARRAY_INDEXING_ERROR_MESSAGE = "$errors-array-indexing-message";
	public static final String ARRAY_NULL_POINTER_ERROR_MESSAGE = "$errors-array-null-pointer-message";
	public static final String ARRAY_PRINT_START_LABEL = "$array-print-start-label";
	public static final String ARRAY_PRINT_END_LABEL = "$array-print-end-label";
	public static final String ARRAY_PRINT_SEPARATOR_LABEL = "$array-print-separator-label";
	public static final String ARRAY_BASE_ADDRESS = "$array-base-address";
	public static final String ARRAY_LENGTH = "$array-length";
	public static final String ARRAY_INDEX = "$array-index";


	public static final String EAT_LOCATION_ZERO      = "$eat-location-zero";		// helps us distinguish null pointers from real ones.
	public static final String INTEGER_PRINT_FORMAT   = "$print-format-integer";
	public static final String FLOAT_PRINT_FORMAT = "$print-format-float";
	public static final String CHARACTER_PRINT_FORMAT = "$print-format-character";
	public static final String STRING_PRINT_FORMAT = "$print-format-string";

	public static final String BOOLEAN_PRINT_FORMAT   = "$print-format-boolean";
	public static final String NEWLINE_PRINT_FORMAT   = "$print-format-newline";
	public static final String SPACE_PRINT_FORMAT     = "$print-format-space";
	public static final String TAB_PRINT_FORMAT       = "$print-format-tab";
	public static final String BOOLEAN_TRUE_STRING    = "$boolean-true-string";
	public static final String BOOLEAN_FALSE_STRING   = "$boolean-false-string";
	public static final String GLOBAL_MEMORY_BLOCK    = "$global-memory-block";
	public static final String USABLE_MEMORY_START    = "$usable-memory-start";
	public static final String MAIN_PROGRAM_LABEL     = "$$main";
	public static final String FUNCTION_REACHED_END = "$$l-reached-end-of-function";
	public static final String GENERAL_RUNTIME_ERROR = "$$general-runtime-error";
	public static final String INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$i-divide-by-zero";
	public static final String FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$f-divide-by-zero";
	public static final String STACK_POINTER = "$stack-pointer";
	public static final String FRAME_POINTER = "$frame-pointer";
    public static final String LOCAL_MEMORY_BLOCK = "$local-memory-block";;

    private ASMCodeFragment environmentASM() {
		ASMCodeFragment result = new ASMCodeFragment(GENERATES_VOID);
		result.append(functionCallPointers());
		result.append(jumpToMain());
		result.append(stringsForPrintf());
		result.append(runtimeErrors());
		result.append(arrayIndexingRoutine());
		result.append(arrayIndexOutOfBoundsError());
		result.append(arrayNullPointerError());
		result.add(DLabel, ARRAY_BASE_ADDRESS);
		result.add(DataZ, 8); // Initialize with zero
		result.add(DLabel, ARRAY_LENGTH);
		result.add(DataZ, 8); // Initialize with zero
		result.add(DLabel, ARRAY_INDEX);
		result.add(DataZ, 8); // Initialize with zero
		result.add(DLabel, USABLE_MEMORY_START);
		return result;
	}
	private ASMCodeFragment functionCallPointers() {
		ASMCodeFragment frag  = new ASMCodeFragment(GENERATES_VOID);

		Macros.declareI(frag, FRAME_POINTER);
		Macros.declareI(frag, STACK_POINTER);
		frag.add(Memtop);
		frag.add(Duplicate);
		Macros.storeITo(frag, FRAME_POINTER);
		Macros.storeITo(frag, STACK_POINTER);

		return frag;
	}

	//For Arrays
	private ASMCodeFragment arrayIndexingRoutine() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);

		frag.add(Label, ARRAY_INDEXING);
		// Here, the top of the stack contains the index, and the next value contains the array address
		// Check for null pointer
		frag.add(Duplicate);
		frag.add(JumpFalse, ARRAY_NULL_POINTER_ERROR);

		// Check for out of bounds
		frag.add(Duplicate);
		frag.add(PushI, 16); // Offset of array length in record
		frag.add(Add);
		frag.add(LoadI);
		frag.add(PushD, ARRAY_INDEX);
		frag.add(LoadI);
		frag.add(Subtract);
		frag.add(JumpNeg, ARRAY_INDEX_OUT_OF_BOUNDS_ERROR);

		// Calculate and push element address
		frag.add(PushI, 20); // Offset of array elements in record (considering size of metadata)
		frag.add(Add);
		frag.add(Exchange);
		frag.add(PushI, 4);  // The size of the array subtype
		frag.add(LoadI);
		frag.add(Multiply);
		frag.add(Add);

		// Now the top of the stack is the address of the requested array element
		//System.out.println("Element address: " + frag.toString()); // print the calculated address
		frag.add(Return);

		return frag;
	}


	private ASMCodeFragment arrayIndexOutOfBoundsError() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);

		frag.add(DLabel, ARRAY_INDEXING_ERROR_MESSAGE);
		frag.add(DataS, "Array index out of bounds");

		frag.add(Label, ARRAY_INDEX_OUT_OF_BOUNDS_ERROR);
		frag.add(PushD, ARRAY_INDEXING_ERROR_MESSAGE);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);

		return frag;
	}

	private ASMCodeFragment arrayNullPointerError() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);

		frag.add(DLabel, ARRAY_NULL_POINTER_ERROR_MESSAGE);
		frag.add(DataS, "Null pointer error");

		frag.add(Label, ARRAY_NULL_POINTER_ERROR);
		frag.add(PushD, ARRAY_NULL_POINTER_ERROR_MESSAGE);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);

		return frag;
	}

	private ASMCodeFragment jumpToMain() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		frag.add(Jump, MAIN_PROGRAM_LABEL);
		return frag;
	}

	private ASMCodeFragment stringsForPrintf() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		frag.add(DLabel, EAT_LOCATION_ZERO);
		frag.add(DataZ, 8);
		frag.add(DLabel, INTEGER_PRINT_FORMAT);
		frag.add(DataS, "%d");
		frag.add(DLabel, FLOAT_PRINT_FORMAT);
		frag.add(DataS, "%f");
		frag.add(DLabel, CHARACTER_PRINT_FORMAT);
		frag.add(DataS, "%c");
		frag.add(DLabel, BOOLEAN_PRINT_FORMAT);
		frag.add(DataS, "%s");
		frag.add(DLabel, STRING_PRINT_FORMAT);   // Add this line
		frag.add(DataS, "%s");                   // Add this line
		frag.add(DLabel, ARRAY_PRINT_START_LABEL);
		frag.add(DataS, "[");
		frag.add(DLabel, ARRAY_PRINT_END_LABEL);
		frag.add(DataS, "]");
		frag.add(DLabel, ARRAY_PRINT_SEPARATOR_LABEL);
		frag.add(DataS, ", ");
		frag.add(DLabel, NEWLINE_PRINT_FORMAT);
		frag.add(DataS, "\n");
		frag.add(DLabel, TAB_PRINT_FORMAT);
		frag.add(DataS, "\t");
		frag.add(DLabel, SPACE_PRINT_FORMAT);
		frag.add(DataS, " ");
		frag.add(DLabel, BOOLEAN_TRUE_STRING);
		frag.add(DataS, "true");
		frag.add(DLabel, BOOLEAN_FALSE_STRING);
		frag.add(DataS, "false");

		return frag;
	}

	
	private ASMCodeFragment runtimeErrors() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		
		generalRuntimeError(frag);
		integerDivideByZeroError(frag);
		floatDivideByZeroError(frag);
		endOfFunctionNoReturnStatement(frag);
		
		return frag;
	}
	private ASMCodeFragment generalRuntimeError(ASMCodeFragment frag) {
		String generalErrorMessage = "$errors-general-message";

		frag.add(DLabel, generalErrorMessage);
		frag.add(DataS, "Runtime error: %s\n");
		
		frag.add(Label, GENERAL_RUNTIME_ERROR);
		frag.add(PushD, generalErrorMessage);
		frag.add(Printf);
		frag.add(Halt);
		return frag;
	}
	private void integerDivideByZeroError(ASMCodeFragment frag) {
		String intDivideByZeroMessage = "$errors-int-divide-by-zero";
		
		frag.add(DLabel, intDivideByZeroMessage);
		frag.add(DataS, "integer divide by zero");
		
		frag.add(Label, INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, intDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}

	private void floatDivideByZeroError(ASMCodeFragment frag) {
		String floatDivideByZeroMessage = "$errors-float-divide-by-zero";

		frag.add(DLabel, floatDivideByZeroMessage);
		frag.add(DataS, "float divide by zero");

		frag.add(Label, FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, floatDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}

	private void endOfFunctionNoReturnStatement(ASMCodeFragment frag) {
		String endOfFunctionNoReturnStatementErrorMessage = "$errors-end-of-function-no-return";

		frag.add(DLabel, endOfFunctionNoReturnStatementErrorMessage);
		frag.add(DataS, "reached end of function but no return was issued");

		frag.add(Label, FUNCTION_REACHED_END);
		frag.add(PushD, endOfFunctionNoReturnStatementErrorMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	public static ASMCodeFragment getEnvironment() {
		RunTime rt = new RunTime();
		return rt.environmentASM();
	}
}
