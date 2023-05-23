
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
    user_url = f"{base_url}/users/{employee_id}"
    todo_url = f"{base_url}/todos?userId={employee_id}"

    user_response = requests.get(user_url)
    todo_response = requests.get(todo_url)

    employee_name = user_response.json().get("name")
    todo_list = todo_response.json()
    total_tasks = len(todo_list)
    completed_tasks = [task.get("title") for task in todo_list if task.get("completed")]

    print(f"Employee {employee_name} is done with tasks({len(completed_tasks)}/{total_tasks}):")
    for task in completed_tasks:
        print(f"\t{task}")

