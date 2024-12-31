from app.models.user import User
from app.db.sql import SessionLocal

def get_all_users():
    with SessionLocal() as session:
        return session.query(User).all()
