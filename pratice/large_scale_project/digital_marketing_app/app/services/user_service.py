from app.controllers.users import get_all_users
from app.views.users import user_list_view

def list_users():
    users = get_all_users()
    return user_list_view(users)
