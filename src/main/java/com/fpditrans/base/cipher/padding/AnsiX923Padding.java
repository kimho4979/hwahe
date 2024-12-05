package com.fpditrans.base.cipher.padding;

import com.fpditrans.base.cipher.padding.BlockPadding;

/**
 * @Class Name : AnsiX923Padding.java
 * @Description : AnsiX923Padding Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */
/**
 * This class is.
 * This block is a block cipher algorithm, type the password should be an exact multiple of the size.
 * If you, or an exact multiple of plaintext to be encrypted,
 * encrypting the data before adding padding to support the operation.
 * 'ANSI X.923' padding bytes are supported.
 * 
 * @author devhome.tistory.com
 *
 */
public class AnsiX923Padding extends BlockPadding {
	
	private static final char PADDING_VALUE = 0x00;
	
	@Override
	public String getPaddingType() {
		return ANSIX;
	}

	@Override
	public byte[] addPadding(byte[] source, int blockSize) {

		int paddingCount = blockSize - (source.length % blockSize);
		if( paddingCount == 0 || paddingCount == blockSize ) {
			return source;
		}
		
		byte[] buffer = new byte[ source.length + paddingCount ];
		System.arraycopy(source, 0, buffer, 0, source.length);
		buffer[buffer.length-1] = (byte)paddingCount;
		for( int i = 0; i < (paddingCount-1); i++ ) {
			buffer[source.length + i] = PADDING_VALUE;
		}
		
		return buffer;
	}

	@Override
	public byte[] removePadding(byte[] source, int blockSize) {
		
		int paddingCount = source[source.length-1];
		if( paddingCount >= (blockSize-1) ) {
			return source;
		}
		
		int zeroPaddingCount = paddingCount - 1;
		for( int i = 2; i < (zeroPaddingCount+2); i++ ) {
			if( source[source.length - i] != PADDING_VALUE ) {
				return source;
			}
		}
		
		if( source.length % blockSize == 0 ) {
			if( paddingCount < 0 ) {
				return source;
			}
		}
			
		byte[] buffer = new byte[source.length-paddingCount];
		System.arraycopy(source, 0, buffer, 0, buffer.length);
		return buffer;
	}
}


