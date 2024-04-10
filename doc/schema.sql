CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "role" varchar NOT NULL DEFAULT 'depositor',
  "hashed_password" varchar NOT NULL,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "phone" varchar UNIQUE NOT NULL,
  "is_email_verified" bool NOT NULL DEFAULT false,
  "password_changed_at" timestamptz NOT NULL DEFAULT '0001-01-01',
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar NOT NULL,
  "body" varchar NOT NULL,
  "created_by" varchar NOT NULL,
  "create_at" timestampz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "post_comments" (
  "id" integer PRIMARY KEY,
  "of_post" integer NOT NULL,
  "body" varchar NOT NULL,
  "created_by" varchar NOT NULL,
  "create_at" timestampz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "verify_emails" (
  "id" bigserial PRIMARY KEY,
  "username" varchar NOT NULL,
  "email" varchar NOT NULL,
  "secret_code" varchar NOT NULL,
  "is_used" bool NOT NULL DEFAULT false,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "expired_at" timestamptz NOT NULL DEFAULT (now() + interval '15 minutes')
);

CREATE TABLE "sessions" (
  "id" uuid PRIMARY KEY,
  "username" varchar NOT NULL,
  "refresh_token" varchar NOT NULL,
  "user_agent" varchar NOT NULL,
  "client_ip" varchar NOT NULL,
  "is_blocked" boolean NOT NULL DEFAULT false,
  "expires_at" timestamptz NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE "posts" ADD FOREIGN KEY ("created_by") REFERENCES "users" ("username");

ALTER TABLE "post_comments" ADD FOREIGN KEY ("of_post") REFERENCES "posts" ("id");

ALTER TABLE "post_comments" ADD FOREIGN KEY ("created_by") REFERENCES "users" ("username");

ALTER TABLE "verify_emails" ADD FOREIGN KEY ("username") REFERENCES "users" ("username");

ALTER TABLE "sessions" ADD FOREIGN KEY ("username") REFERENCES "users" ("username");
