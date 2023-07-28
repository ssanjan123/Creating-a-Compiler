package tokens;

import inputHandler.Locator;

public class BooleanToken extends TokenImp {
    protected boolean value;

    protected BooleanToken(Locator locator, String lexeme) {
        super(locator, lexeme);
    }
    protected void setValue(boolean value) {
        this.value = value;
    }
    public boolean getValue() {
        return value;
    }

    public static BooleanToken make(Locator locator, String lexeme) {
        BooleanToken result = new BooleanToken(locator, lexeme);
        //lexeme.contains() use this for 2E400

        result.setValue(Boolean.parseBoolean(lexeme));


        return result;
    }

    @Override
    protected String rawString() {
        return "number, " + value;
    }


}
