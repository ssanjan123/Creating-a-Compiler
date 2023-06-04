package lexicalAnalyzer;


import logging.TanLogger;

import inputHandler.InputHandler;
import inputHandler.LocatedChar;
import inputHandler.LocatedCharStream;
import inputHandler.PushbackCharStream;
import tokens.*;

import static lexicalAnalyzer.PunctuatorScanningAids.*;

public class LexicalAnalyzer extends ScannerImp implements Scanner {
	public static LexicalAnalyzer make(String filename) {
		InputHandler handler = InputHandler.fromFilename(filename);
		PushbackCharStream charStream = PushbackCharStream.make(handler);
		return new LexicalAnalyzer(charStream);
	}

	public LexicalAnalyzer(PushbackCharStream input) {
		super(input);
	}

	
	//////////////////////////////////////////////////////////////////////////////
	// Token-finding main dispatch	

	@Override
	protected Token findNextToken() {
		LocatedChar ch = nextNonWhitespaceChar();
		if(ch.isDigit()) {
			return scanNumber(ch);
		}
		else if(ch.isLowerCase() || ch.isUpperCase() || ch.getCharacter() == '@') {
			return scanIdentifier(ch);
		}
		else if(ch.isSingleQuote() || ch.isPercentSign()) {    // new condition here
			return scanCharacterLiteral(ch);
		}
		else if(isPunctuatorStart(ch)) {
			return PunctuatorScanner.scan(ch, input);
		}
		else if(isEndOfInput(ch)) {
			return NullToken.make(ch);
		}
		else if(ch.isDoubleQuote()) { // for strings
			return scanStringLiteral(ch);
		}
		else {
			lexicalError(ch);
			return findNextToken();
		}
	}

	private Token scanCharacterLiteral(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();

		if(firstChar.isSingleQuote()) {
			buffer.append(firstChar.getCharacter()); // append the starting quote to the buffer
			LocatedChar c = input.next();
			if(c.isSingleQuote()) {
				LocatedChar next = input.next();
				if(next.isSingleQuote()) {
					buffer.append("'");
				} else {
					lexicalError(next);
					return findNextToken();
				}
			} else {
				buffer.append(c.getCharacter());
			}
			LocatedChar trailingQuote = input.next();
			if(!trailingQuote.isSingleQuote()) {
				lexicalError(trailingQuote);
				return findNextToken();
			} else {
				buffer.append(trailingQuote.getCharacter()); // append the ending quote to the buffer
			}
		}else { // it's a percent sign
			// Append the percent sign to the buffer
			buffer.append(firstChar.getCharacter());

			// Read next three octal digits
			for(int i = 0; i < 3; ++i) {
				LocatedChar c = input.next();
				if(c.isOctalDigit()) {
					buffer.append(c.getCharacter());
				} else {
					lexicalError(c);
					return findNextToken();
				}
			}
			// Check if we read exactly three digits
			if (buffer.length() != 4) { // It should be 4, including the percent sign
				lexicalError(firstChar);
				return findNextToken();
			}
		}




		return CharacterToken.make(firstChar, buffer.toString());
	}

	private Token scanStringLiteral(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(firstChar.getCharacter()); // append the starting double quote to the buffer

		LocatedChar c = input.next();
		while (!c.isDoubleQuote() && !isEndOfInput(c)) {
			buffer.append(c.getCharacter());
			c = input.next();
		}

		if (c.isDoubleQuote()) {
			buffer.append(c.getCharacter()); // append the ending double quote to the buffer
		} else {
			lexicalError(c);
			return findNextToken();
		}

		return StringToken.make(firstChar, buffer.toString());
	}
	private LocatedChar nextNonWhitespaceChar() {
		LocatedChar ch = input.next();
		while(ch.isWhitespace()) {
			ch = input.next();
		}
		return ch;
	}

	
	//////////////////////////////////////////////////////////////////////////////
	// Integer lexical analysis	

	private Token scanNumber(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(firstChar.getCharacter());
		appendSubsequentDigits(buffer);

		// Check if next character is a dot (.) for float
		LocatedChar c = input.next();
		if (c.getCharacter() == '.') {
			buffer.append(c.getCharacter());
			appendSubsequentDigits(buffer);
			// Here we will return a new FloatToken instead of NumberToken
			return FloatToken.make(firstChar, buffer.toString());
		} else {
			input.pushback(c);
		}

		return NumberToken.make(firstChar, buffer.toString());
	}
	private void appendSubsequentDigits(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(c.isDigit()) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
		input.pushback(c);
	}
	
	
	//////////////////////////////////////////////////////////////////////////////
	// Identifier and keyword lexical analysis	

	private Token scanIdentifier(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(firstChar.getCharacter());
		appendSubsequentIdentifierCharacters(buffer);

		String lexeme = buffer.toString();
		if(Keyword.isAKeyword(lexeme) || isTypeKeyword(lexeme)) {
			return LextantToken.make(firstChar, lexeme, Keyword.forLexeme(lexeme));
		}
		else {
			return IdentifierToken.make(firstChar, lexeme);
		}
	}

	private void appendSubsequentIdentifierCharacters(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(isValidIdentifierCharacter(c)) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
		input.pushback(c);
	}
	private boolean isValidIdentifierCharacter(LocatedChar c) {
		return c.isLowerCase() || c.isUpperCase() || c.isDigit() || c.isUnderscore() || c.isAtSymbol();
	}

	private boolean isTypeKeyword(String lexeme) {
		return lexeme.equals("int") || lexeme.equals("char") || lexeme.equals("float") || lexeme.equals("bool");
	}

	private void appendSubsequentLowercase(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(c.isLowerCase()) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
		input.pushback(c);
	}
	
	
	//////////////////////////////////////////////////////////////////////////////
	// Punctuator lexical analysis	
	// old method left in to show a simple scanning method.
	// current method is the algorithm object PunctuatorScanner.java

	@SuppressWarnings("unused")
	private Token oldScanPunctuator(LocatedChar ch) {
		
		switch(ch.getCharacter()) {
			case '<':
				return LextantToken.make(ch, "<", Punctuator.LESS);

			case '*':
				return LextantToken.make(ch, "*", Punctuator.MULTIPLY);
			case '+':
				return LextantToken.make(ch, "+", Punctuator.ADD);
			case '>':
				return LextantToken.make(ch, ">", Punctuator.GREATER);
			case ':':
				if(ch.getCharacter()=='=') {
					return LextantToken.make(ch, ":=", Punctuator.ASSIGN);
				}
				else {
					lexicalError(ch);
					return(NullToken.make(ch));
				}
			case ',':
				return LextantToken.make(ch, ",", Punctuator.PRINT_SEPARATOR);
			case ';':
				return LextantToken.make(ch, ";", Punctuator.TERMINATOR);
		default:
			lexicalError(ch);
			return(NullToken.make(ch));
		}
	}

	

	//////////////////////////////////////////////////////////////////////////////
	// Character-classification routines specific to tan scanning.	

	private boolean isPunctuatorStart(LocatedChar lc) {
		char c = lc.getCharacter();
		return isPunctuatorStartingCharacter(c) || c == '<' || c == '>';
	}

	private boolean isEndOfInput(LocatedChar lc) {
		return lc == LocatedCharStream.FLAG_END_OF_INPUT;
	}
	
	
	//////////////////////////////////////////////////////////////////////////////
	// Error-reporting	

	private void lexicalError(LocatedChar ch) {
		TanLogger log = TanLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: invalid character " + ch);
	}

	
}
