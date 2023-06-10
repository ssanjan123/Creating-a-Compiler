package tokens;

import inputHandler.Locator;

public class CharacterToken extends TokenImp {//lexical analyzer needs to throw the error
    protected char value;

    protected CharacterToken(Locator locator, String lexeme) {
        super(locator, lexeme);
    }

    protected void setValue(char value) {
        this.value = value;
    }

    public char getValue() {
        return value;
    }

    public static CharacterToken make(Locator locator, String lexeme) {
        CharacterToken result = new CharacterToken(locator, lexeme);
        if(lexeme.startsWith("'")) {  // literal form
            result.setValue(lexeme.charAt(1));  // take the second character as the value
        } else if (lexeme.startsWith("%")) {  // ascii form
            if (lexeme.length() != 4) {  // % sign plus three octal digits
                throw new IllegalArgumentException("Invalid character literal: " + lexeme);
                //throw new InvalidCharacterInputError();
            }

            String octalString = lexeme.substring(1);  // get the three octal digits
            int asciiValue = Integer.parseInt(octalString, 8);  // convert octal to decimal
            result.setValue((char)asciiValue);  // convert to corresponding character
        }

        else {  // numeric form
            String octalString = lexeme.substring(1);
            if(octalString.length() != 3) { //Change this to 3 and figure out how to take all 3 octal number like %175 instead of now taking just %075
                throw new IllegalArgumentException("Invalid character literal: " + lexeme);
            }
            int code = Integer.parseInt(octalString, 8);  // parse as octal
            result.setValue((char)code);  // convert to corresponding character
        }

        return result;
    }


    @Override
    protected String rawString() {
        return "character, " + value;
    }
}

class InvalidCharacterInputError extends Error{
    InvalidCharacterInputError() {
        //e.printStackTrace();
    }
}