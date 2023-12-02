package tokens;

import inputHandler.LocatedChar;
import inputHandler.TextLocation;

public class StringToken extends TokenImp {
    private String value;

    private StringToken(TextLocation location, String lexeme) {
        super(location, lexeme);
        setValue(lexeme);
    }

    private void setValue(String lexeme) {
        // Remove the starting and ending double quotes
        this.value = lexeme.substring(1, lexeme.length() - 1);
    }

    public String getValue() {
        return value;
    }

    public static StringToken make(LocatedChar firstChar, String lexeme) {
        TextLocation location = firstChar.getLocation();
        return new StringToken(location, lexeme);
    }

    @Override
    protected String rawString() {
        return "string, " + value;
    }
}
