/*
 * Copyright 2018-2023 datagear.tech
 *
 * This file is part of DataGear.
 *
 * DataGear is free software: you can redistribute it and/or modify it under the terms of
 * the GNU Lesser General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later version.
 *
 * DataGear is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with DataGear.
 * If not, see <https://www.gnu.org/licenses/>.
 */

package org.datagear.management.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.datagear.management.domain.SchemaGuard;
import org.datagear.management.domain.User;
import org.datagear.management.service.SchemaGuardService;
import org.datagear.management.util.GuardEntity;
import org.datagear.management.util.SchemaGuardChecker;
import org.datagear.management.util.dialect.MbSqlDialect;
import org.datagear.persistence.Query;
import org.mybatis.spring.SqlSessionTemplate;

/**
 * {@linkplain SchemaGuardService}实现类。
 * 
 * @author datagear@163.com
 *
 */
public class SchemaGuardServiceImpl extends AbstractMybatisEntityService<String, SchemaGuard>
		implements SchemaGuardService
{
	protected static final String SQL_NAMESPACE = SchemaGuard.class.getName();

	private SchemaGuardChecker schemaGuardChecker = new SchemaGuardChecker();

	private volatile List<SchemaGuard> _schemaGuardListCache = null;

	public SchemaGuardServiceImpl()
	{
		super();
	}

	public SchemaGuardServiceImpl(SqlSessionFactory sqlSessionFactory, MbSqlDialect dialect)
	{
		super(sqlSessionFactory, dialect);
	}

	public SchemaGuardServiceImpl(SqlSessionTemplate sqlSessionTemplate, MbSqlDialect dialect)
	{
		super(sqlSessionTemplate, dialect);
	}

	public SchemaGuardChecker getSchemaGuardChecker()
	{
		return schemaGuardChecker;
	}

	public void setSchemaGuardChecker(SchemaGuardChecker schemaGuardChecker)
	{
		this.schemaGuardChecker = schemaGuardChecker;
	}

	@Override
	public boolean isPermitted(GuardEntity guardEntity)
	{
		if (this._schemaGuardListCache == null)
		{
			List<SchemaGuard> schemaGuards = query("getAll", new Query(), buildParamMap(), true);
			SchemaGuard.sortByPriority(schemaGuards);
			this._schemaGuardListCache = Collections.unmodifiableList(new ArrayList<SchemaGuard>(schemaGuards));
		}

		return this.schemaGuardChecker.isPermitted(this._schemaGuardListCache, guardEntity);
	}

	@Override
	public boolean isPermitted(User user, GuardEntity guardEntity)
	{
		if (user.isAdmin())
			return true;

		return this.isPermitted(guardEntity);
	}

	@Override
	protected boolean update(SchemaGuard entity, Map<String, Object> params)
	{
		boolean re = super.update(entity, params);

		this._schemaGuardListCache = null;

		return re;
	}

	@Override
	protected boolean deleteById(String id, Map<String, Object> params)
	{
		boolean re = super.deleteById(id, params);

		this._schemaGuardListCache = null;

		return re;
	}

	@Override
	protected void add(SchemaGuard entity, Map<String, Object> params)
	{
		super.add(entity, params);

		this._schemaGuardListCache = null;
	}

	@Override
	protected String getSqlNamespace()
	{
		return SQL_NAMESPACE;
	}
}
