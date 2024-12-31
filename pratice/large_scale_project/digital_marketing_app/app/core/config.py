from pydantic import BaseSettings

class Settings(BaseSettings):
    sql_database_url: str
    nosql_database_url: str
    secret_key: str
    debug: bool = True

    class Config:
        env_file = ".env"

settings = Settings()
