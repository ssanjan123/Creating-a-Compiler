package tokens;

import inputHandler.Locator;

public class PunctuationToken extends TokenImp{
    protected char Char;

    protected PunctuationToken(Locator locator, String lexeme) {
        super(locator, lexeme);
        this.Char = lexeme.charAt(0);
    }

    public void setChar(String lexeme) {
        Char = lexeme.charAt(0);
    }

    public char getChar() {
        return Char;
    }





    @Override
    protected String rawString() {
        return null;
    }

    public static PunctuationToken make(Locator locator, String lexeme) {
        PunctuationToken result = new PunctuationToken(locator, lexeme);
        result.setChar(lexeme);
        return result;
    }
}
