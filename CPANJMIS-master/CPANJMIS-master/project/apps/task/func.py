from task.models import task_standard_library
import difflib
from dev.func import CreateLog
from account.models import User

def matchingTask(taskObj):
    str = taskObj.title
    aircraftTypeName = taskObj.aircraft.type.name
    taskList = []
    for obj in task_standard_library.objects.filter(aircraft_type__name=aircraftTypeName):
        similarity = difflib.SequenceMatcher(None, str, obj.title).quick_ratio()
        taskList.append([similarity, obj.id])
    if taskList:
        return max(taskList)
    else:
        return [0,0]