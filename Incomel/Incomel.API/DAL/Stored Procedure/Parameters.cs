using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Incomel.API.DAL.Stored_Procedure
{
    public sealed class Parameters : Object
    {
        #region Fields
        private List<SqlParameter> _sqlParameters;
        #endregion

        #region Properties
        private List<SqlParameter> SqlParameters
        {
            get
            {
                return this._sqlParameters;
            }
        }

        public SqlParameter[] Values
        {
            get
            {
                return this.SqlParameters.ToArray();
            }
        }
        #endregion

        #region Methods
        public Parameters()
        {
            this._sqlParameters = new List<SqlParameter>();
        }

        public SqlParameter Add(string parameterName, object value)
        {
            parameterName = "@" + parameterName;
            SqlParameter parameter = new SqlParameter(parameterName, value);
            this.SqlParameters.Add(parameter);
            return parameter;
        }

        public SqlParameter Add(string parameterName, SqlDbType dbType, object value)
        {
            parameterName = "@" + parameterName;
            SqlParameter parameter = new SqlParameter(parameterName, dbType);
            parameter.Value = value;
            this.SqlParameters.Add(parameter);
            return parameter;
        }

        public SqlParameter Add(string parameterName, SqlDbType sqlDbType, ParameterDirection parameterDirection)
        {
            parameterName = "@" + parameterName;
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = parameterName;
            parameter.Direction = parameterDirection;
            parameter.SqlDbType = sqlDbType;
            parameter.Value = DBNull.Value;
            this.SqlParameters.Add(parameter);
            return parameter;
        }

        public void Clear()
        {
            this.SqlParameters.Clear();
        }
        #endregion

        #region Statics
        #endregion
    }
}