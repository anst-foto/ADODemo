CREATE TABLE table_roles (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE table_accounts (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    login TEXT NOT NULL,
    password TEXT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES table_roles(id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE table_users (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NULL,
    FOREIGN KEY (id) REFERENCES table_accounts(id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO table_roles (name) VALUES ('guest'), ('user'), ('admin');

INSERT INTO table_accounts (login, password, role_id) VALUES ('user1', '12345', (SELECT id FROM table_roles WHERE name = 'guest'));
INSERT INTO table_users (first_name, last_name) VALUES ('anonim', 'anonimus');

INSERT INTO table_accounts (login, password, role_id) VALUES ('user', '12345', (SELECT id FROM table_roles WHERE name = 'user'));
INSERT INTO table_users (first_name, last_name, email) VALUES ('user', 'user', 'user@mail.mail');

INSERT INTO table_accounts (login, password, role_id) VALUES ('admin', '123', (SELECT id FROM table_roles WHERE name = 'admin'));
INSERT INTO table_users (first_name, last_name, email) VALUES ('admin', 'user', 'admin@mail.mail');

CREATE PROCEDURE procedure_insert_user (IN login_arg TEXT, IN password_arg TEXT, IN role_name_arg TEXT, IN first_name_arg TEXT, IN last_name_arg TEXT, IN email_arg TEXT)
LANGUAGE SQL
BEGIN ATOMIC
    INSERT INTO table_accounts (login, password, role_id) VALUES (login_arg, password_arg, (SELECT id FROM table_roles WHERE name = role_name_arg));
    INSERT INTO table_users (first_name, last_name, email) VALUES (first_name_arg, last_name_arg, email_arg);
END;

-- CALL procedure_insert_user('admin', '12345', 'admin', 'admin', 'admin', 'adm@adm');

CREATE VIEW view_acoounts AS
SELECT last_name, first_name,
       login, password,
       table_roles.name AS role_name,
       email
FROM table_users
JOIN table_accounts
    ON table_users.id = table_accounts.id
JOIN table_roles
    ON table_accounts.role_id = table_roles.id;

-- LOG
CREATE TABLE table_log (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    table_name TEXT NOT NULL,
    action_name TEXT NOT NULL,
    comment TEXT NULL
);

CREATE PROCEDURE procedure_log(IN table_name_arg TEXT, IN action_name_arg TEXT, IN comment_arg TEXT)
LANGUAGE SQL
BEGIN ATOMIC
    INSERT INTO table_log(table_name, action_name, comment) VALUES (table_name_arg, action_name_arg, comment_arg);
END;

CREATE FUNCTION function_log_for_table_roles()
RETURNS trigger AS
$$
    BEGIN
        CALL procedure_log('table_roles', 'insert', concat(NEW.id, ' ', NEW.name));
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_for_table_roles
AFTER INSERT ON table_roles
FOR EACH ROW
EXECUTE FUNCTION function_log_for_table_roles();