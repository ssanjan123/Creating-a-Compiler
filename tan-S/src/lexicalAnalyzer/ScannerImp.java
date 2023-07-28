package lexicalAnalyzer;

import java.util.LinkedList;
import java.util.Queue;
import inputHandler.PushbackCharStream;
import tokens.NullToken;
import tokens.Token;

public abstract class ScannerImp implements Scanner {
	private Queue<Token> upcomingTokens;
	protected final PushbackCharStream input;

	protected abstract Token findNextToken();

	public ScannerImp(PushbackCharStream input) {
		super();
		this.input = input;
		this.upcomingTokens = new LinkedList<>();

		// Fill the queue with the first few tokens
		for (int i = 0; i < 3; i++) {
			upcomingTokens.add(findNextToken());
		}
	}

	// Iterator<Token> implementation
	@Override
	public boolean hasNext() {
		return !(upcomingTokens.peek() instanceof NullToken);
	}

	@Override
	public Token next() {
		Token nextToken = upcomingTokens.poll(); // Remove the next token from the queue
		upcomingTokens.add(findNextToken()); // Add the next token to the end of the queue
		return nextToken;
	}

	@Override
	public void remove() {
		throw new UnsupportedOperationException();
	}

	@Override
	public Token peekToken(int n) {
		if (n < 0 || n >= upcomingTokens.size()) {
			throw new IllegalArgumentException("Invalid argument to peekToken: " + n);
		}

		// We can't directly access an element in a Queue by index, so we'll have to iterate through it
		int i = 0;
		for (Token token : upcomingTokens) {
			if (i == n) {
				return token;
			}
			i++;
		}

		// This should never happen if the method is used correctly
		throw new IllegalStateException("Unexpected state in peekToken");
	}
}
