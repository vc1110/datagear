/*
 * Copyright (c) 2018 by datagear.org.
 */

package org.datagear.model.support;

/**
 * 抽象字符串ID实体。
 * 
 * @author datagear@163.com
 *
 */
public abstract class AbstractStringIdEntity extends AbstractEntity<String>
{
	private static final long serialVersionUID = 1L;

	public AbstractStringIdEntity()
	{
		super();
	}

	public AbstractStringIdEntity(String id)
	{
		super(id);
	}
}
