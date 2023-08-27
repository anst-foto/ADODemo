using ADODemo.Models;

namespace ADODemo.DAL;

//BUG
public class TestContext : IData
{
    public IEnumerable<Role> GetAllRoles()
    {
        return new List<Role>()
        {
            new Role()
            {
                Id = 0,
                Name = "role_1"
            },
            new Role()
            {
                Id = 1,
                Name = "role_2"
            }
        };
    }

    public Role GetRoleById(int id)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Account> GetAllAccounts()
    {
        throw new NotImplementedException();
    }

    public Account GetAccountById(int id)
    {
        throw new NotImplementedException();
    }

    public Account GetAccountByLogin(string login)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<User> GetAllUsers()
    {
        throw new NotImplementedException();
    }

    public User GetUserById(int id)
    {
        throw new NotImplementedException();
    }
}