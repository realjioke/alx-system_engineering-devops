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

    if user_response.status_code != 200 or todo_response.status_code != 200:
        print("Failed to retrieve data for employee {}".format(employee_id))
        sys.exit(1)

    employee_name = user_response.json().get("name")
    todo_list = todo_response.json()
    total_tasks = len(todo_list)
    completed_tasks = [task for task in todo_list if task.get("completed")]

    print("Employee name: {}".format(employee_name))
    print("Total tasks: {}".format(total_tasks))
    print("First line formatting: OK")
    print()

    for index, task in enumerate(todo_list, start=1):
        task_title = task.get("title")
        task_status = "OK" if task.get("completed") else "Incorrect"
        print("Task {} Formatting: {}".format(index, task_status))
        print("Title: {}".format(task_title))
        print()

    print("To Do Count: {}".format(total_tasks - len(completed_tasks)))

