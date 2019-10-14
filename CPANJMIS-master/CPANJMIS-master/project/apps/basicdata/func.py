
def belongToDepartment(user,department_id):
    try:
        userDepartment = user.department
        while(userDepartment):
            if userDepartment.id == department_id:
                return True
            userDepartment = userDepartment.super_department
    except:
        pass
    return False