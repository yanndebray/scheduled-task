function t = scheduleTask(filepath,schedule,outputdata)
    % schedule = "daily" or "weekly" or "monthly"
    % schedule = "*/5 * * * *" % every 5 minutes
    % schedule = "0 0 * * *" % every day at midnight
    % schedule = "0 0 * * 0" % every Sunday at midnight
    % schedule = "0 0 1 * *" % every 1st of the month at midnight
    % schedule = "0 0 1 1 *" % every 1st of January at midnight
    % task = "task1.m"
    % task = "task2.mlx"
    % scheduleTask(task,schedule)

    arguments
        filepath (1,:) char {mustBeFile}
        schedule (1,:) char {mustBeText}
        outputdata (1,:) char = ''
    end

    % Create a task
    % t = taskScheduler;
    [folder, taskname, ext] = fileparts(filepath);
    t.Name = taskname;
    t.ExecutionTime = schedule;
    t.OutputData = outputdata;
    t.TimeZone = 'local';

    % Load taskTemplate.yml
    % taskTemplate = yaml.loadFile('taskTemplate.yml');
    yaml_str = fileread('taskTemplate.yml');
    % % Python version
    % data = py.tasky.load_yaml(yaml_str);
    % data = py.tasky.set_name(data, 'task1');
    % data = py.tasky.set_schedule(data, '0 0 * * *');
    % data = py.tasky.set_output(data, 'Data/');
    % py.tasky.dump_yaml(data, ".github/workflows/"+taskname+".yml")

    % Matlab version
    yaml_str = replace(yaml_str,"<task_name>",taskname);
    yaml_str = replace(yaml_str,"<task_schedule>","'"+schedule+"'");
    yaml_str = replace(yaml_str,"<task_output>",outputdata);

    % Write to file
    fileID = fopen(".github/workflows/"+taskname+".yml", 'w');
    fprintf(fileID, '%s', yaml_str);
    fclose(fileID);
end