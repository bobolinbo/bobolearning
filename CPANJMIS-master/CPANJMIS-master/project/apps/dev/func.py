import json
from .models import LogData

def CreateLog(user,model="",action="others",content="",termInfo=None):
    content = content if isinstance(content,str) else json.dumps(content, ensure_ascii=False, indent=4)
    termInfo = termInfo if isinstance(termInfo,str) else json.dumps(termInfo, ensure_ascii=False, indent=4)
    tmp = LogData(operater=user,model=model,action=action,content=content,termInfo=termInfo)
    tmp.save()
    return True