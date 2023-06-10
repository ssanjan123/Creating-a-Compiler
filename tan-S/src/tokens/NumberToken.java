package tokens;

import inputHandler.Locator;
import logging.TanLogger;

import static java.lang.System.exit;

public class NumberToken extends TokenImp {
	protected int value;
	
	protected NumberToken(Locator locator, String lexeme) {
		super(locator, lexeme);
	}
	protected void setValue(int value) {
		this.value = value;
	}
	public int getValue() {
		return value;
	}
	
	public static NumberToken make(Locator locator, String lexeme) {
		NumberToken result = new NumberToken(locator, lexeme);
		//lexeme.contains() use this for 2E400
		System.out.println(lexeme);
		try{
			result.setValue(Integer.parseInt(lexeme));
		} catch (NumberFormatException e) {//exception
			throw new IntegerTooLargeError(e);
		}

		return result;
	}
	
	@Override
	protected String rawString() {
		return "number, " + value;
	}


}

class IntegerTooLargeError extends Error{
	IntegerTooLargeError(NumberFormatException e) {
		//e.printStackTrace();
	}
}



