CREATE TABLE roles
(
    id   BIGSERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE users
(
    id       BIGSERIAL PRIMARY KEY,
    username VARCHAR(255),
    email    VARCHAR(255),
    password VARCHAR(255),
    role_id  BIGINT,
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles (id)
);

CREATE TABLE categories
(
    category_id BIGSERIAL PRIMARY KEY,
    name        VARCHAR(255) UNIQUE
);

CREATE TABLE stats
(
    stat_id  BIGSERIAL PRIMARY KEY,
    counter_counter BIGINT,
    category_id     BIGINT,
    id              BIGINT,
    CONSTRAINT fk_stats_category FOREIGN KEY (category_id) REFERENCES categories (category_id),
    CONSTRAINT fk_stats_user FOREIGN KEY (id) REFERENCES users (id)
);

CREATE TABLE key_words
(
    key_words_id BIGSERIAL PRIMARY KEY,
    words        VARCHAR(255),
    category_id  BIGINT,
    id           BIGINT,
    CONSTRAINT fk_key_words_category FOREIGN KEY (category_id) REFERENCES categories (category_id),
    CONSTRAINT fk_key_words_user FOREIGN KEY (id) REFERENCES users (id)
);

CREATE TABLE waves
(
    id      BIGSERIAL PRIMARY KEY,
    count_waves INT,
    user_id     BIGINT,
    CONSTRAINT fk_waves_user FOREIGN KEY (user_id) REFERENCES users (id)
);
