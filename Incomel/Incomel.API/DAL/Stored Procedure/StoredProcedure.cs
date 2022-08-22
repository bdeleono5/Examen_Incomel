using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

namespace Incomel.API.DAL.Stored_Procedure
{
    public class StoredProcedure
    {
        private readonly SqlConnection dbConnection;
        public StoredProcedure()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["INCOMEL_CONNECTION"].ConnectionString;
            this.dbConnection = new SqlConnection(connectionString);
        }

        public int ExecuteNonQuery(string cmdText, Parameters parameters)
        {
            var conn = dbConnection;
            var connectionState = conn.State;
            int rowsAffected = 0;

            try
            {
                if (connectionState != ConnectionState.Open)
                {
                    conn.Open();
                    connectionState = conn.State;
                }

                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = cmdText;
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters.Values);
                    }

                    rowsAffected = cmd.ExecuteNonQuery();

                    cmd.Dispose();
                    if (parameters != null)
                    {
                        parameters.Clear();
                        parameters = null;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connectionState != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            return rowsAffected;
        }
        public T ExecuteScalar<T>(string cmdText, Parameters parameters)
        {
            var conn = dbConnection;
            var connectionState = conn.State;
            object result = null;

            try
            {
                if (connectionState != ConnectionState.Open)
                {
                    conn.Open();
                    connectionState = conn.State;
                }

                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = cmdText;
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters.Values);
                    }

                    result = cmd.ExecuteScalar();

                    cmd.Dispose();
                    if (parameters != null) { parameters.Clear(); parameters = null; }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connectionState != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            return (T)result;
        }
        public IList<T> ExecuteDataReader<T>(string cmdText, Parameters parameters)
        {
            IList<T> list = new List<T>();
            var conn = dbConnection;
            var connectionState = conn.State;

            try
            {
                if (connectionState != ConnectionState.Open)
                {
                    conn.Open();
                    connectionState = conn.State;
                }

                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = cmdText;
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters.Values);
                    }

                    var dataReader = cmd.ExecuteReader();

                    while (dataReader.Read())
                    {
                        T obj = Activator.CreateInstance<T>();
                        PropertyInfo[] properties = typeof(T).GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Public | BindingFlags.Instance);

                        foreach (PropertyInfo property in properties)
                        {
                            try
                            {
                                if (dataReader[property.Name] == DBNull.Value)
                                {
                                    property.SetValue(obj, null, new object[] { });
                                }
                                else
                                {
                                    property.SetValue(obj, dataReader[property.Name], new object[] { });
                                }
                            }
                            catch { }
                        }
                        properties = null;
                        list.Add(obj);
                    }

                    dataReader.Close();
                    dataReader = null;
                    cmd.Dispose();
                    if (parameters != null) { parameters.Clear(); parameters = null; }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connectionState != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            return list;
        }
        public DataSet ExecuteDataSetReader(string cmdText, Parameters parameters)
        {
            DataSet dsresult = new DataSet();
            var conn = dbConnection;
            var connectionState = conn.State;

            try
            {
                if (connectionState != ConnectionState.Open)
                {
                    conn.Open();
                    connectionState = conn.State;
                }

                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = cmdText;
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters.Values);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter((SqlCommand)cmd);
                    adapter.Fill(dsresult);

                    adapter.Dispose();
                    adapter = null;
                    cmd.Dispose();
                    if (parameters != null) { parameters.Clear(); parameters = null; }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connectionState != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            return dsresult;
        }
    }
}