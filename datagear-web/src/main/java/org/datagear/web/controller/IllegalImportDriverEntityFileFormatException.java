/*
 * Copyright (c) 2018 by datagear.org.
 */

package org.datagear.web.controller;

import org.datagear.connection.DriverEntity;

/**
 * 导入{@linkplain DriverEntity}文件格式非法异常。
 * 
 * @author datagear@163.com
 *
 */
public class IllegalImportDriverEntityFileFormatException extends ControllerException
{
	private static final long serialVersionUID = 1L;

	public IllegalImportDriverEntityFileFormatException()
	{
		super();
	}

	public IllegalImportDriverEntityFileFormatException(String message)
	{
		super(message);
	}

	public IllegalImportDriverEntityFileFormatException(Throwable cause)
	{
		super(cause);
	}

	public IllegalImportDriverEntityFileFormatException(String message, Throwable cause)
	{
		super(message, cause);
	}
}
