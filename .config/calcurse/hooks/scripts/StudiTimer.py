import json
import datetime
import argparse
import updateGoals

dataLocation = "/home/johannes/Programs/SoSe2023Timer/data.json"

class TimeObj():
    def __init__(self):
        self.DBS = 0 #seconds
        self.CG = 0
        self.CN = 0

class Session():
    def __init__(self,typ,start,end=None) -> None:
        self.typ = typ
        self.start = start
        self.end = end
    def calcLength(self):
        td = self.end - self.start
        return td.days * 24 * 60 * 60 + td.seconds



class Mode():
    def __init__(self,goal,elapsed=0):
        self.goal = goal
        self.elapsed = elapsed


DBS_goal = 75*60*60
CN_goal = 75*60*60
CG_goal = 75*60*60
X =datetime.timedelta()

def storeData(data):
    with open(dataLocation,"w") as writer:
        json.dump(data,writer)

def getData():
    data = None
    with open(dataLocation) as reader:
        data = json.load(reader)
    
    return data


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = "UDP chat client")
    parser.add_argument("--mode",required = True, help="Port where chat server is waiting for connection")
    parser.add_argument("--add",required = False,action="store_true", help="Port where chat server is waiting for connection")
    args = vars(parser.parse_args())
    print(args)



    
    A = Mode(70)
    data = getData()
    #print(json.dumps(data))

    getData()
    if args["add"]:
        """
        name = input("Enter name of mode:\n")
        """
        name = args["mode"]
        for x in data["modes"]:
            if x["name"] == name:
                print("mode has already been added")
                exit()

        goal = input("Enter the amount of hours:\n")
        try:
            goal = int(goal)
            goal *= 3600 
        except ValueError:
            print("ivalid input")
            exit()

        new = {"name":name,"goal":goal,"elapsed":0}
        data["modes"].append(new)
        updateGoals.add_mode(new)
        storeData(data)


    else:
        if data["running"] == True:
            if args["mode"] != data["currentmode"]:
                print(f"wrong mode\ncurrent mode is {data['currentmode']}")
                exit()
            print("stopping")
            start_dt = datetime.datetime.fromisoformat(data["start"])
            stop_dt = datetime.datetime.now()
            diff = stop_dt - start_dt
            elapsed = round(diff.total_seconds())
            print(start_dt - stop_dt)
            print(type(start_dt - stop_dt))
            print(elapsed)
            print(round(elapsed))
            data["running"] = False

            for i in range(len(data["modes"])):
                if data["modes"][i]["name"] == args["mode"]:
                    data["modes"][i]["elapsed"] += elapsed

            storeData(data)
        else:
            print("starting")
            data["running"] = True
            data["start"] = datetime.datetime.isoformat(datetime.datetime.now())
            data["currentmode"] = args["mode"]

            
            storeData(data)
            

        
        
    
