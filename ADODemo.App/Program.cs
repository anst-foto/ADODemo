using ADODemo.DAL;

IData db = new TestContext();
var roles = db.GetAllRoles();
foreach (var role in roles)
{
    Console.WriteLine($"{role.Id}: {role.Name}");
}