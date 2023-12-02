package symbolTable;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import logging.TanLogger;

import tokens.Token;

public class SymbolTable {
	private Map<String, Binding> table;
	//private Map<String,FunctionBinding> functionTable;

	public SymbolTable() {
		table = new HashMap<String, Binding>();
		//functionTable = new HashMap<String, FunctionBinding>();
	}


	////////////////////////////////////////////////////////////////
	// installation and lookup of identifiers

	public Binding install(String identifier, Binding binding) {
		table.put(identifier, binding);
		// Add debug logging
		//System.out.println("Installed binding for " + identifier + " in symbol table: " + table);
		return binding;
	}
	public Binding lookup(String identifier) {
		return table.getOrDefault(identifier, Binding.nullInstance());
	}
	//For Functions
	public FunctionBinding installFunction(String functionName, FunctionBinding binding) {
		table.put(functionName, binding);
		return binding;
	}


	///////////////////////////////////////////////////////////////////////
	// Map delegates

	public boolean containsKey(String identifier) {
		return table.containsKey(identifier);
	}
	public Set<String> keySet() {
		return table.keySet();
	}
	public Collection<Binding> values() {
		return table.values();
	}


	///////////////////////////////////////////////////////////////////////
	//error reporting

	public void errorIfAlreadyDefined(Token token) {
		if(containsKey(token.getLexeme())) {
			multipleDefinitionError(token);
		}
	}
	protected static void multipleDefinitionError(Token token) {
		TanLogger log = TanLogger.getLogger("compiler.symbolTable");
		log.severe("variable \"" + token.getLexeme() +
				"\" multiply defined at " + token.getLocation());
	}

	///////////////////////////////////////////////////////////////////////
	// toString

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("    symbol table: \n");
		for(String key : table.keySet()) {
			Binding binding = table.get(key);
			buffer.append("        ");
			buffer.append(binding);
			buffer.append("\n");
		}
		return buffer.toString();
	}

	// Checks if the table already contains a binding for the identifier
	public boolean containsBinding(String identifier) {
		return table.containsKey(identifier);
	}
}
