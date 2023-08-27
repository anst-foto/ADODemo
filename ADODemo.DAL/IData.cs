using ADODemo.Models;

namespace ADODemo.DAL;

public interface IData
{
    public IEnumerable<Role> GetAllRoles();
    public Role GetRoleById(int id);
    
    public IEnumerable<Account> GetAllAccounts();
    public Account GetAccountById(int id);
    public Account GetAccountByLogin(string login);
    
    public IEnumerable<User> GetAllUsers();
    public User GetUserById(int id);
}