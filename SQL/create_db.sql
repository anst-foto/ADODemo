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
