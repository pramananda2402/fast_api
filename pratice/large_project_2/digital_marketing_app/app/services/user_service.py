from app.controllers.users import get_users
from app.views.users import format_user_response

def fetch_users():
    users = get_users()
    return format_user_response(users)
