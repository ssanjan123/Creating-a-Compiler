package symbolTable;


// how a scope allocates offsets to its constituent memory blocks.
public interface MemoryAllocator {
	public String getBaseAddress();
	public MemoryLocation allocate(int sizeInBytes);
	public default MemoryLocation allocateStringRecord(int length) {
		int totalBytes = 4 + 4 + 4 + length + 1;
		return allocate(totalBytes);
	}

	public void saveState();
	public void restoreState();
	public int getMaxAllocatedSize();
	}
