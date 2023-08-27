using System.Data;
using System.Data.SqlTypes;
using ADODemo.Models;
using Npgsql;

namespace ADODemo.DAL;

public class DbContext
{
    private const string ConnectionString = "Host=localhost;Username=postgres;Password=1234;Database=accounts_db";

    private readonly NpgsqlConnection _db;

    public DbContext()
    {
        _db = new NpgsqlConnection(ConnectionString);
    }

    public IEnumerable<Role> GetAllRoles()
    {
        _db.Open();
        var sql = "SELECT id, name FROM table_roles";
        var command = new NpgsqlCommand(sql, _db);
        var result = command.ExecuteReader();

        var roles = new List<Role>();
        if (result.HasRows)
        {
            while (result.Read())
            {
                roles.Add(new Role
                {
                    Id = result.GetInt32("id"),
                    Name = result.GetString("name")
                });
            }
        }
        else
        {
            throw new SqlNullValueException();
        }
        
        _db.Close();

        return roles;
    }
}