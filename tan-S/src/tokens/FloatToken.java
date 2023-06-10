package tokens;

import inputHandler.Locator;

public class FloatToken extends TokenImp {
    protected float value;

    protected FloatToken(Locator locator, String lexeme) {
        super(locator, lexeme);
    }
    protected void setValue(float value) {
        this.value = value;
    }
    public float getValue() {
        return value;
    }

    public static FloatToken make(Locator locator, String lexeme) {
        FloatToken result = new FloatToken(locator, lexeme);
        result.setValue(Float.parseFloat(lexeme));
        return result;
    }

    @Override
    protected String rawString() {
        return "float, " + value;
    }
}
