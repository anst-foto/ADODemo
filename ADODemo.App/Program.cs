using ADODemo.DAL;

var db = new DbContext();
var roles = db.GetAllRoles();
foreach (var role in roles)
{
    Console.WriteLine($"{role.Id}: {role.Name}");
}