import StudiTimer
todo_location = "/home/johannes/.local/share/calcurse/todo"

#mode is dict entry in data
def mode_to_st(mode:dict) -> str:
    elapsed_h = mode["elapsed"] // 3600
    goal_h = mode["goal"] // 3600
    sign = "\u274C"
    if elapsed_h >= goal_h:
        sign = "\u2705"

    output = "[1] {0} {1:10s} {2:6>s}h".format(sign,mode["name"],f"{elapsed_h}/{goal_h}")
    return output

def add_mode(mode):
    st = ""
    with open(todo_location,"r") as reader:
        st = reader.read()

    st = mode_to_st(mode) + "\n"+  st

    with open(todo_location,"w") as writer:
        writer = writer.write(st)



if __name__ == "__main__":
    data = StudiTimer.getData()
    st = ""

    with open(todo_location,"r") as reader:
        st = reader.read()

    l = st.splitlines()
    #print(mode_to_st(data["modes"][0]))
    for i in range(len(l)):
        if i < len(data["modes"]):
            l[i] = mode_to_st(data["modes"][i])


    with open(todo_location,"w") as writer:
        writer.write("\n".join(l))

    """
    print("\u2705")
    print("\u274C")
    """
        





