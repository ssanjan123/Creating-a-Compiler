package tokens;

import inputHandler.LocatedChar;
import inputHandler.TextLocation;

public class TypecastToken extends TokenImp {
    protected TypecastToken(TextLocation location, String lexeme) {
        super(location, lexeme.intern());
    }

    public static TypecastToken make(LocatedChar firstChar, String lexeme) {
        return new TypecastToken(firstChar.getLocation(), lexeme);
    }

    @Override
    protected String rawString() {
        return "typecast";
    }
}
