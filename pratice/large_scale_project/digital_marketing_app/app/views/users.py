from fastapi.responses import JSONResponse

def user_list_view(users):
    return JSONResponse(content={"users": users})
