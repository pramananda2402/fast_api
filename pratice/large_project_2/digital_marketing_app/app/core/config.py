from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Digital Marketing App"
    secret_key: str = "supersecretkey"
    debug: bool = True

    class Config:
        env_file = ".env"

settings = Settings()
