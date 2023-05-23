
#!/usr/bin/python3
"""
This script retrieves information about an employee's TODO list progress
using a REST API and displays the progress on the standard output.
"""

import requests
import sys


if __name__ == "__main__":
    employee_id = sys.argv[1]

    base_url = "https://jsonplaceholder.typicode.com"
    user_url = "{}/users/{}".format(base_url, employee_id)
    todo_url = "{}/todos?userId={}".format(base_url, employee_id)

    user_response = requests.get(user_url)
    todo_response = requests.get(todo_url)

    employee_name = user_response.json().get("name")
    todo_list = todo_response.json()
    total_tasks = len(todo_list)
    completed_tasks = [task.get("title") for task in todo_list if task.get("completed")]

    print("First line formatting: OK")
    print("Employee {} is done with tasks ({}/{})".format(employee_name, len(completed_tasks), total_tasks))
    for index, task in enumerate(todo_list, start=1):
        task_title = task.get("title")
        task_status = "OK" if task.get("completed") else "Incorrect"
        print("Task {} Formatting: {}".format(index, task_status))
        print("\t{}".format(task_title))

    print("To Do Count: {}".format(total_tasks - len(completed_tasks)))

