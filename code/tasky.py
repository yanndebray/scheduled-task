from yaml import safe_load, safe_dump

def load_yaml(yaml_str):
    return safe_load(yaml_str)

def set_name(data, name):
    data['env']['task_name'] = name
    return data

def set_schedule(data, schedule):
    data['env']['task_schedule'] = f'"{schedule}"'
    return data

def set_output(data, output):
    data['env']['task_output'] = output
    return data

# def correct_format(data):
#     data['on'] = data.pop(True)
#     return data

def dump_yaml(data, filename):
    s = safe_dump(data)
    s = s.replace('true:', 'on:')
    with open(filename, 'w') as f:
        f.write(s)

if __name__ == '__main__':
    import json
    with open('taskTemplate.yml', 'r') as file:
        data = load_yaml(file)
    # save as json
    #with open('taskTemplate.json', 'w') as file:
    #    json.dump(data, file, indent=4)
    # data = correct_format(data)
    # print(data.keys())
    data = set_name(data, 'task1')
    data = set_schedule(data, '0 0 * * *')
    data = set_output(data, 'Data/')
    # print(data['env'])
    print(f"name: {data['env']['task_name']}")
    print(f"schedule: {data['env']['task_schedule']}")
    print(f"output: {data['env']['task_output']}")
    dump_yaml(data, ".github/workflows/task42.yml")